import 'package:dermalyze/src/features/analysis/service/dagnostic_onnx_service.dart';
import 'package:dermalyze/src/features/analysis/service/triage_onnx_service.dart';
import 'package:dermalyze/src/features/analysis/service/inference_service.dart';
import 'package:dermalyze/src/features/analysis/service/metadata_encoder.dart';
import 'package:dermalyze/src/features/auth/repositories/api_repository.dart';
import 'package:dermalyze/src/features/sync/controller/sync_controller.dart';
import 'package:dermalyze/src/models/analysis_type.dart';
import 'package:dermalyze/src/models/clinical_record.dart';
import 'package:flutter/material.dart';

enum AnalysisState { idle, loading, success, error }

class AnalysisController extends ChangeNotifier {
  final InferenceService _service = InferenceService();
  final _apiService = AnalysisApiRepository();
  final _diagService = DiagnosticOnnxService();
  final _triageService = TriageOnnxService();

  // Estado do Diagnóstico
  AnalysisState diagState = AnalysisState.idle;
  InferenceResult? diagResult;

  // Estado da Triagem
  AnalysisState triageState = AnalysisState.idle;
  InferenceResult? triageResult;


  Future<void> startAnalysis(
    ClinicalRecord record, 
    AnalysisType type,
    SyncController syncController,) async {

    try {
      if (type == AnalysisType.diagnosis) {

        diagState = AnalysisState.loading;
        notifyListeners();

        debugPrint('================================================================');
        debugPrint('Iniciando análise de diagnóstico');

        // 1. Transforma o record no vetor de 96 colunas
        // final metaVector = MetadataEncoder.encode(record);

        debugPrint('=================================================================');
        debugPrint('Realizando inferência local com modelo ONNX...');

        // 2. Roda a predição local
        // final inference = await _diagService.predict(record.imagePath!, metaVector);

        await Future.delayed(const Duration(seconds: 2));
        final inference = InferenceResult(
          label: "ACK", // Vamos simular que a IA detectou Melanoma
          confidence: 0.945, // 94.5% de certeza
          type: AnalysisType.diagnosis,
        );

        if (inference != null) {
          diagResult = inference;

          debugPrint('=================================================================');
          debugPrint('Predição concluída: $diagResult)');
          
          // 3. Salva no Servidor logo após obter a predição
          syncController.enqueueOrSync(record: record, result: diagResult!);
          
          diagState = AnalysisState.success;
        }
      } 
      else if (type == AnalysisType.triage) {
        triageState = AnalysisState.loading;
        notifyListeners();

        debugPrint('================================================================');
        debugPrint('Iniciando análise de triagem...');

        // 1. Transforma o record no vetor de 96 colunas
        // final metaVector = MetadataEncoder.encode(record);


        // 2. Roda a predição local
        // final inference = await _triageService.predict(record.imagePath!, metaVector);
        
        // Simulação de inferência de Triagem
        await Future.delayed(const Duration(seconds: 2));
        final inference = InferenceResult(
          label: "P1", // Retorno mockado de Triagem
          confidence: 0.982, 
          type: AnalysisType.triage,
        );

        if (inference != null) {
          triageResult = inference;
          syncController.enqueueOrSync(record: record, result: triageResult!);
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
    } else if (type == AnalysisType.triage) {
      triageState = AnalysisState.idle;
      triageResult = null;
    }
    notifyListeners();
  }
}
