import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter_onnxruntime/flutter_onnxruntime.dart'; // Atualizado
import 'package:image/image.dart' as img;
import 'package:dermalyze/src/models/analysis_type.dart';

class DiagnosticOnnxService {
  static final DiagnosticOnnxService _instance = DiagnosticOnnxService._internal();
  factory DiagnosticOnnxService() => _instance;
  DiagnosticOnnxService._internal();

  OrtSession? _session;
  List<String> _inputNames = [];
  
  static const List<String> LABELS = ["ACK", "BCC", "MEL", "NEV", "SCC", "SEK"];

  Future<void> initModel() async {
    if (_session != null) return;
    
    try {
      debugPrint('--> [initModel] Inicializando motor ONNX Runtime nativo...');
      
      final ort = OnnxRuntime();
      // A própria lib agora cuida de carregar o asset nativamente
      _session = await ort.createSessionFromAsset('assets/models/diag_model_v2.onnx');
      _inputNames = _session!.inputNames;
      
      debugPrint('--> [initModel] Sessão criada com sucesso. Inputs: $_inputNames');
    } catch (e, stackTrace) {
      debugPrint('ERRO FATAL AO CARREGAR O MODELO ONNX: $e');
      debugPrint(stackTrace.toString());
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
    debugPrint('Iniciando análise de diagnóstico para imagem: $imagePath');
    await initModel();

    // 1. Prepara a Imagem
    final rawImage = img.decodeImage(File(imagePath).readAsBytesSync());
    if (rawImage == null) return null;
    final resizedImage = img.copyResize(rawImage, width: 224, height: 224);
    final imageFloat32 = _preProcessImage(resizedImage);

    // 2. Cria os Tensores (Agora é assíncrono e usa OrtValue)
    final imageTensor = await OrtValue.fromList(imageFloat32, [1, 3, 224, 224]);
    final metaTensor = await OrtValue.fromList(metadataVec, [1, 100]);

    debugPrint('===================== kakakakakak ==============================');

    final inputs = {
      _inputNames[0]: imageTensor,
      _inputNames[1]: metaTensor,
    };
    
    try {
      // 3. Roda a inferência
      final outputs = await _session!.run(inputs, options: OrtRunOptions());
      
      // 4. Lê os resultados do Native e converte
      final outputName = _session!.outputNames[0];
      final rawOutput = await outputs[outputName]!.asFlattenedList();
      final rawScores = rawOutput.cast<double>(); // Converte de List<dynamic> para List<double>
      
      final probabilities = _softMax(rawScores);
      
      double maxProb = probabilities.reduce(max);
      int predIndex = probabilities.indexOf(maxProb);

      // 5. Liberação de memória assíncrona
      await imageTensor.dispose();
      await metaTensor.dispose();
      await outputs[outputName]!.dispose();

      debugPrint('Predicted Class: ${LABELS[predIndex]} with confidence: $maxProb');

      return InferenceResult(
        label: LABELS[predIndex], 
        confidence: maxProb, 
        type: AnalysisType.diagnosis
      );

    } catch (e) {
      debugPrint("Erro na inferência de diagnóstico: $e");
      await imageTensor.dispose();
      await metaTensor.dispose();
      return null;
    }
  }
}