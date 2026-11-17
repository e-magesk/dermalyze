import 'dart:typed_data';

import 'package:dermalyze/src/features/analysis/service/pil_resize.dart';
import 'package:flutter_test/flutter_test.dart';

/// Imagem RGB em que os três canais têm o mesmo valor em cada pixel.
Uint8List _gray(List<int> values) {
  final rgb = Uint8List(values.length * 3);
  for (var i = 0; i < values.length; i++) {
    rgb[i * 3] = values[i];
    rgb[i * 3 + 1] = values[i];
    rgb[i * 3 + 2] = values[i];
  }
  return rgb;
}

/// Primeiro canal de cada pixel.
List<int> _firstChannel(Uint8List rgb) => [for (var i = 0; i < rgb.length; i += 3) rgb[i]];

// Os valores esperados foram calculados à mão seguindo o algoritmo do Pillow
// (libImaging/Resample.c): centro em (x + 0,5) * escala, filtro triangular com
// suporte = escala ao reduzir, pesos normalizados e convertidos para ponto
// fixo de 22 bits, e arredondamento somando metade antes do deslocamento.
void main() {
  group('resizePilBilinear', () {
    test('reduz 4→2 com antialias (3 pixels de entrada por pixel de saída)', () {
      // Saída 0: pesos 0,75/0,75/0,25 normalizados → 0·3/7 + 100·3/7 + 200·1/7 = 71,43
      // Saída 1: pesos 0,25/0,75/0,75 normalizados → 100·1/7 + 200·3/7 + 255·3/7 = 209,29
      final out = resizePilBilinear(_gray([0, 100, 200, 255]), 4, 1, 2, 1);
      expect(_firstChannel(out), [71, 209]);
    });

    test('amplia 2→4 com o bilinear clássico', () {
      // 0,75·0 + 0,25·200 = 50 e 0,25·0 + 0,75·200 = 150 (50,5 e 150,5 após
      // somar a metade de arredondamento, truncados para 50 e 150).
      final out = resizePilBilinear(_gray([0, 200]), 2, 1, 4, 1);
      expect(_firstChannel(out), [0, 50, 150, 200]);
    });

    test('arredonda para 8 bits entre a passada horizontal e a vertical', () {
      // Horizontal: [10, 21] → 15,5 → 16 e [31, 42] → 36,5 → 37.
      // Vertical: (16 + 37) / 2 = 26,5 → 27. Numa passada só daria 26.
      final out = resizePilBilinear(_gray([10, 21, 31, 42]), 2, 2, 1, 1);
      expect(_firstChannel(out), [27]);
    });

    test('canais são processados de forma independente', () {
      final rgb = Uint8List.fromList([0, 255, 10, 100, 255, 20, 200, 255, 30, 255, 255, 40]);
      final out = resizePilBilinear(rgb, 4, 1, 2, 1);
      expect(out.sublist(0, 3), [71, 255, 17]);
      expect(out.sublist(3, 6), [209, 255, 33]);
    });

    test('imagem de cor única continua da mesma cor na redução para 224x224', () {
      const width = 1000, height = 750;
      final rgb = Uint8List(width * height * 3);
      for (var i = 0; i < rgb.length; i += 3) {
        rgb[i] = 200;
        rgb[i + 1] = 100;
        rgb[i + 2] = 37;
      }

      final out = resizePilBilinear(rgb, width, height, 224, 224);

      expect(out.length, 224 * 224 * 3);
      for (var i = 0; i < out.length; i += 3) {
        expect([out[i], out[i + 1], out[i + 2]], [200, 100, 37], reason: 'pixel ${i ~/ 3}');
      }
    });

    test('mesmo tamanho devolve uma cópia idêntica', () {
      final rgb = _gray([1, 2, 3, 4]);
      final out = resizePilBilinear(rgb, 2, 2, 2, 2);
      expect(out, rgb);
      expect(identical(out, rgb), isFalse);
    });

    test('recusa buffer com tamanho incompatível com as dimensões', () {
      expect(
        () => resizePilBilinear(Uint8List(10), 2, 2, 1, 1),
        throwsArgumentError,
      );
    });
  });
}
