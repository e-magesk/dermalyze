import 'package:dermalyze/src/models/analysys_type.dart';
import 'package:dermalyze/src/models/clinical_record.dart';

class InferenceService {
  // TODO: Integrar com o pacote onnxruntime no futuro
  
  Future<bool> isValidImage(String imagePath) async {
    // Simula a execução do modelo OOD (Out-of-Distribution)
    await Future.delayed(const Duration(seconds: 1)); 
    return true; // Retorne false se o modelo detectar que não é uma lesão
  }

  Future<InferenceResult> runInference(ClinicalRecord record, AnalysisType type) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula processamento
    
    if (type == AnalysisType.triage) {
      return InferenceResult(label: 'P1', confidence: 0.92, type: type);
    } else {
      return InferenceResult(label: 'diagMelanomaName', confidence: 0.88, type: type);
    }
  }
}