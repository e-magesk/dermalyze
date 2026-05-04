import 'package:flutter/material.dart';

class BentoCard extends StatelessWidget {
  final Widget child;
  final double? height;
  final Color color;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;

  const BentoCard({
    super.key,
    required this.child,
    this.height,
    this.color = Colors.white,
    this.padding = const EdgeInsets.all(24),
    this.onTap,
    this.border,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(32), // Equivale ao rounded-[2rem]
          border: border,
          boxShadow: boxShadow ?? [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}