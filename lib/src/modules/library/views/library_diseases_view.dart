import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dermalyze/src/core/l10n/app_localizations.dart';

class LibraryDiseasesView extends StatelessWidget {
  final AppLocalizations l10n;
  const LibraryDiseasesView({super.key, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> diseases = [

      // P1 - PRIORIDADE MÁXIMA
      {'name': l10n.diagMelanomaName, 'desc': l10n.diagMelanomaDesc, 'p': 'P1', 'color': AppColors.p1Malign, 'bg': AppColors.p1Bg},
      {'name': l10n.diagLentigoName, 'desc': l10n.diagLentigoDesc, 'p': 'P1', 'color': AppColors.p1Malign, 'bg': AppColors.p1Bg},
      {'name': l10n.diagNevoD22Name, 'desc': l10n.diagNevoD22Desc, 'p': 'P1', 'color': AppColors.p1Malign, 'bg': AppColors.p1Bg},
      
      // P2 - ALTA PRIORIDADE
      {'name': l10n.diagBCCName, 'desc': l10n.diagBCCDesc, 'p': 'P2', 'color': AppColors.p2High, 'bg': AppColors.p2Bg},
      {'name': l10n.diagSCCName, 'desc': l10n.diagSCCDesc, 'p': 'P2', 'color': AppColors.p2High, 'bg': AppColors.p2Bg},
      {'name': l10n.diagBowenName, 'desc': l10n.diagBowenDesc, 'p': 'P2', 'color': AppColors.p2High, 'bg': AppColors.p2Bg},
      {'name': l10n.diagKeratoacanthomaName, 'desc': l10n.diagKeratoacanthomaDesc, 'p': 'P2', 'color': AppColors.p2High, 'bg': AppColors.p2Bg},
      {'name': l10n.diagCutaneousHornName, 'desc': l10n.diagCutaneousHornDesc, 'p': 'P2', 'color': AppColors.p2High, 'bg': AppColors.p2Bg},

      // P3 - PRIORIDADE MÉDIA
      {'name': l10n.diagAKName, 'desc': l10n.diagAKDesc, 'p': 'P3', 'color': AppColors.p3Medium, 'bg': AppColors.p3Bg},
      {'name': l10n.diagEczemaName, 'desc': l10n.diagEczemaDesc, 'p': 'P3', 'color': AppColors.p3Medium, 'bg': AppColors.p3Bg},
      {'name': l10n.diagDermatitisName, 'desc': l10n.diagDermatitisDesc, 'p': 'P3', 'color': AppColors.p3Medium, 'bg': AppColors.p3Bg},

      // P4 - BAIXA PRIORIDADE
      {'name': l10n.diagSKName, 'desc': l10n.diagSKDesc, 'p': 'P4', 'color': AppColors.p4Low, 'bg': AppColors.p4Bg},
      {'name': l10n.diagNevusL78Name, 'desc': l10n.diagNevusL78Desc, 'p': 'P4', 'color': AppColors.p4Low, 'bg': AppColors.p4Bg},

      // P5 - PRIORIDADE MÍNIMA
      {'name': l10n.diagAcneName, 'desc': l10n.diagAcneDesc, 'p': 'P5', 'color': AppColors.p5Minimal, 'bg': AppColors.p5Bg},
      {'name': l10n.diagNoLesionName, 'desc': l10n.diagNoLesionDesc, 'p': 'P5', 'color': AppColors.p5Minimal, 'bg': AppColors.p5Bg},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero Card com borda esquerda igual ao monolito
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
            boxShadow: const [BoxShadow(color: Color(0x05000000), blurRadius: 10)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.biotech_rounded, color: Color(0xFF4F46E5), size: 32),
              const SizedBox(height: 16),
              Text(l10n.libDiseasesHeroTitle, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppColors.textDark, letterSpacing: -1)),
              const SizedBox(height: 12),
              Text(l10n.libDiseasesHeroDesc1, style: const TextStyle(fontSize: 13, color: AppColors.textMedium, fontWeight: FontWeight.w500, height: 1.5)),
            ],
          ),
        ),
        const SizedBox(height: 32),
        
        Text(l10n.libDiseasesEncyclopedia.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.textLight, letterSpacing: 2)),
        const SizedBox(height: 16),

        ...diseases.map((d) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: const Color(0xFFF1F5F9)),
              ),
              child: Stack(
                children: [
                  // A barra colorida na DIREITA (conforme o monolito)
                  Positioned(
                    right: -24, top: -24, bottom: -24,
                    child: Container(width: 8, color: d['color']),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(d['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.textDark))),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: d['bg'], borderRadius: BorderRadius.circular(100)),
                            child: Text("Nível ${d['p']}".toUpperCase(), style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: d['color'])),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(d['desc'], style: const TextStyle(fontSize: 13, color: AppColors.textMedium, fontWeight: FontWeight.w500, height: 1.5)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )),
      ],
    );
  }
}