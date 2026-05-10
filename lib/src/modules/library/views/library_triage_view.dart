import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dermalyze/src/core/l10n/app_localizations.dart';

class LibraryTriageView extends StatelessWidget {
  final AppLocalizations l10n;
  const LibraryTriageView({super.key, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> levels = [
      {'code': l10n.triageP1Label, 'title': l10n.triageP1Title, 'color': AppColors.p1Malign, 'bg': AppColors.p1Bg, 'desc': l10n.triageP1Desc},
      {'code': l10n.triageP2Label, 'title': l10n.triageP2Title, 'color': AppColors.p2High, 'bg': AppColors.p2Bg, 'desc': l10n.triageP2Desc},
      {'code': l10n.triageP3Label, 'title': l10n.triageP3Title, 'color': AppColors.p3Medium, 'bg': AppColors.p3Bg, 'desc': l10n.triageP3Desc},
      {'code': l10n.triageP4Label, 'title': l10n.triageP4Title, 'color': AppColors.p4Low, 'bg': AppColors.p4Bg, 'desc': l10n.triageP4Desc},
      {'code': l10n.triageP5Label, 'title': l10n.triageP5Title, 'color': AppColors.p5Minimal, 'bg': AppColors.p5Bg, 'desc': l10n.triageP5Desc},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.libTriageHeroTitle, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic)),
        Text(l10n.libTriageHeroSubtitle.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.textLight, letterSpacing: 1.5)),
        const SizedBox(height: 24),
        
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(40), border: Border.all(color: const Color(0xFFF1F5F9))),
          child: Column(
            children: levels.map((lvl) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(color: AppColors.surface, border: Border.all(color: lvl['color'], width: 2), shape: BoxShape.circle),
                      child: Center(child: Text(lvl['code'], style: TextStyle(fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, color: lvl['color'], fontSize: 12))),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(lvl['title'].toUpperCase(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: lvl['color'])),
                          Text(lvl['desc'], style: const TextStyle(fontSize: 11, color: AppColors.textMedium, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )).toList(),
          ),
        ),
      ],
    );
  }
}