import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:dermalyze/src/shared/widgets/crop_geometry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Tela de recorte quadrado da lesão.
///
/// Substitui a tela nativa do UCrop (image_cropper), cujo botão de confirmar
/// fica fixo no canto superior direito — exatamente onde o dermatoscópio é
/// acoplado ao tablet, escondendo o botão. Aqui todos os controles de ação
/// ficam na barra inferior, fora do alcance do acessório.
///
/// Retorna via [Navigator.pop] o caminho do arquivo recortado, ou `null` se o
/// usuário cancelar.
class ImageCropPage extends StatefulWidget {
  final String sourcePath;

  const ImageCropPage({super.key, required this.sourcePath});

  @override
  State<ImageCropPage> createState() => _ImageCropPageState();
}

class _ImageCropPageState extends State<ImageCropPage> {
  final TransformationController _transformation = TransformationController();

  String? _currentPath;
  int _imageWidth = 0;
  int _imageHeight = 0;

  // Métricas do enquadramento, recalculadas sempre que o viewport ou a
  // imagem de origem mudam.
  double? _viewportSide;
  double _coverScale = 1;
  double _displayWidth = 0;
  double _displayHeight = 0;

  bool _isProcessing = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadImage(widget.sourcePath);
  }

  @override
  void dispose() {
    _transformation.dispose();
    super.dispose();
  }

  /// Carrega a imagem para exibição, lendo apenas suas dimensões.
  ///
  /// A decodificação fica com o engine do Flutter (nativo), e não com o pacote
  /// `image`. Decodificar a foto cheia em Dart era lento e, pior, alocava a
  /// imagem em RGBA (uma foto de 12MP ocupa ~48MB, duplicados pela cópia da
  /// orientação): o isolate do `compute` podia ser morto por falta de memória
  /// no tablet e a tela ficava presa em "processando" para sempre.
  ///
  /// O redimensionamento agora vem pronto do `image_picker`, também nativo.
  ///
  /// Como o engine aplica a orientação do EXIF ao decodificar, o recorte final
  /// aplica `bakeOrientation` antes de cortar — assim os dois lados enxergam a
  /// imagem do mesmo jeito.
  Future<void> _loadImage(String path) async {
    try {
      final size = await _readImageSize(path);

      if (!mounted) return;

      _applyImage(_ImageResult(path: path, width: size.width, height: size.height));
      setState(() => _isProcessing = false);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _hasError = true;
      });
    }
  }

  /// Dimensões da imagem como o Flutter a exibe (orientação do EXIF já aplicada).
  Future<({int width, int height})> _readImageSize(String path) {
    final completer = Completer<({int width, int height})>();
    final stream = FileImage(File(path)).resolve(const ImageConfiguration());

    late final ImageStreamListener listener;
    listener = ImageStreamListener(
      (info, _) {
        stream.removeListener(listener);
        final size = (width: info.image.width, height: info.image.height);
        info.dispose();
        if (!completer.isCompleted) completer.complete(size);
      },
      onError: (error, stackTrace) {
        stream.removeListener(listener);
        if (!completer.isCompleted) completer.completeError(error, stackTrace);
      },
    );

    stream.addListener(listener);
    return completer.future;
  }

  Future<String> _buildTempPath(String prefix) async {
    final dir = await getTemporaryDirectory();
    final stamp = DateTime.now().microsecondsSinceEpoch;
    return p.join(dir.path, 'dermalyze_${prefix}_$stamp.jpg');
  }

  /// Troca a imagem em exibição e recentraliza o enquadramento.
  /// Sempre chamado fora do `build`, por isso pode mexer no controller direto.
  void _applyImage(_ImageResult result) {
    _currentPath = result.path;
    _imageWidth = result.width;
    _imageHeight = result.height;

    final side = _viewportSide;
    if (side != null) {
      _recomputeMetrics(side);
      _transformation.value = _centeredMatrix();
    }
  }

  void _recomputeMetrics(double side) {
    _viewportSide = side;
    _coverScale = math.max(side / _imageWidth, side / _imageHeight);
    // O `math.max` protege contra arredondamento de ponto flutuante: o child
    // nunca pode ficar menor que a moldura, senão o InteractiveViewer não
    // consegue respeitar o boundaryMargin zero.
    _displayWidth = math.max(_imageWidth * _coverScale, side);
    _displayHeight = math.max(_imageHeight * _coverScale, side);
  }

  Matrix4 _centeredMatrix() {
    final side = _viewportSide!;
    return Matrix4.identity()
      ..translateByDouble(
        -(_displayWidth - side) / 2,
        -(_displayHeight - side) / 2,
        0,
        1,
      );
  }

  Future<void> _onRotate() async {
    final source = _currentPath;
    if (source == null || _isProcessing) return;

    setState(() => _isProcessing = true);

    try {
      final outputPath = await _buildTempPath('rot');
      final result = await compute(
        _rotateImageTask,
        _RotateRequest(
          sourcePath: source,
          outputPath: outputPath,
          angle: 90,
        ),
      );

      if (!mounted) return;

      if (result == null) {
        setState(() => _isProcessing = false);
        return;
      }

      await _loadImage(result.path);
    } catch (_) {
      if (!mounted) return;
      setState(() => _isProcessing = false);
    }
  }

  Future<void> _onConfirm() async {
    final source = _currentPath;
    final side = _viewportSide;
    if (source == null || side == null || _isProcessing) return;

    final region = resolveCropRegion(
      matrix: _transformation.value,
      viewportSide: side,
      coverScale: _coverScale,
      imageWidth: _imageWidth,
      imageHeight: _imageHeight,
    );

    setState(() => _isProcessing = true);

    try {
      final outputPath = await _buildTempPath('crop');
      final result = await compute(
        _cropImageTask,
        _CropRequest(
          sourcePath: source,
          outputPath: outputPath,
          x: region.x,
          y: region.y,
          size: region.size,
        ),
      );

      if (!mounted) return;

      if (result == null) {
        setState(() {
          _isProcessing = false;
          _hasError = true;
        });
        return;
      }

      Navigator.of(context).pop(result.path);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.textDark,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(l10n),
            Expanded(child: _buildStage(l10n)),
            _buildFooter(l10n),
          ],
        ),
      ),
    );
  }

  // Topo puramente informativo: nenhum controle fica sob o dermatoscópio.
  Widget _buildHeader(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.cropTitle,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.cropHint,
            style: const TextStyle(
              color: AppColors.textLight,
              fontSize: 13,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStage(AppLocalizations l10n) {
    if (_hasError) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.broken_image_outlined, color: AppColors.textLight, size: 48),
              const SizedBox(height: 16),
              Text(
                l10n.cropErrorLoad,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textLight, fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
      );
    }

    if (_currentPath == null) {
      return _buildSpinner(l10n);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final side = math.min(constraints.maxWidth, constraints.maxHeight) - 32;
        if (side <= 0) return const SizedBox.shrink();

        _syncViewport(side);

        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: side,
                  height: side,
                  child: InteractiveViewer(
                    transformationController: _transformation,
                    constrained: false,
                    boundaryMargin: EdgeInsets.zero,
                    minScale: 1.0,
                    maxScale: 8.0,
                    child: SizedBox(
                      width: _displayWidth,
                      height: _displayHeight,
                      child: Image.file(
                        File(_currentPath!),
                        fit: BoxFit.fill,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),
                  ),
                ),
              ),
              IgnorePointer(
                child: CustomPaint(
                  size: Size(side, side),
                  painter: _CropGridPainter(),
                ),
              ),
              if (_isProcessing)
                Container(
                  width: side,
                  height: side,
                  decoration: BoxDecoration(
                    color: AppColors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: _buildSpinner(l10n),
                ),
            ],
          ),
        );
      },
    );
  }

  /// Mantém as métricas em dia quando o tamanho disponível muda (ex.: rotação
  /// do tablet). Na primeira passagem o InteractiveViewer ainda não existe,
  /// então dá para ajustar a matriz direto; depois disso só após o frame.
  void _syncViewport(double side) {
    if (_viewportSide == side) return;

    final isFirstLayout = _viewportSide == null;
    _recomputeMetrics(side);

    if (isFirstLayout) {
      _transformation.value = _centeredMatrix();
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _transformation.value = _centeredMatrix();
      });
    }
  }

  Widget _buildSpinner(AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(color: AppColors.primary),
          const SizedBox(height: 16),
          Text(
            l10n.cropProcessing,
            style: const TextStyle(color: AppColors.textLight, fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  // Todas as ações ficam aqui embaixo, longe do dermatoscópio.
  Widget _buildFooter(AppLocalizations l10n) {
    final canAct = !_isProcessing && !_hasError && _currentPath != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: _footerButton(
              label: l10n.cropBtnCancel,
              // Fica ativo mesmo processando: é a saída garantida caso o
              // processamento demore ou falhe.
              onPressed: () => Navigator.of(context).pop(),
              background: AppColors.white.withValues(alpha: 0.08),
              foreground: AppColors.white,
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 56,
            height: 56,
            child: ElevatedButton(
              onPressed: canAct ? _onRotate : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white.withValues(alpha: 0.08),
                disabledBackgroundColor: AppColors.white.withValues(alpha: 0.04),
                foregroundColor: AppColors.white,
                elevation: 0,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: const Icon(Icons.rotate_90_degrees_cw_outlined, size: 22),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: _footerButton(
              label: l10n.cropBtnConfirm,
              onPressed: canAct ? _onConfirm : null,
              background: AppColors.primary,
              foreground: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerButton({
    required String label,
    required VoidCallback? onPressed,
    required Color background,
    required Color foreground,
  }) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          disabledBackgroundColor: background.withValues(alpha: 0.4),
          foregroundColor: foreground,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 1.2),
        ),
      ),
    );
  }
}

/// Linhas de terço sobre a moldura, para ajudar a centralizar a lesão.
class _CropGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final border = Paint()
      ..color = AppColors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final grid = Paint()
      ..color = AppColors.white.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final rect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(16),
    );
    canvas.drawRRect(rect, border);

    for (var i = 1; i < 3; i++) {
      final dx = size.width * i / 3;
      final dy = size.height * i / 3;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), grid);
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), grid);
    }
  }

  @override
  bool shouldRepaint(covariant _CropGridPainter oldDelegate) => false;
}

