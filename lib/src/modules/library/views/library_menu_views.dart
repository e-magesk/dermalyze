import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:dermalyze/src/modules/library/pages/library_page.dart';
import 'package:flutter/material.dart';
import 'package:dermalyze/src/core/l10n/app_localizations.dart';

class LibraryMenuView extends StatelessWidget {
  final Function(LibraryCategory) onSelect;
  final AppLocalizations l10n;

  const LibraryMenuView({super.key, required this.onSelect, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero Card Azul
        // Hero Card Azul (Ajustado)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3), 
                blurRadius: 20, 
                offset: const Offset(0, 10)
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Textos na esquerda
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.libHeroTitle,
                      style: const TextStyle(
                        fontSize: 28, 
                        fontWeight: FontWeight.w900, 
                        color: Colors.white, 
                        fontStyle: FontStyle.italic, 
                        letterSpacing: -1
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.libHeroSubtitle.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10, 
                        fontWeight: FontWeight.bold, 
                        color: Colors.white70, 
                        letterSpacing: 2
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16), // Espaço de respiro
              
              // Ícone na direita
              const Icon(
                Icons.menu_book_rounded, 
                color: Colors.white24, 
                size: 64, // Aumentei um pouco para dar mais presença
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Bento Buttons
        _buildMenuOption(
          title: l10n.libMenuAbcdeTitle,
          subtitle: l10n.libMenuAbcdeDesc,
          iconWidget: const Text("ABC", style: TextStyle(fontWeight: FontWeight.w900, fontStyle: FontStyle.italic, color: AppColors.primary, fontSize: 16)),
          bgColor: const Color(0xFFEFF6FF), // blue-50
          onTap: () => onSelect(LibraryCategory.abcde),
        ),
        const SizedBox(height: 16),
        _buildMenuOption(
          title: l10n.libMenuDiseasesTitle,
          subtitle: l10n.libMenuDiseasesDesc,
          iconWidget: const Icon(Icons.search_rounded, color: Color(0xFF4F46E5)), // indigo-600
          bgColor: const Color(0xFFEEF2FF), // indigo-50
          onTap: () => onSelect(LibraryCategory.diseases),
        ),
        const SizedBox(height: 16),
        _buildMenuOption(
          title: l10n.libMenuTriageTitle,
          subtitle: l10n.libMenuTriageDesc,
          iconWidget: const Icon(Icons.assignment_turned_in_rounded, color: Color(0xFF059669)), // emerald-600
          bgColor: const Color(0xFFECFDF5), // emerald-50
          onTap: () => onSelect(LibraryCategory.triage),
        ),
      ],
    );
  }

  Widget _buildMenuOption({
    required String title, required String subtitle, required Widget iconWidget, required Color bgColor, required VoidCallback onTap
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: const Color(0xFFF1F5F9)),
        ),
        child: Row(
          children: [
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(16)),
              child: Center(child: iconWidget),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.textDark)),
                  const SizedBox(height: 4),
                  Text(subtitle.toUpperCase(), style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.textLight, letterSpacing: 1.2)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFFCBD5E1)),
          ],
        ),
      ),
    );
  }
}