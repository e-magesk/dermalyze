enum AnalysisType { triage, diagnosis }

class InferenceResult {
  final String label;      // P1..P5 ou Nome da Doença
  final double confidence; // Score de confiança (0.0 a 1.0)
  final AnalysisType type;
  final String? oodStatus; // 'valid' ou 'invalid'

  InferenceResult({
    required this.label,
    required this.confidence,
    required this.type,
    this.oodStatus,
  });
}