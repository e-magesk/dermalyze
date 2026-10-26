import 'package:dermalyze/src/shared/widgets/crop_geometry.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// Reproduz o que a tela de recorte faz: a imagem é escalada para cobrir a
/// moldura quadrada e centralizada dentro dela.
({Matrix4 matrix, double coverScale}) centeredCover({
  required double viewportSide,
  required int imageWidth,
  required int imageHeight,
}) {
  final coverScale = [
    viewportSide / imageWidth,
    viewportSide / imageHeight,
  ].reduce((a, b) => a > b ? a : b);

  final displayWidth = imageWidth * coverScale;
  final displayHeight = imageHeight * coverScale;

  final matrix = Matrix4.identity()
    ..translateByDouble(
      -(displayWidth - viewportSide) / 2,
      -(displayHeight - viewportSide) / 2,
      0,
      1,
    );

  return (matrix: matrix, coverScale: coverScale);
}

void main() {
  group('resolveCropRegion', () {
    test('imagem quadrada sem ajuste recorta a imagem inteira', () {
      const side = 400.0;
      final setup = centeredCover(viewportSide: side, imageWidth: 2048, imageHeight: 2048);

      final region = resolveCropRegion(
        matrix: setup.matrix,
        viewportSide: side,
        coverScale: setup.coverScale,
        imageWidth: 2048,
        imageHeight: 2048,
      );

      expect(region, const CropRegion(x: 0, y: 0, size: 2048));
    });

    test('imagem paisagem sem ajuste recorta o quadrado central', () {
      const side = 400.0;
      final setup = centeredCover(viewportSide: side, imageWidth: 2048, imageHeight: 1536);

      final region = resolveCropRegion(
        matrix: setup.matrix,
        viewportSide: side,
        coverScale: setup.coverScale,
        imageWidth: 2048,
        imageHeight: 1536,
      );

      // Altura inteira, centralizado na horizontal: (2048 - 1536) / 2 = 256.
      expect(region, const CropRegion(x: 256, y: 0, size: 1536));
    });

    test('imagem retrato sem ajuste recorta o quadrado central', () {
      const side = 400.0;
      final setup = centeredCover(viewportSide: side, imageWidth: 1536, imageHeight: 2048);

      final region = resolveCropRegion(
        matrix: setup.matrix,
        viewportSide: side,
        coverScale: setup.coverScale,
        imageWidth: 1536,
        imageHeight: 2048,
      );

      expect(region, const CropRegion(x: 0, y: 256, size: 1536));
    });

    test('zoom de 2x no centro recorta metade do lado', () {
      const side = 400.0;
      const imageSize = 2000;
      final setup = centeredCover(viewportSide: side, imageWidth: imageSize, imageHeight: imageSize);

      // Zoom 2x mantendo o centro da moldura: a área visível cai pela metade.
      final zoomed = Matrix4.identity()
        ..translateByDouble(-side / 2, -side / 2, 0, 1)
        ..scaleByDouble(2.0, 2.0, 1.0, 1.0)
        ..multiply(setup.matrix);

      final region = resolveCropRegion(
        matrix: zoomed,
        viewportSide: side,
        coverScale: setup.coverScale,
        imageWidth: imageSize,
        imageHeight: imageSize,
      );

      expect(region.size, 1000);
      expect(region.x, 500);
      expect(region.y, 500);
    });

    test('deslocamento para o canto superior esquerdo recorta a origem', () {
      const side = 400.0;
      const imageWidth = 2048;
      const imageHeight = 1536;
      final coverScale = side / imageHeight;

      // Sem translação: a moldura mostra o canto superior esquerdo do child.
      final region = resolveCropRegion(
        matrix: Matrix4.identity(),
        viewportSide: side,
        coverScale: coverScale,
        imageWidth: imageWidth,
        imageHeight: imageHeight,
      );

      expect(region, const CropRegion(x: 0, y: 0, size: 1536));
    });

    test('regiao nunca ultrapassa os limites da imagem', () {
      const side = 400.0;
      const imageWidth = 1000;
      const imageHeight = 1000;

      // Matriz forçando um recorte que começaria fora da imagem.
      final matrix = Matrix4.identity()..translateByDouble(-10000, -10000, 0, 1);

      final region = resolveCropRegion(
        matrix: matrix,
        viewportSide: side,
        coverScale: side / imageWidth,
        imageWidth: imageWidth,
        imageHeight: imageHeight,
      );

      expect(region.x + region.size, lessThanOrEqualTo(imageWidth));
      expect(region.y + region.size, lessThanOrEqualTo(imageHeight));
      expect(region.size, greaterThan(0));
    });
  });
}
