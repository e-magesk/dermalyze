import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Região quadrada, em pixels da imagem de origem, que será recortada.
class CropRegion {
  final int x;
  final int y;
  final int size;

  const CropRegion({required this.x, required this.y, required this.size});

  @override
  bool operator ==(Object other) =>
      other is CropRegion && other.x == x && other.y == y && other.size == size;

  @override
  int get hashCode => Object.hash(x, y, size);

  @override
  String toString() => 'CropRegion(x: $x, y: $y, size: $size)';
}

/// Converte o trecho visível dentro da moldura quadrada do recorte para
/// coordenadas de pixel da imagem de origem.
///
/// [matrix] é a transformação do `InteractiveViewer`, cujo child tem o tamanho
/// da imagem multiplicado por [coverScale] (a escala em que a imagem cobre a
/// moldura de lado [viewportSide]).
CropRegion resolveCropRegion({
  required Matrix4 matrix,
  required double viewportSide,
  required double coverScale,
  required int imageWidth,
  required int imageHeight,
}) {
  final scale = matrix.getMaxScaleOnAxis();
  final translateX = matrix.storage[12];
  final translateY = matrix.storage[13];

  // Retângulo visível em coordenadas do child do InteractiveViewer...
  final childX = -translateX / scale;
  final childY = -translateY / scale;
  final childSide = viewportSide / scale;

  // ...convertido para pixels da imagem.
  var x = (childX / coverScale).round();
  var y = (childY / coverScale).round();
  var size = (childSide / coverScale).round();

  x = x.clamp(0, math.max(0, imageWidth - 1));
  y = y.clamp(0, math.max(0, imageHeight - 1));
  size = math.min(size, math.min(imageWidth - x, imageHeight - y));
  size = math.max(size, 1);

  return CropRegion(x: x, y: y, size: size);
}
