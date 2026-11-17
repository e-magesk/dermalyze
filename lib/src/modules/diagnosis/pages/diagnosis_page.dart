import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:dermalyze/src/models/analysis_type.dart';
import 'package:dermalyze/src/modules/guide/pages/guide_page.dart';
import 'package:dermalyze/src/modules/guide/widgets/faq_help_button.dart';
import 'package:dermalyze/src/shared/clinical/priority_level.dart';
import 'package:dermalyze/src/shared/navigation/section_navigation_registry.dart';
import 'package:dermalyze/src/shared/widgets/analysis_result_widgets.dart';
import 'package:dermalyze/src/shared/widgets/app_bento_card.dart';
import 'package:dermalyze/src/shared/widgets/app_clinical_data_form.dart';
import 'package:dermalyze/src/shared/widgets/model_confidence_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/features/analysis/controller/analysis_controller.dart';

/// Textos exibidos para uma classe do modelo da Análise Assistida.
class DiagnosisTexts {
  final String name;
  final String description;
  final String conduct;

  const DiagnosisTexts({required this.name, required this.description, required this.conduct});
}

/// Nome, descrição e conduta de cada classe do modelo.
///
/// NEV é exibido como nevo melanocítico (P1), com a descrição do nevo atípico
/// da Biblioteca (D22) e a conduta de P1 — definido pela equipe, pendente de
/// validação médica. A prioridade vem de [priorityForDiagnosisLabel].
DiagnosisTexts diagnosisTextsFor(String label, AppLocalizations l10n) {
  switch (label.toUpperCase()) {
    case 'MEL':
      return DiagnosisTexts(name: l10n.diagMelanomaName, description: l10n.diagMelanomaDesc, conduct: l10n.diagMelanomaConduta);
    case 'NEV':
      return DiagnosisTexts(name: l10n.diagNevusName, description: l10n.diagNevoD22Desc, conduct: l10n.triageP1Conduta);
    case 'BCC':
      return DiagnosisTexts(name: l10n.diagBCCName, description: l10n.diagBCCDesc, conduct: l10n.diagBCCConduta);
    case 'SCC':
      return DiagnosisTexts(name: l10n.diagSCCName, description: l10n.diagSCCDesc, conduct: l10n.diagSCCConduta);
    case 'ACK':
      return DiagnosisTexts(name: l10n.diagAKName, description: l10n.diagAKDesc, conduct: l10n.diagAKConduta);
    case 'SEK':
      return DiagnosisTexts(name: l10n.diagSKName, description: l10n.diagSKDesc, conduct: l10n.diagSKConduta);
    default:
      // Fallback genérico
      return const DiagnosisTexts(
        name: 'Resultado Indeterminado',
        description: 'Requer avaliação manual.',
        conduct: 'Encaminhar para especialista.',
      );
  }
}

class DiagnosisPage extends StatelessWidget {
  const DiagnosisPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AnalysisController>();
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: _buildBody(context, controller, l10n),
      ),
    );
  }

  Widget _buildBody(BuildContext context, AnalysisController controller, AppLocalizations l10n) {
    // 1. Estado de Carregamento (Processando modelos de diagnóstico)
    if (controller.diagState == AnalysisState.loading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF2563EB)),
      );
    }

    // 2. ESTADO DE SUCESSO
    if (controller.diagState == AnalysisState.success && controller.diagResult != null) {
      final result = controller.diagResult!;
      final texts = diagnosisTextsFor(result.label, l10n);
      final level = priorityForDiagnosisLabel(result.label);

      return SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título Principal
            ScreenTitleWithHelp(
              title: l10n.diagnosisResultTitle,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.textDark),
              helpSection: GuideSection.diagnosis,
            ),
            const SizedBox(height: 16),

            // CARD 1: a patologia é a informação principal; a prioridade vem
            // no badge e a descrição fica junto, no mesmo card.
            SizedBox(
              width: double.infinity,
              child: BentoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      texts.name,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: AppColors.textDark,
                        letterSpacing: -1.0 // Deixa a fonte mais unida e moderna, como no React
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Badge de prioridade (Ex: P1 · PRIORIDADE MÁXIMA)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: level.background,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        level.label(l10n).toUpperCase(),
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: level.color),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      texts.description,
                      style: const TextStyle(fontSize: 14, height: 1.6, color: Color(0xFF334155), fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // CARD 2: Manejo e Conduta
            ResultSectionCard(
              title: l10n.analysisManagementTitle,
              content: texts.conduct,
              icon: Icons.medical_services_outlined,
              accentColor: level.color,
            ),
            const SizedBox(height: 16),

            // CARD 3: Confiança, com a explicação do que ela significa
            ModelConfidenceCard(
              confidence: result.confidence,
              explanation: l10n.confidenceDiagnosisDesc,
              accentColor: level.color,
            ),

            if (controller.diagImagePath != null) ...[
              const SizedBox(height: 16),
              AnalyzedPhotoCard(imagePath: controller.diagImagePath!),
            ],
            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB), // amber-50 (fundo amarelado)
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFFFDE68A), // amber-200 (borda mais escura)
                  width: 1.5,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        size: 18,
                        color: Color(0xFFD97706), // amber-600
                      ),
                      SizedBox(width: 8),
                      Text(
                        "AVISO MÉDICO LEGAL",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFD97706), // amber-600
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    "ESTE SISTEMA É UM AUXÍLIO AO DIAGNÓSTICO (CAD). A IA NÃO SUBSTITUI ANAMNESE E BIÓPSIA.",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFB45309), // amber-700
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Botão Finalizador (Cor Primária do App)
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => controller.reset(AnalysisType.diagnosis),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                ),
                child: Text(
                  l10n.diagnosisNew.toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 1.2),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // 3. Estado Inicial (Exibir Formulário de Diagnóstico)
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenTitleWithHelp(
            title: l10n.clinicalDiagnosis,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
            helpSection: GuideSection.diagnosis,
          ),
          // Para que serve a Análise Assistida, para quem abre a tela pela
          // primeira vez.
          Text(
            l10n.diagnosisIntro,
            style: const TextStyle(fontSize: 14, color: AppColors.textMedium, fontWeight: FontWeight.w500, height: 1.5),
          ),
          const SizedBox(height: 24),

          ClinicalDataForm(
            sectionScope: SectionScope.diagnosis,
            captureMode: CaptureMode.dermoscopic,
            onSubmit: (record) => controller.startAnalysis(record, AnalysisType.diagnosis),
          ),
        ],
      ),
    );
  }
}
