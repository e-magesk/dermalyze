import 'dart:io';

import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:dermalyze/src/shared/widgets/app_bento_card.dart';
import 'package:flutter/material.dart';

/// Card de seção dos resultados (ex.: Manejo e Conduta), no padrão Bento.
class ResultSectionCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color accentColor;

  const ResultSectionCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return BentoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: accentColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: accentColor, letterSpacing: 1.1),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(fontSize: 14, height: 1.6, color: Color(0xFF334155), fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

/// A foto que foi analisada, como referência visual no resultado.
class AnalyzedPhotoCard extends StatelessWidget {
  final String imagePath;

  const AnalyzedPhotoCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BentoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.photo_outlined, size: 16, color: AppColors.textMedium),
              const SizedBox(width: 8),
              Text(
                l10n.analyzedPhotoTitle.toUpperCase(),
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.textMedium, letterSpacing: 1.1),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Quadrada, como o recorte, para a foto aparecer inteira.
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 280),
              child: AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.background,
                      child: const Icon(Icons.broken_image_outlined, color: AppColors.textLight, size: 40),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
