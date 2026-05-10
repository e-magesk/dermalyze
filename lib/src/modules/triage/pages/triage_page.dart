import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:dermalyze/src/features/sync/controller/sync_controller.dart';
import 'package:dermalyze/src/models/analysis_type.dart';
import 'package:dermalyze/src/shared/widgets/app_bento_card.dart';
import 'package:dermalyze/src/shared/widgets/app_clinical_data_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/features/analysis/controller/analysis_controller.dart';

class PriorityData {
  final String label;
  final Color color;
  final Color bgColor;
  PriorityData(this.label, this.color, this.bgColor);
}

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

    // 2. ESTADO DE SUCESSO (LAUDO BENTO COM CORES DE RISCO)
    if (controller.triageState == AnalysisState.success && controller.triageResult != null) {
      final result = controller.triageResult!;
      final triageData = _getTriageContent(result.label, l10n);
      final priority = triageData['priority'] as PriorityData;

      return SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título Principal
            Text(
              l10n.analysisResultsTitle,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.textDark),
            ),
            const SizedBox(height: 24),

            // CARD 1: Prioridade e Confiança
            BentoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.background, 
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: Text(
                      l10n.clinicalTriage.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 9, 
                        fontWeight: FontWeight.w900, 
                        color: AppColors.textLight, 
                        letterSpacing: 1.2
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Nome do Nível (Ex: Prioridade Máxima) puxado do ARB
                  Text(
                    triageData['title']!,
                    style: const TextStyle(
                      fontSize: 32, 
                      fontWeight: FontWeight.w900, 
                      color: AppColors.textDark, 
                      letterSpacing: -1.0
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      // Badge 1: Nível de Prioridade (P1) puxado do ARB
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: priority.bgColor,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          priority.label.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12, 
                            fontWeight: FontWeight.w900, 
                            color: priority.color
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Badge 2: Confiança puxado do ARB
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: const Color(0xFFF1F5F9)), 
                        ),
                        child: Text(
                          "${l10n.analysisLabelConfidence}: ${(result.confidence * 100).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12, 
                            fontWeight: FontWeight.w900, 
                            color: priority.color 
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // CARD 2: Descrição Clínica da Triagem puxada do ARB
            _buildBentoSection(
              title: l10n.analysisClinicalFeatures,
              content: triageData['desc']!,
              icon: Icons.info_outline,
              accentColor: priority.color,
            ),
            const SizedBox(height: 16),

            // CARD 3: Conduta Recomendada puxada do ARB
            _buildBentoSection(
              title: l10n.analysisManagementTitle,
              content: triageData['conduta']!,
              icon: Icons.warning_amber_rounded,
              accentColor: priority.color,
            ),
            
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
          Text(
            l10n.clinicalTriage,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.triageLevels,
            style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          
          ClinicalDataForm(
            onSubmit: (record) => controller.startAnalysis(record, AnalysisType.triage, context.read<SyncController>()),
          ),
        ],
      ),
    );
  }

  Widget _buildBentoSection({
    required String title,
    required String content,
    required IconData icon,
    Color accentColor = const Color(0xFF2563EB),
  }) {
    return BentoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: accentColor),
              const SizedBox(width: 8),
              Text(
                title.toUpperCase(),
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: accentColor, letterSpacing: 1.1),
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

  Map<String, dynamic> _getTriageContent(String label, AppLocalizations l10n) {
    switch (label.toUpperCase()) {
      case 'P1':
        return {
          'title': l10n.triageP1Title,
          'desc': l10n.triageP1Desc,
          'conduta': l10n.triageP1Conduta,
          'priority': PriorityData(l10n.triageP1Label, AppColors.p1Malign, AppColors.p1Bg)
        };
      case 'P2':
        return {
          'title': l10n.triageP2Title,
          'desc': l10n.triageP2Desc,
          'conduta': l10n.triageP2Conduta,
          'priority': PriorityData(l10n.triageP2Label, AppColors.p2High, AppColors.p2Bg)
        };
      case 'P3':
        return {
          'title': l10n.triageP3Title,
          'desc': l10n.triageP3Desc,
          'conduta': l10n.triageP3Conduta,
          'priority': PriorityData(l10n.triageP3Label, AppColors.p3Medium, AppColors.p3Bg)
        };
      case 'P4':
        return {
          'title': l10n.triageP4Title,
          'desc': l10n.triageP4Desc,
          'conduta': l10n.triageP4Conduta,
          'priority': PriorityData(l10n.triageP4Label, AppColors.p4Low, AppColors.p4Bg)
        };
      case 'P5':
        return {
          'title': l10n.triageP5Title,
          'desc': l10n.triageP5Desc,
          'conduta': l10n.triageP5Conduta,
          'priority': PriorityData(l10n.triageP5Label, const Color(0xFF059669), const Color(0xFFD1FAE5)) // Verde Emerald
        };
      default:
        return {
          'title': null,
          'desc': null,
          'conduta': null,
          'priority': null
        };
    }
  }
}