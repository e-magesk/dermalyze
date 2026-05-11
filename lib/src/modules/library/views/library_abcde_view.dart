import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

class LibraryAbcdeView extends StatelessWidget {
  final AppLocalizations l10n;
  const LibraryAbcdeView({super.key, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero Card ABCDE
        Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(40),
                        border: const Border(
              top: BorderSide(color: Color(0xFF4F46E5), width: 1.5), // Espessura normal
              right: BorderSide(color: Color(0xFF4F46E5), width: 1.5), // Espessura normal
              bottom: BorderSide(color: Color(0xFF4F46E5), width: 1.5), // Espessura normal
              left: BorderSide(color: Color(0xFF4F46E5), width: 1.5), // Espessa (Destaque)
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Linha agrupando o Ícone e o Título
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.track_changes_rounded, color: AppColors.primary, size: 32),
                  const SizedBox(width: 12), // Espaçamento horizontal entre ícone e texto
                  Expanded(
                    child: Text(
                      l10n.libAbcdeHeroTitle, 
                      style: const TextStyle(
                        fontSize: 22, 
                        fontWeight: FontWeight.w900, 
                        color: AppColors.textDark, 
                        letterSpacing: -1
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16), // Espaçamento vertical antes do subtítulo/descrição
              Text(
                l10n.libAbcdeHeroDesc1, 
                style: const TextStyle(
                  fontSize: 13, 
                  color: AppColors.textMedium, 
                  fontWeight: FontWeight.w500, 
                  height: 1.5
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        
        Text(l10n.libAbcdeCriteria.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.textLight, letterSpacing: 2)),
        const SizedBox(height: 16),

        _buildAbcdeItem(l10n.libAbcdeLetterA, l10n.libAbcdeTitleA, l10n.libAbcdeDescA, l10n.libAbcdeBenignA, l10n.libAbcdeMalignA),
        _buildAbcdeItem(l10n.libAbcdeLetterB, l10n.libAbcdeTitleB, l10n.libAbcdeDescB, l10n.libAbcdeBenignB, l10n.libAbcdeMalignB),
        _buildAbcdeItem(l10n.libAbcdeLetterC, l10n.libAbcdeTitleC, l10n.libAbcdeDescC, l10n.libAbcdeBenignC, l10n.libAbcdeMalignC),
        _buildAbcdeItem(l10n.libAbcdeLetterD, l10n.libAbcdeTitleD, l10n.libAbcdeDescD, l10n.libAbcdeBenignD, l10n.libAbcdeMalignD),
        _buildAbcdeItem(l10n.libAbcdeLetterE, l10n.libAbcdeTitleE, l10n.libAbcdeDescE, l10n.libAbcdeBenignE, l10n.libAbcdeMalignE),
      ],
    );
  }

  Widget _buildAbcdeItem(String letter, String title, String desc, String benign, String suspect) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(32), border: Border.all(color: const Color(0xFFF1F5F9))),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(16)),
                child: Center(child: Text(letter, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, fontStyle: FontStyle.italic))),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.textDark)),
                    Text(desc, style: const TextStyle(fontSize: 12, color: AppColors.textLight, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // Passamos a letra (letter) para montar o nome do arquivo
              _buildExample(letter, benign, AppColors.p5Minimal, AppColors.p5Bg, true),
              const SizedBox(width: 12),
              _buildExample(letter, suspect, AppColors.p1Malign, AppColors.p1Bg, false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExample(String letter, String label, Color color, Color bg, bool isBenign) {
    // Monta o caminho dinamicamente: ex: "assets/images/abcde/abcde_a_benign.svg"
    final String type = isBenign ? 'benign' : 'suspect';
    final String assetPath = 'assets/images/abcde/${letter.toLowerCase()}_$type.svg';

    return Expanded(
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withValues(alpha: 0.1))),
            child: Center(
              child: SvgPicture.asset(
                assetPath,
                width: 80,
                height: 80,
                // Opcional: Descomente se quiser que as cores das imagens fiquem dinâmicas
                // colorFilter: ColorFilter.mode(color.withValues(alpha: 0.8), BlendMode.srcIn),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(label.toUpperCase(), style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: color)),
        ],
      ),
    );
  }
}