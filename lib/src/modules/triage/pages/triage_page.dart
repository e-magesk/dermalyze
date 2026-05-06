import 'package:dermalyze/src/models/analysys_type.dart';
import 'package:dermalyze/src/shared/widgets/app_clinical_data_form.dart';
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
    // 1. Estado de Carregamento (Processando ONNX)
    if (controller.state == AnalysisState.loading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF2563EB)),
      );
    }

    // 2. Estado de Sucesso (Exibir resultado)
    if (controller.state == AnalysisState.success) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Resultado: ${controller.result?.label}"),
            ElevatedButton(
              onPressed: () => controller.reset(),
              child: Text(l10n.triageNew),
            ),
          ],
        ),
      );
    }

    // 3. Estado Inicial (Exibir Formulário)
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
          
          // O formulário modularizado que criamos
          ClinicalDataForm(
            onSubmit: (record) => controller.startAnalysis(record, AnalysisType.triage),
          ),
        ],
      ),
    );
  }
}