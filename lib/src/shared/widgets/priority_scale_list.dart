import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:dermalyze/src/shared/clinical/priority_level.dart';
import 'package:flutter/material.dart';

/// Escala completa de prioridades (P1 a P5), com a explicação de cada nível.
///
/// Usada na Metodologia da Biblioteca e no resultado da triagem, onde
/// [highlight] destaca o nível do paciente.
class PriorityScaleList extends StatelessWidget {
  final PriorityLevel? highlight;

  const PriorityScaleList({super.key, this.highlight});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        for (final level in PriorityLevel.values)
          Padding(
            padding: EdgeInsets.only(bottom: level == PriorityLevel.values.last ? 0 : 12),
            child: _PriorityRow(level: level, isCurrent: level == highlight, l10n: l10n),
          ),
      ],
    );
  }
}

class _PriorityRow extends StatelessWidget {
  final PriorityLevel level;
  final bool isCurrent;
  final AppLocalizations l10n;

  const _PriorityRow({required this.level, required this.isCurrent, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCurrent ? level.background : AppColors.background,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: isCurrent ? level.color : Colors.transparent, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(color: level.color, width: 2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                level.code(l10n),
                style: TextStyle(fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, color: level.color, fontSize: 12),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  level.title(l10n).toUpperCase(),
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: level.color),
                ),
                const SizedBox(height: 2),
                Text(
                  level.description(l10n),
                  style: const TextStyle(fontSize: 12, color: AppColors.textMedium, fontWeight: FontWeight.w500, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
