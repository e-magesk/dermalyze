import 'package:flutter/material.dart';

class AppColors {
  // Cores de Marca
  static const Color primary = Color(0xFF2563EB); // blue-600
  static const Color background = Color(0xFFF8FAFC); // slate-50
  static const Color surface = Colors.white; //

  // Tons de Cinza / Texto
  static const Color textDark = Color(0xFF0F172A); // slate-900
  static const Color textMedium = Color(0xFF475569); // slate-600
  static const Color textLight = Color(0xFF94A3B8); // slate-400

  // Cores Auxiliares (Base para Opacidade)
  static const Color black = Colors.black; //
  static const Color white = Colors.white; //


  // Cores de Prioridade (P1 a P5)
  static const Color p1Malign = Color(0xFFE11D48); //
  static const Color p1Bg = Color(0xFFFFF1F2); //
  
  static const Color p2High = Color(0xFFF97316); //
  static const Color p2Bg = Color(0xFFFFF7ED); //
  
  static const Color p3Medium = Color(0xFFCA8A04); //
  static const Color p3Bg = Color(0xFFFEFCE8); //
  
  static const Color p4Low = Color(0xFF2563EB); //
  static const Color p4Bg = Color(0xFFEFF6FF); //
  
  static const Color p5Minimal = Color(0xFF16A34A); //
  static const Color p5Bg = Color(0xFFECFDF5); //

  // Preenchimento de cards com texto branco por cima. Laranja, amarelo e verde
  // acima ficam com contraste < 3:1 contra o branco; estes tons mais escuros do
  // mesmo matiz passam de 4,5:1 (WCAG AA).
  static const Color p1Fill = p1Malign;
  static const Color p2Fill = Color(0xFFC2410C);
  static const Color p3Fill = Color(0xFFA16207);
  static const Color p4Fill = p4Low;
  static const Color p5Fill = Color(0xFF15803D);

  // Cores de alerta
  static const Color error = Color(0xFFE11D48);
  static const Color success = Color(0xFF16A34A); //

}