// --- Processamento fora da thread de UI ---------------------------------

class _ImageResult {
  final String path;
  final int width;
  final int height;

  const _ImageResult({required this.path, required this.width, required this.height});
}

class _RotateRequest {
  final String sourcePath;
  final String outputPath;
  final int angle;

  const _RotateRequest({
    required this.sourcePath,
    required this.outputPath,
    required this.angle,
  });
}

class _CropRequest {
  final String sourcePath;
  final String outputPath;
  final int x;
  final int y;
  final int size;

  const _CropRequest({
    required this.sourcePath,
    required this.outputPath,
    required this.x,
    required this.y,
    required this.size,
  });
}

Future<_ImageResult?> _rotateImageTask(_RotateRequest request) async {
  final decoded = img.decodeImage(await File(request.sourcePath).readAsBytes());
  if (decoded == null) return null;

  // Mesma razão do recorte: parte-se do que o usuário está vendo.
  final oriented = img.bakeOrientation(decoded);

  return _writeJpg(img.copyRotate(oriented, angle: request.angle), request.outputPath);
}

Future<_ImageResult?> _cropImageTask(_CropRequest request) async {
  final decoded = img.decodeImage(await File(request.sourcePath).readAsBytes());
  if (decoded == null) return null;

  // O preview usa o decodificador do engine, que aplica a orientação do EXIF.
  // Aqui os pixels vêm crus, então a orientação precisa ser aplicada antes do
  // corte para a região recortada ser a mesma que o usuário enquadrou.
  final oriented = img.bakeOrientation(decoded);

  final cropped = img.copyCrop(
    oriented,
    x: request.x,
    y: request.y,
    width: request.size,
    height: request.size,
  );

  return _writeJpg(cropped, request.outputPath);
}

Future<_ImageResult> _writeJpg(img.Image image, String outputPath) async {
  // O EXIF é descartado: a orientação já foi aplicada aos pixels.
  image.exif = img.ExifData();
  await File(outputPath).writeAsBytes(img.encodeJpg(image, quality: 95));
  return _ImageResult(path: outputPath, width: image.width, height: image.height);
}
