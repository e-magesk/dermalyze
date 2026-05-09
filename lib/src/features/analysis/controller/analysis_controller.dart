import 'package:dermalyze/src/features/analysis/service/inference_service.dart';
import 'package:dermalyze/src/models/analysys_type.dart';
import 'package:dermalyze/src/models/clinical_record.dart';
import 'package:flutter/material.dart';

enum AnalysisState { idle, loading, success, error }

class AnalysisController extends ChangeNotifier {
  final InferenceService _service = InferenceService();
  AnalysisState state = AnalysisState.idle;
  InferenceResult? result;

  Future<void> startAnalysis(ClinicalRecord record, AnalysisType type) async {
    state = AnalysisState.loading;
    notifyListeners();

    try {
      result = await _service.runInference(record, type);
      state = AnalysisState.success;
    } catch (e) {
      state = AnalysisState.error;
    } finally {
      notifyListeners();
    }
  }

  void reset() {
    state = AnalysisState.idle;
    result = null;
    notifyListeners();
  }
}