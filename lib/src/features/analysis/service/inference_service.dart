import 'package:dermalyze/src/models/analysys_type.dart';
import 'package:dermalyze/src/models/clinical_record.dart';
import 'package:dermalyze/src/features/analysis/service/ood_onnx_service.dart';

class InferenceService {
  final OodOnnxService _oodService = OodOnnxService();

  Future<bool> isValidImage(String imagePath) async {
    try {
      // Chama o modelo ONNX real
      final double? score = await _oodService.predictQualityScore(imagePath);    
      if (score == null) {
        return false; // Retorna inválido em caso de falha de leitura
      }
      return score > 2.5;
    } catch (e) {
      print("Falha ao validar a imagem OOD: $e");
      return false;
    }
  }

  Future<InferenceResult> runInference(ClinicalRecord record, AnalysisType type) async {
    // TODO: A próxima etapa será implementar os modelos ONNX de Triagem e Diagnóstico aqui.
    await Future.delayed(const Duration(seconds: 2)); // Mantendo o mock temporário
    
    if (type == AnalysisType.triage) {
      return InferenceResult(label: 'P1', confidence: 0.92, type: type);
    } else {
      return InferenceResult(label: 'melanoma', confidence: 0.88, type: type);
    }
  }
}