import 'dart:math' as math;
import 'dart:typed_data';

/// Redimensionamento equivalente ao `Image.resize(size, Image.BILINEAR)` do
/// Pillow, que é o que o `torchvision.transforms.Resize` usa sobre imagens PIL
/// no treino dos modelos.
///
/// O BILINEAR do Pillow não é o bilinear de 4 vizinhos: ao reduzir, o filtro
/// triangular tem suporte proporcional ao fator de redução (antialias), e a
/// imagem é processada em duas passadas — horizontal e depois vertical — com
/// arredondamento para 8 bits entre elas. Este código replica o algoritmo de
/// `libImaging/Resample.c`, inclusive os pesos em ponto fixo, para que a
/// entrada do modelo no app seja a mesma do treino.
///
/// [rgb] traz os pixels intercalados (r, g, b, r, g, b, ...), 8 bits por canal.
Uint8List resizePilBilinear(
  Uint8List rgb,
  int inWidth,
  int inHeight,
  int outWidth,
  int outHeight,
) {
  if (rgb.length != inWidth * inHeight * _channels) {
    throw ArgumentError.value(rgb.length, 'rgb.length', 'esperado ${inWidth * inHeight * _channels}');
  }

  var current = rgb;
  var currentWidth = inWidth;

  // Como no Pillow, cada passada só acontece se aquela dimensão mudar.
  if (outWidth != inWidth) {
    current = _resampleHorizontal(current, inWidth, inHeight, outWidth, _precompute(inWidth, outWidth));
    currentWidth = outWidth;
  }
  if (outHeight != inHeight) {
    current = _resampleVertical(current, currentWidth, inHeight, outHeight, _precompute(inHeight, outHeight));
  }

  return identical(current, rgb) ? Uint8List.fromList(rgb) : current;
}

const int _channels = 3;

/// Precisão dos pesos em ponto fixo, igual à do Pillow (`PRECISION_BITS`).
const int _precisionBits = 32 - 8 - 2;

class _Coefficients {
  /// Quantidade máxima de pixels de entrada que contribuem para um de saída.
  final int kernelSize;

  /// Para cada pixel de saída: primeiro pixel de entrada e quantos contribuem.
  final Int32List bounds;

  /// Para cada pixel de saída: [kernelSize] pesos em ponto fixo.
  final Int32List weights;

  const _Coefficients(this.kernelSize, this.bounds, this.weights);
}

double _bilinearFilter(double x) {
  final distance = x.abs();
  return distance < 1.0 ? 1.0 - distance : 0.0;
}

/// Equivalente a `precompute_coeffs` + `normalize_coeffs_8bpc` do Pillow.
_Coefficients _precompute(int inSize, int outSize) {
  final scale = inSize / outSize;
  // Ao reduzir, o filtro alarga junto com a escala: é isso que faz o antialias.
  final filterScale = math.max(scale, 1.0);
  final support = 1.0 * filterScale; // suporte do filtro bilinear = 1
  final kernelSize = support.ceil() * 2 + 1;
  final inverseScale = 1.0 / filterScale;

  final bounds = Int32List(outSize * 2);
  final weights = Int32List(outSize * kernelSize);
  final raw = Float64List(kernelSize);

  for (var out = 0; out < outSize; out++) {
    final center = (out + 0.5) * scale;

    // `truncate` reproduz o cast `(int)` do C, que arredonda em direção a zero.
    var first = (center - support + 0.5).truncate();
    if (first < 0) first = 0;
    var last = (center + support + 0.5).truncate();
    if (last > inSize) last = inSize;
    final count = last - first;

    var total = 0.0;
    for (var i = 0; i < count; i++) {
      final weight = _bilinearFilter((i + first - center + 0.5) * inverseScale);
      raw[i] = weight;
      total += weight;
    }

    for (var i = 0; i < kernelSize; i++) {
      final weight = (i < count && total != 0.0) ? raw[i] / total : 0.0;
      final scaled = weight * (1 << _precisionBits);
      weights[out * kernelSize + i] = (weight < 0 ? scaled - 0.5 : scaled + 0.5).truncate();
    }

    bounds[out * 2] = first;
    bounds[out * 2 + 1] = count;
  }

  return _Coefficients(kernelSize, bounds, weights);
}

/// Volta do ponto fixo para 8 bits, saturando em 0..255 (o `clip8` do Pillow).
int _clip8(int value) {
  final v = value >> _precisionBits;
  if (v < 0) return 0;
  if (v > 255) return 255;
  return v;
}

Uint8List _resampleHorizontal(Uint8List src, int inWidth, int height, int outWidth, _Coefficients c) {
  final out = Uint8List(outWidth * height * _channels);
  const half = 1 << (_precisionBits - 1); // arredondamento

  for (var y = 0; y < height; y++) {
    final rowIn = y * inWidth * _channels;
    final rowOut = y * outWidth * _channels;

    for (var x = 0; x < outWidth; x++) {
      final first = c.bounds[x * 2];
      final count = c.bounds[x * 2 + 1];
      final kernel = x * c.kernelSize;

      var r = half, g = half, b = half;
      for (var i = 0; i < count; i++) {
        final weight = c.weights[kernel + i];
        final p = rowIn + (first + i) * _channels;
        r += src[p] * weight;
        g += src[p + 1] * weight;
        b += src[p + 2] * weight;
      }

      final o = rowOut + x * _channels;
      out[o] = _clip8(r);
      out[o + 1] = _clip8(g);
      out[o + 2] = _clip8(b);
    }
  }
  return out;
}

Uint8List _resampleVertical(Uint8List src, int width, int inHeight, int outHeight, _Coefficients c) {
  final out = Uint8List(width * outHeight * _channels);
  final rowStride = width * _channels;
  const half = 1 << (_precisionBits - 1); // arredondamento

  for (var y = 0; y < outHeight; y++) {
    final first = c.bounds[y * 2];
    final count = c.bounds[y * 2 + 1];
    final kernel = y * c.kernelSize;

    for (var x = 0; x < width; x++) {
      final column = x * _channels;

      var r = half, g = half, b = half;
      for (var i = 0; i < count; i++) {
        final weight = c.weights[kernel + i];
        final p = (first + i) * rowStride + column;
        r += src[p] * weight;
        g += src[p + 1] * weight;
        b += src[p + 2] * weight;
      }

      final o = y * rowStride + column;
      out[o] = _clip8(r);
      out[o + 1] = _clip8(g);
      out[o + 2] = _clip8(b);
    }
  }
  return out;
}
