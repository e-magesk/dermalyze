import 'dart:io';
import 'dart:typed_data';

import 'package:dermalyze/src/features/analysis/service/inference_service.dart';
import 'package:dermalyze/src/features/analysis/service/ood_onnx_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;

/// Valor normalizado esperado, como `ToTensor()` + `Normalize()` do torchvision.
double _norm(int value, double mean, double std) => ((value / 255.0) - mean) / std;

void main() {
  group('isAcceptedOodScore (OOD v2)', () {
    test('limiar é 2,48', () {
      expect(kOodAcceptanceThreshold, 2.48);
    });

    test('aceita a partir do limiar, inclusive', () {
      expect(isAcceptedOodScore(2.48), isTrue);
      expect(isAcceptedOodScore(3.9), isTrue);
    });

    test('rejeita abaixo do limiar', () {
      expect(isAcceptedOodScore(2.4799), isFalse);
      // O limiar do v1 (1,5) não vale mais para o v2.
      expect(isAcceptedOodScore(1.6), isFalse);
    });
  });

  group('imageNetTensorChw', () {
    test('normaliza com média e desvio do ImageNet em layout CHW', () {
      // Dois pixels: (255, 0, 128) e (0, 255, 64).
      final rgb = Uint8List.fromList([255, 0, 128, 0, 255, 64]);
      final tensor = imageNetTensorChw(rgb, 2, 1);

      expect(tensor.length, 6);
      // Plano R, depois G, depois B — cada um com os dois pixels em sequência.
      expect(tensor[0], closeTo(_norm(255, 0.485, 0.229), 1e-5));
      expect(tensor[1], closeTo(_norm(0, 0.485, 0.229), 1e-5));
      expect(tensor[2], closeTo(_norm(0, 0.456, 0.224), 1e-5));
      expect(tensor[3], closeTo(_norm(255, 0.456, 0.224), 1e-5));
      expect(tensor[4], closeTo(_norm(128, 0.406, 0.225), 1e-5));
      expect(tensor[5], closeTo(_norm(64, 0.406, 0.225), 1e-5));
    });
  });

  group('prepareOodInput', () {
    late Directory tempDir;

    setUp(() => tempDir = Directory.systemTemp.createTempSync('dermalyze_ood_test'));
    tearDown(() {
      try {
        tempDir.deleteSync(recursive: true);
      } on FileSystemException {
        // Lixo em diretório temporário não justifica quebrar o teste.
      }
    });

    File writePng(img.Image image, String name) {
      final file = File(p.join(tempDir.path, name));
      file.writeAsBytesSync(img.encodePng(image));
      return file;
    }

    test('gera o tensor 1x3x224x224 a partir de uma foto de qualquer tamanho', () {
      // PNG (sem perdas), para conferir os valores exatos depois do resize.
      final image = img.Image(width: 640, height: 480);
      img.fill(image, color: img.ColorRgb8(200, 100, 50));
      final file = writePng(image, 'cor_unica.png');

      final tensor = prepareOodInput(file.path)!;

      const plane = 224 * 224;
      expect(tensor.length, 3 * plane);
      expect(tensor[0], closeTo(_norm(200, 0.485, 0.229), 1e-5));
      expect(tensor[plane - 1], closeTo(_norm(200, 0.485, 0.229), 1e-5));
      expect(tensor[plane], closeTo(_norm(100, 0.456, 0.224), 1e-5));
      expect(tensor[3 * plane - 1], closeTo(_norm(50, 0.406, 0.225), 1e-5));
    });

    test('descarta o canal alfa, como o convert("RGB") do PIL', () {
      final image = img.Image(width: 300, height: 300, numChannels: 4);
      img.fill(image, color: img.ColorRgba8(10, 20, 30, 128));
      final file = writePng(image, 'com_alfa.png');

      final tensor = prepareOodInput(file.path)!;

      expect(tensor.length, 3 * 224 * 224);
      expect(tensor[0], closeTo(_norm(10, 0.485, 0.229), 1e-5));
    });

    test('devolve null para arquivo que não é imagem', () {
      final file = File(p.join(tempDir.path, 'quebrado.jpg'));
      file.writeAsStringSync('isto não é uma imagem');

      expect(prepareOodInput(file.path), isNull);
    });
  });
}
