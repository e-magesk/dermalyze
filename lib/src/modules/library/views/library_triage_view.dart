import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:dermalyze/src/modules/library/widgets/library_section_banner.dart';
import 'package:dermalyze/src/shared/widgets/priority_scale_list.dart';
import 'package:flutter/material.dart';
import 'package:dermalyze/src/core/l10n/app_localizations.dart';

class LibraryTriageView extends StatelessWidget {
  final AppLocalizations l10n;
  const LibraryTriageView({super.key, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mesmo banner das outras seções da Biblioteca.
        LibrarySectionBanner(
          icon: Icons.assignment_turned_in_rounded,
          title: l10n.libTriageHeroTitle,
          description: l10n.libTriageHeroDesc,
        ),
        const SizedBox(height: 32),

        Text(
          l10n.libTriageHeroSubtitle.toUpperCase(),
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.textLight, letterSpacing: 2),
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(32), border: Border.all(color: const Color(0xFFF1F5F9))),
          child: const PriorityScaleList(),
        ),
      ],
    );
  }
}
