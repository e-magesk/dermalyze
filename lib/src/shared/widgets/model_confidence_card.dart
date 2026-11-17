import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:dermalyze/src/shared/widgets/app_bento_card.dart';
import 'package:flutter/material.dart';

/// Confiança do modelo em um card próprio, com a explicação do que ela
/// significa — solto dentro do card principal, o percentual era mal
/// interpretado (por exemplo, como chance de malignidade).
class ModelConfidenceCard extends StatelessWidget {
  /// Entre 0 e 1.
  final double confidence;

  /// O que a confiança representa neste fluxo.
  final String explanation;

  final Color accentColor;

  const ModelConfidenceCard({
    super.key,
    required this.confidence,
    required this.explanation,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final percent = (confidence * 100).toStringAsFixed(1);

    return BentoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.speed_rounded, size: 16, color: accentColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.confidenceTitle.toUpperCase(),
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: accentColor, letterSpacing: 1.1),
                ),
              ),
              Text(
                '$percent%',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.textDark),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: confidence.clamp(0.0, 1.0),
              minHeight: 8,
              color: accentColor,
              backgroundColor: AppColors.background,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            explanation,
            style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.textMedium, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
