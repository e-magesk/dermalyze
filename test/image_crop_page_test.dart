import 'dart:io';

import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/shared/widgets/app_image_crop_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;

/// Grava um JPEG real em disco para a tela decodificar.
File _writeSampleJpeg(Directory dir, {required int width, required int height}) {
  final image = img.Image(width: width, height: height);
  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      image.setPixelRgb(x, y, x % 255, y % 255, (x + y) % 255);
    }
  }

  final file = File(p.join(dir.path, 'lesao_${width}x$height.jpg'));
  file.writeAsBytesSync(img.encodeJpg(image, quality: 90));
  return file;
}

Future<void> _pumpCropPage(WidgetTester tester, String sourcePath) async {
  final app = MaterialApp(
    locale: const Locale('pt'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: ImageCropPage(sourcePath: sourcePath),
  );

  // A decodificação da imagem é I/O real: precisa do relógio de verdade, por
  // isso a montagem acontece dentro do runAsync.
  await tester.runAsync(() async {
    await tester.pumpWidget(app);
    await Future<void>.delayed(const Duration(milliseconds: 500));
  });

  // Fora do runAsync não dá para usar pumpAndSettle: o CircularProgressIndicator
  // anima para sempre e o settle estouraria justamente no caso que queremos
  // detectar — a tela presa carregando.
  await tester.pump();
  await tester.pump();
}

void main() {
  late Directory tempDir;

  setUp(() => tempDir = Directory.systemTemp.createTempSync('dermalyze_crop_test'));
  tearDown(() {
    // No Windows o arquivo pode seguir aberto pelo cache de imagens.
    try {
      tempDir.deleteSync(recursive: true);
    } on FileSystemException {
      // Lixo em diretório temporário não justifica quebrar o teste.
    }
  });

  group('ImageCropPage', () {
    // Regressão: a tela abria e ficava presa em "Processando imagem..." porque
    // a preparação decodificava e reescrevia a foto inteira em Dart.
    testWidgets('sai do estado de processamento ao abrir', (tester) async {
      final file = _writeSampleJpeg(tempDir, width: 1200, height: 900);

      await _pumpCropPage(tester, file.path);

      expect(
        find.text('Processando imagem...'),
        findsNothing,
        reason: 'a tela não pode ficar presa carregando',
      );
      expect(find.text('CONFIRMAR'), findsOneWidget);
      expect(find.byType(InteractiveViewer), findsOneWidget);
    });

    testWidgets('confirmar fica disponível assim que a imagem carrega', (tester) async {
      final file = _writeSampleJpeg(tempDir, width: 1200, height: 900);

      await _pumpCropPage(tester, file.path);

      final confirm = tester.widget<ElevatedButton>(
        find.ancestor(of: find.text('CONFIRMAR'), matching: find.byType(ElevatedButton)),
      );
      expect(confirm.onPressed, isNotNull);
    });

    testWidgets('cancelar continua disponível para sair da tela', (tester) async {
      final file = _writeSampleJpeg(tempDir, width: 900, height: 1200);

      await _pumpCropPage(tester, file.path);

      final cancel = tester.widget<ElevatedButton>(
        find.ancestor(of: find.text('CANCELAR'), matching: find.byType(ElevatedButton)),
      );
      expect(cancel.onPressed, isNotNull);
    });

    testWidgets('mostra erro em vez de carregar para sempre com arquivo inválido', (tester) async {
      final broken = File(p.join(tempDir.path, 'quebrado.jpg'));
      broken.writeAsStringSync('isto não é uma imagem');

      await _pumpCropPage(tester, broken.path);

      expect(find.text('Processando imagem...'), findsNothing);
      expect(
        find.textContaining('Não foi possível abrir a imagem'),
        findsOneWidget,
        reason: 'arquivo inválido precisa virar erro visível, não spinner eterno',
      );
    });
  });
}
