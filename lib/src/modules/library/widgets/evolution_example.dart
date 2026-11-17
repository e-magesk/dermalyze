import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Ilustração da letra E (Evolução) do ABCDE.
///
/// Antes eram duas manchas lado a lado, que pareciam duas lesões diferentes.
/// Agora é sempre uma única mancha: parada em "Estável" e crescendo em loop em
/// "Mudando", com o contorno pontilhado do tamanho original para deixar claro
/// que é a mesma lesão aumentando.
class EvolutionExample extends StatefulWidget {
  /// `true` para "Mudando"; `false` para "Estável".
  final bool changing;

  const EvolutionExample({super.key, required this.changing});

  @override
  State<EvolutionExample> createState() => _EvolutionExampleState();
}

class _EvolutionExampleState extends State<EvolutionExample> with SingleTickerProviderStateMixin {
  // Raio relativo ao lado da área: inicial e máximo.
  static const double _startRadius = 0.18;
  static const double _endRadius = 0.36;

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncAnimation();
  }

  @override
  void didUpdateWidget(covariant EvolutionExample oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncAnimation();
  }

  /// Sem animação quando o sistema pede para reduzir movimento: a mancha
  /// aparece já no tamanho final, ao lado do contorno original.
  bool get _reduceMotion => MediaQuery.maybeDisableAnimationsOf(context) ?? false;

  void _syncAnimation() {
    if (widget.changing && !_reduceMotion) {
      if (!_controller.isAnimating) _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.changing) {
      return const CustomPaint(painter: _LesionPainter(radius: _startRadius, showOrigin: false));
    }

    if (_reduceMotion) {
      return const CustomPaint(painter: _LesionPainter(radius: _endRadius, showOrigin: true));
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        // Cresce em 70% do ciclo e segura o tamanho máximo antes de recomeçar.
        final growth = Curves.easeInOut.transform(math.min(_controller.value / 0.7, 1.0));
        final radius = _startRadius + (_endRadius - _startRadius) * growth;
        return CustomPaint(painter: _LesionPainter(radius: radius, showOrigin: true));
      },
    );
  }
}

class _LesionPainter extends CustomPainter {
  /// Raio relativo ao menor lado da área.
  final double radius;

  /// Desenha o contorno pontilhado do tamanho original da mancha.
  final bool showOrigin;

  const _LesionPainter({required this.radius, required this.showOrigin});

  static const Color _lesion = Color(0xFF6B3A28);
  static const Color _origin = Color(0xFF94A3B8);

  @override
  void paint(Canvas canvas, Size size) {
    final side = math.min(size.width, size.height);
    final center = size.center(Offset.zero);

    canvas.drawCircle(center, side * radius, Paint()..color = _lesion);

    if (showOrigin) {
      _drawDashedCircle(canvas, center, side * _EvolutionExampleState._startRadius);
    }
  }

  void _drawDashedCircle(Canvas canvas, Offset center, double r) {
    final paint = Paint()
      ..color = _origin
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    const dashes = 16;
    const sweep = math.pi * 2 / dashes;
    final rect = Rect.fromCircle(center: center, radius: r);
    for (var i = 0; i < dashes; i++) {
      canvas.drawArc(rect, i * sweep, sweep * 0.55, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _LesionPainter oldDelegate) =>
      oldDelegate.radius != radius || oldDelegate.showOrigin != showOrigin;
}
