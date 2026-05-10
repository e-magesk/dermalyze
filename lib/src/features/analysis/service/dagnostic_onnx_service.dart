import 'dart:io';
import 'dart:typed_data';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:onnxruntime/onnxruntime.dart';
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
      debugPrint('--> [initModel] Carregando arquivo do modelo dos assets...');
      
      // VERIFIQUE SE O NOME DO ARQUIVO AQUI É EXATAMENTE O QUE ESTÁ NA SUA PASTA E NO PUBSPEC
      final modelData = await rootBundle.load('assets/models/diag_model.onnx');
      
      debugPrint('--> [initModel] Arquivo lido. Criando sessão ONNX...');
      _session = OrtSession.fromBuffer(modelData.buffer.asUint8List(), OrtSessionOptions());
      _inputNames = _session!.inputNames;
      
      debugPrint('--> [initModel] Sessão criada com sucesso. Inputs: $_inputNames');
      
    } catch (e, stackTrace) {
      debugPrint('================================================================');
      debugPrint('ERRO FATAL AO CARREGAR O MODELO ONNX:');
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
      debugPrint('================================================================');
      // Repassa o erro para frente para que a tela não fique em loading eterno
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

    debugPrint('================================================================');
    debugPrint('Iniciando análise de diagnóstico para imagem: $imagePath');

    await initModel();

    debugPrint('Modelo ONNX carregado com sucesso. Preparando dados para inferência...');

    // 1. Prepara a Imagem
    final rawImage = img.decodeImage(File(imagePath).readAsBytesSync());
    if (rawImage == null) return null;
    final resizedImage = img.copyResize(rawImage, width: 224, height: 224);
    final imageFloat32 = _preProcessImage(resizedImage);

    debugPrint('Imagem preparada para inferência.');

    // 2. Cria os Tensores (Shape da Imagem: [1, 3, 224, 224] | Shape do Metadado: [1, 96])
    final imageTensor = OrtValueTensor.createTensorWithDataList(imageFloat32, [1, 3, 224, 224]);
    final metaTensor = OrtValueTensor.createTensorWithDataList(metadataVec, [1, 96]);

    debugPrint('Tensores criados com sucesso.');

    // O modelo python usa input_names[0] para a imagem e [1] para o metadado.
    final inputs = {
      _inputNames[0]: imageTensor,
      _inputNames[1]: metaTensor,
    };
    
    debugPrint('Executando inferência...');

    try {
      final outputs = await _session!.run(OrtRunOptions(), inputs);
      
      debugPrint('Inferência concluída. Processando resultados...');

      // A saída bruta de scores
      final rawScores = (outputs[0]?.value as List<List<double>>)[0];
      final probabilities = _softMax(rawScores);
      
      // Pega a classe majoritária
      double maxProb = probabilities.reduce(max);
      int predIndex = probabilities.indexOf(maxProb);

      imageTensor.release();
      metaTensor.release();

      debugPrint('================================================================');
      debugPrint('Predicted Class: ${LABELS[predIndex]} with confidence: $maxProb');

      return InferenceResult(
        label: LABELS[predIndex], 
        confidence: maxProb, 
        type: AnalysisType.diagnosis
      );

    } catch (e) {
      debugPrint("Erro na inferência de diagnóstico: $e");
      imageTensor.release();
      metaTensor.release();
      return null;
    }
  }
}