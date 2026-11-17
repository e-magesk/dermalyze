import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:dermalyze/src/models/analysis_type.dart';
import 'package:dermalyze/src/modules/guide/pages/guide_page.dart';
import 'package:dermalyze/src/modules/guide/widgets/faq_help_button.dart';
import 'package:dermalyze/src/shared/clinical/priority_level.dart';
import 'package:dermalyze/src/shared/navigation/section_navigation_registry.dart';
import 'package:dermalyze/src/shared/widgets/analysis_result_widgets.dart';
import 'package:dermalyze/src/shared/widgets/app_clinical_data_form.dart';
import 'package:dermalyze/src/shared/widgets/model_confidence_card.dart';
import 'package:dermalyze/src/shared/widgets/priority_scale_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/features/analysis/controller/analysis_controller.dart';

class TriagePage extends StatelessWidget {
  const TriagePage({super.key});

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
    // 1. Estado de Carregamento
    if (controller.triageState == AnalysisState.loading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF2563EB)),
      );
    }

    // 2. ESTADO DE SUCESSO
    if (controller.triageState == AnalysisState.success && controller.triageResult != null) {
      final result = controller.triageResult!;
      // Rótulo fora de P1–P5 não deveria acontecer; P3 evita subestimar o risco.
      final level = PriorityLevel.fromCode(result.label) ?? PriorityLevel.p3;

      return SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título Principal
            ScreenTitleWithHelp(
              title: l10n.triageResultTitle,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.textDark),
              helpSection: GuideSection.triage,
            ),
            const SizedBox(height: 16),

            // CARD 1: a prioridade é a informação principal, então o card
            // inteiro leva a cor dela.
            _PriorityResultCard(level: level),
            const SizedBox(height: 16),

            // CARD 2: Conduta recomendada
            ResultSectionCard(
              title: l10n.analysisManagementTitle,
              content: level.conduct(l10n),
              icon: Icons.warning_amber_rounded,
              accentColor: level.color,
            ),
            const SizedBox(height: 16),

            // CARD 3: Confiança, com a explicação do que ela significa
            ModelConfidenceCard(
              confidence: result.confidence,
              explanation: l10n.confidenceTriageDesc,
              accentColor: level.color,
            ),

            if (controller.triageImagePath != null) ...[
              const SizedBox(height: 16),
              AnalyzedPhotoCard(imagePath: controller.triageImagePath!),
            ],

            const SizedBox(height: 40),

            // Botão Finalizador (Nova Triagem) puxado do ARB
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => controller.reset(AnalysisType.triage),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                ),
                child: Text(
                  l10n.triageNew.toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 1.2),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // 3. Estado Inicial (Exibir Formulário de Triagem) puxado do ARB
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScreenTitleWithHelp(
            title: l10n.clinicalTriage,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
            helpSection: GuideSection.triage,
          ),
          // Para que serve a Triagem, para quem abre a tela pela primeira vez.
          Text(
            l10n.triageIntro,
            style: const TextStyle(fontSize: 14, color: AppColors.textMedium, fontWeight: FontWeight.w500, height: 1.5),
          ),
          const SizedBox(height: 24),

          ClinicalDataForm(
            sectionScope: SectionScope.triage,
            captureMode: CaptureMode.macroscopic,
            initialStep: 2,
            onSubmit: (record) => controller.startAnalysis(record, AnalysisType.triage),
          ),
        ],
      ),
    );
  }
}

/// Card principal do resultado: preenchido com a cor da prioridade, com o
/// significado do nível e, sob demanda, a escala completa P1–P5.
class _PriorityResultCard extends StatefulWidget {
  final PriorityLevel level;

  const _PriorityResultCard({required this.level});

  @override
  State<_PriorityResultCard> createState() => _PriorityResultCardState();
}

class _PriorityResultCardState extends State<_PriorityResultCard> {
  bool _showScale = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final level = widget.level;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: level.fill,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(color: level.fill.withValues(alpha: 0.25), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            level.label(l10n),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -0.5),
          ),
          const SizedBox(height: 12),
          Text(
            level.description(l10n),
            style: const TextStyle(fontSize: 15, height: 1.5, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: () => setState(() => _showScale = !_showScale),
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
            ),
            icon: Icon(_showScale ? Icons.expand_less_rounded : Icons.expand_more_rounded),
            label: Text(
              _showScale ? l10n.priorityHideAll : l10n.priorityShowAll,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            alignment: Alignment.topCenter,
            child: _showScale
                ? Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(24)),
                    child: PriorityScaleList(highlight: level),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
    );
  }
}
