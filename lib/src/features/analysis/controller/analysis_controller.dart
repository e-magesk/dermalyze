import 'package:dermalyze/src/features/analysis/service/dagnostic_onnx_service.dart';
import 'package:dermalyze/src/features/analysis/service/triage_onnx_service.dart';
import 'package:dermalyze/src/features/analysis/service/metadata_encoder.dart';
import 'package:dermalyze/src/models/analysis_type.dart';
import 'package:dermalyze/src/models/clinical_record.dart';
import 'package:flutter/material.dart';

enum AnalysisState { idle, loading, success, error }

/// Executa as análises localmente, no próprio aparelho.
///
/// Na v1.0 nenhum dado clínico sai do tablet: o resultado só existe em memória
/// enquanto é exibido, e é descartado ao iniciar uma nova análise ou ao
/// encerrar a sessão.
class AnalysisController extends ChangeNotifier {
  final _diagService = DiagnosticOnnxService();
  final _triageService = TriageOnnxService();

  // Estado do Diagnóstico
  AnalysisState diagState = AnalysisState.idle;
  InferenceResult? diagResult;
  String? diagImagePath;

  // Estado da Triagem
  AnalysisState triageState = AnalysisState.idle;
  InferenceResult? triageResult;
  String? triageImagePath;


  Future<void> startAnalysis(ClinicalRecord record, AnalysisType type) async {

    try {
      if (type == AnalysisType.diagnosis) {

        diagState = AnalysisState.loading;
        // Mostrada na tela de resultado, como referência do que foi analisado.
        diagImagePath = record.imagePath;
        notifyListeners();

        // 1. Transforma o record no vetor de 96 colunas
        final metaVector = MetadataEncoder.encode(record);

        // 2. Roda a predição local
        final inference = await _diagService.predict(record.imagePath!, metaVector);

        if (inference != null) {
          diagResult = inference;
          diagState = AnalysisState.success;
        }
      }
      else if (type == AnalysisType.triage) {
        triageState = AnalysisState.loading;
        // Mostrada na tela de resultado, como referência do que foi analisado.
        triageImagePath = record.imagePath;
        notifyListeners();

        debugPrint('================================================================');
        debugPrint('Iniciando análise de triagem...');

        // Roda a predição local
        final inference = await _triageService.predict(record.imagePath!);

        if (inference != null) {
          triageResult = inference;
          triageState = AnalysisState.success;
        }
      }
    } catch (e) {
      if (type == AnalysisType.diagnosis) diagState = AnalysisState.error;
      if (type == AnalysisType.triage) triageState = AnalysisState.error;
    } finally {
      notifyListeners();
    }
  }

  void reset(AnalysisType type) {
    if (type == AnalysisType.diagnosis) {
      diagState = AnalysisState.idle;
      diagResult = null;
      diagImagePath = null;
    } else if (type == AnalysisType.triage) {
      triageState = AnalysisState.idle;
      triageResult = null;
      triageImagePath = null;
    }
    notifyListeners();
  }

  /// Descarta qualquer resultado em memória. Chamado ao encerrar a sessão,
  /// para o próximo usuário do tablet não ver o paciente anterior.
  void clearAll() {
    diagState = AnalysisState.idle;
    diagResult = null;
    diagImagePath = null;
    triageState = AnalysisState.idle;
    triageResult = null;
    triageImagePath = null;
    notifyListeners();
  }
}
