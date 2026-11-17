import 'dart:io';
import 'package:dermalyze/src/features/analysis/service/pil_resize.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_onnxruntime/flutter_onnxruntime.dart';
import 'package:image/image.dart' as img;

/// Lado da imagem de entrada do modelo OOD.
const int kOodInputSize = 224;

// Normalização do ImageNet, a mesma do `ImgEvalTransform` usado no treino.
const List<double> _mean = [0.485, 0.456, 0.406];
const List<double> _std = [0.229, 0.224, 0.225];

/// Converte pixels RGB de 8 bits no tensor CHW que o modelo espera: o mesmo
/// que `ToTensor()` (÷255) seguido de `Normalize(mean, std)` no torchvision.
Float32List imageNetTensorChw(Uint8List rgb, int width, int height) {
  final plane = width * height;
  final tensor = Float32List(3 * plane);

  for (var i = 0; i < plane; i++) {
    final p = i * 3;
    tensor[i] = ((rgb[p] / 255.0) - _mean[0]) / _std[0];
    tensor[i + plane] = ((rgb[p + 1] / 255.0) - _mean[1]) / _std[1];
    tensor[i + plane * 2] = ((rgb[p + 2] / 255.0) - _mean[2]) / _std[2];
  }
  return tensor;
}

/// Prepara a entrada do modelo a partir do arquivo da foto, reproduzindo o
/// `ImgEvalTransform` do treino: `Resize((224, 224))` bilinear com antialias
/// (como o Pillow), `ToTensor` e `Normalize` do ImageNet.
///
/// É uma função de nível superior para rodar em `compute`: decodificar e
/// redimensionar a foto na thread de UI congelava o spinner de validação.
Float32List? prepareOodInput(String imagePath) {
  final decoded = img.decodeImage(File(imagePath).readAsBytesSync());
  if (decoded == null) return null;

  // Equivalente ao `.convert('RGB')` do PIL: 8 bits, 3 canais, sem alfa.
  final image = (decoded.format == img.Format.uint8 && decoded.numChannels == 3)
      ? decoded
      : decoded.convert(format: img.Format.uint8, numChannels: 3);

  final rgb = image.getBytes(order: img.ChannelOrder.rgb);
  if (rgb.length != image.width * image.height * 3) {
    throw StateError('Formato de pixel inesperado: ${rgb.length} bytes para ${image.width}x${image.height}');
  }

  final resized = resizePilBilinear(rgb, image.width, image.height, kOodInputSize, kOodInputSize);
  return imageNetTensorChw(resized, kOodInputSize, kOodInputSize);
}

/// Modelo que avalia se a foto serve para análise (nitidez, se é uma lesão de
/// pele etc.). Devolve um score de qualidade em que maior é melhor.
class OodOnnxService {
  static final OodOnnxService _instance = OodOnnxService._internal();
  factory OodOnnxService() => _instance;
  OodOnnxService._internal();

  OrtSession? _session;
  String? _inputName;

  Future<void> initModel() async {
    if (_session != null) return;

    final ort = OnnxRuntime();
    _session = await ort.createSessionFromAsset('assets/models/ood_model_v2.onnx');
    _inputName = _session?.inputNames[0];
  }

  Future<double?> predictQualityScore(String imagePath) async {
    await initModel();

    final inputData = await compute(prepareOodInput, imagePath);
    if (inputData == null) return null;

    // A sessão do ONNX Runtime é um plugin nativo: precisa rodar na thread principal.
    final inputOrt = await OrtValue.fromList(
      inputData,
      [1, 3, kOodInputSize, kOodInputSize],
    );

    final inputs = {_inputName!: inputOrt};

    try {
      final outputs = await _session!.run(inputs, options: OrtRunOptions());

      final outputName = _session!.outputNames[0];
      final rawOutput = await outputs[outputName]!.asFlattenedList();
      final double score = rawOutput[0].toDouble(); // Regressão simples

      await inputOrt.dispose();
      await outputs[outputName]!.dispose();

      return score;

    } catch (e) {
      debugPrint("Erro na inferência OOD: $e");
      await inputOrt.dispose();
      return null;
    }
  }

  // O dispose da sessão precisa ser async agora
  Future<void> dispose() async {
    await _session?.close();
    _session = null;
  }
}
