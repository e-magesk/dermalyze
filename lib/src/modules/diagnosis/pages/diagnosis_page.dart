import 'dart:io';

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

    // 2. Estado de Sucesso (Exibir resultado patológico)
    // // No método _buildBody da DiagnosisPage

    // 2. ESTADO DE SUCESSO (LAUDO BENTO COM CORES DE RISCO)
    if (controller.diagState == AnalysisState.success && controller.diagResult != null) {
      final result = controller.diagResult!;
      final diagnosisData = _getDiagnosisContent(result.label, l10n);
      final priority = diagnosisData['priority'] as PriorityData;

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

            BentoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Etiqueta "Hipótese Principal"
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.background, 
                      borderRadius: BorderRadius.circular(100)
                    ),
                    child: Text(
                      l10n.diagnosisSuggested.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 9, 
                        fontWeight: FontWeight.w900, 
                        color: AppColors.textLight, 
                        letterSpacing: 1.2
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Nome da Doença em grande destaque
                  Text(
                    diagnosisData['name']!,
                    style: const TextStyle(
                      fontSize: 32, 
                      fontWeight: FontWeight.w900, 
                      color: AppColors.textDark, 
                      letterSpacing: -1.0 // Deixa a fonte mais unida e moderna, como no React
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Linha com os dois Badges (Prioridade e Confiança)
                  Row(
                    children: [
                      // Badge 1: Nível de Prioridade (Ex: P1 - ALTO RISCO)
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
                      
                      // Badge 2: Nível de Confiança
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: const Color(0xFFF1F5F9)), // Borda bem suave
                        ),
                        child: Text(
                          "Confiança: ${(result.confidence * 100).toStringAsFixed(1)}%",
                          style: TextStyle(
                            fontSize: 12, 
                            fontWeight: FontWeight.w900, 
                            color: priority.color // Puxando a cor do diagnóstico, conforme a imagem
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // CARD 2: Características Clínicas
            _buildBentoSection(
              title: l10n.analysisClinicalFeatures,
              content: diagnosisData['desc']!,
              icon: Icons.analytics_outlined,
              accentColor: priority.color,
            ),
            const SizedBox(height: 16),

            // CARD 3: Manejo e Conduta
            _buildBentoSection(
              title: l10n.analysisManagementTitle,
              content: diagnosisData['conduta']!,
              icon: Icons.medical_services_outlined,
              accentColor: priority.color,
            ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.shield_outlined, 
                        size: 18, 
                        color: Color(0xFFD97706), // amber-600
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "AVISO MÉDICO LEGAL",
                        style: const TextStyle(
                          fontSize: 10, 
                          fontWeight: FontWeight.w900, 
                          color: Color(0xFFD97706), // amber-600
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
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

    // 3. Estado Inicial (Exibir Formulário de Diagnóstico)[cite: 2]
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.clinicalDiagnosis,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFF1E293B)),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.diagnosisSubtitle,
            style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8), fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          
          ClinicalDataForm(
            onSubmit: (record) => controller.startAnalysis(record, AnalysisType.diagnosis, context.read<SyncController>()),
          ),
        ],
      ),
    );
  }

  // Widget auxiliar para manter o padrão Bento
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

  Widget _buildSection({required String title, required String content, required IconData icon, required Color color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 8),
            Text(
              title.toUpperCase(),
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: color, letterSpacing: 1.1),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(16)),
          child: Text(
            content,
            style: const TextStyle(fontSize: 14, height: 1.6, color: AppColors.textMedium, fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }

  // Mapeia o rótulo do ONNX para as strings e para os dados de Prioridade visual (Cores)
  Map<String, dynamic> _getDiagnosisContent(String label, AppLocalizations l10n) {
    switch (label.toUpperCase()) {
      case 'MEL':
        return {
          'name': l10n.diagMelanomaName, 'desc': l10n.diagMelanomaDesc, 'conduta': l10n.diagMelanomaConduta,
          'priority': PriorityData(l10n.triageP1Title, AppColors.p1Malign, AppColors.p1Bg)
        };
      case 'NEV':
        return {
          'name': l10n.diagNevusName, 'desc': l10n.diagNevusDesc, 'conduta': l10n.diagNevusConduta,
          'priority': PriorityData(l10n.triageP1Title, AppColors.p4Low, AppColors.p4Bg)
        };
      case 'BCC':
        return {
          'name': l10n.diagBCCName, 'desc': l10n.diagBCCDesc, 'conduta': l10n.diagBCCConduta,
          'priority': PriorityData(l10n.triageP2Title, AppColors.p2High, AppColors.p2Bg)
        };
      case 'SCC':
        return {
          'name': l10n.diagSCCName, 'desc': l10n.diagSCCDesc, 'conduta': l10n.diagSCCConduta,
          'priority': PriorityData(l10n.triageP2Title, AppColors.p2High, AppColors.p2Bg)
        };
      case 'ACK':
        return {
          'name': l10n.diagAKName, 'desc': l10n.diagAKDesc, 'conduta': l10n.diagAKConduta,
          'priority': PriorityData(l10n.triageP3Title, AppColors.p3Medium, AppColors.p3Bg)
        };
      case 'SEK':
        return {
          'name': l10n.diagSKName, 'desc': l10n.diagSKDesc, 'conduta': l10n.diagSKConduta,
          'priority': PriorityData(l10n.triageP4Title, AppColors.p4Low, AppColors.p4Bg)
        };
      default:
        // Fallback genérico
        return {
          'name': 'Resultado Indeterminado', 'desc': 'Requer avaliação manual.', 'conduta': 'Encaminhar para especialista.',
          'priority': PriorityData('P3 - PRIORIDADE MÉDIA', AppColors.p3Medium, AppColors.p3Bg)
        };
    }
  }
}