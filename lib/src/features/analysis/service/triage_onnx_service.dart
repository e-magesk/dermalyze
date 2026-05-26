import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_onnxruntime/flutter_onnxruntime.dart';
import 'package:image/image.dart' as img;
import 'package:dermalyze/src/models/analysis_type.dart';

class TriageOnnxService {
  static final TriageOnnxService _instance = TriageOnnxService._internal();
  factory TriageOnnxService() => _instance;
  TriageOnnxService._internal();

  OrtSession? _session;
  List<String> _inputNames = [];
  
  static const List<String> LABELS = ["P1", "P2", "P3", "P4", "P5"];

  Future<void> initModel() async {
    if (_session != null) return;
    try {
      final ort = OnnxRuntime();
      _session = await ort.createSessionFromAsset('assets/models/triage_model.onnx');
      _inputNames = _session!.inputNames;
    } catch (e) {
      debugPrint('ERRO FATAL AO CARREGAR O MODELO DE TRIAGEM ONNX: $e');
      rethrow; 
    }
  }

  Float32List _preProcessImage(img.Image image) {
    var inputData = Float32List(1 * 3 * 224 * 224);
    int pixelCount = 0;
    int stride = 224 * 224;

    for (var y = 0; y < 224; y++) {
      for (var x = 0; x < 224; x++) {
        final pixel = image.getPixel(x, y);
        inputData[pixelCount] = ((pixel.r / 255.0) - 0.485) / 0.229;
        inputData[pixelCount + stride] = ((pixel.g / 255.0) - 0.456) / 0.224;
        inputData[pixelCount + (stride * 2)] = ((pixel.b / 255.0) - 0.406) / 0.225;
        pixelCount++;
      }
    }
    return inputData;
  }

  List<double> _softMax(List<double> input) {
    double maxVal = input.reduce(max);
    List<double> expValues = input.map((e) => exp(e - maxVal)).toList();
    double sumExp = expValues.reduce((a, b) => a + b);
    return expValues.map((e) => e / sumExp).toList();
  }

  Future<InferenceResult?> predict(String imagePath, Float32List metadataVec) async {
    await initModel();

    final rawImage = img.decodeImage(File(imagePath).readAsBytesSync());
    if (rawImage == null) return null;
    final resizedImage = img.copyResize(rawImage, width: 224, height: 224);
    final imageFloat32 = _preProcessImage(resizedImage);

    final imageTensor = await OrtValue.fromList(imageFloat32, [1, 3, 224, 224]);
    final metaTensor = await OrtValue.fromList(metadataVec, [1, 96]);

    final inputs = {
      _inputNames[0]: imageTensor,
      _inputNames[1]: metaTensor,
    };
    
    try {
      final outputs = await _session!.run(inputs, options: OrtRunOptions());
      
      final outputName = _session!.outputNames[0];
      final rawOutput = await outputs[outputName]!.asFlattenedList();
      final rawScores = rawOutput.cast<double>();
      final probabilities = _softMax(rawScores);
      
      double maxProb = probabilities.reduce(max);
      int predIndex = probabilities.indexOf(maxProb);

      await imageTensor.dispose();
      await metaTensor.dispose();
      await outputs[outputName]!.dispose();

      return InferenceResult(
        label: LABELS[predIndex], 
        confidence: maxProb, 
        type: AnalysisType.triage
      );

    } catch (e) {
      debugPrint("Erro na inferência de triagem: $e");
      await imageTensor.dispose();
      await metaTensor.dispose();
      return null;
    }
  }
}