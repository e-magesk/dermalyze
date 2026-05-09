import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:onnxruntime/onnxruntime.dart';
import 'package:image/image.dart' as img;

class OodOnnxService {
  static final OodOnnxService _instance = OodOnnxService._internal();
  factory OodOnnxService() => _instance;
  OodOnnxService._internal();

  OrtSession? _session;
  String? _inputName;

  // Inicializa o modelo OOD
  Future<void> initModel() async {
    if (_session != null) return;
    
    final modelData = await rootBundle.load('assets/models/ood_model.onnx');
    final sessionOptions = OrtSessionOptions();
    
    _session = OrtSession.fromBuffer(modelData.buffer.asUint8List(), sessionOptions);
    _inputName = _session?.inputNames[0];
  }

  // Pré-processamento: Redimensiona para 224x224 e aplica normalização ImageNet
  Float32List _preProcess(img.Image image) {
    var inputData = Float32List(1 * 3 * 224 * 224);
    int pixelCount = 0;
    int stride = 224 * 224;

    for (var y = 0; y < 224; y++) {
      for (var x = 0; x < 224; x++) {
        final pixel = image.getPixel(x, y);
        
        double r = pixel.r.toDouble();
        double g = pixel.g.toDouble();
        double b = pixel.b.toDouble();

        inputData[pixelCount] = ((r / 255.0) - 0.485) / 0.229;
        inputData[pixelCount + stride] = ((g / 255.0) - 0.456) / 0.224;
        inputData[pixelCount + (stride * 2)] = ((b / 255.0) - 0.406) / 0.225;
        
        pixelCount++;
      }
    }
    return inputData;
  }

  // Realiza a inferência OOD e retorna a nota (1 a 5)
  Future<double?> predictQualityScore(String imagePath) async {

    await initModel();

    final imageFile = File(imagePath);
    final rawImage = img.decodeImage(imageFile.readAsBytesSync());
    if (rawImage == null) return null;

    final resizedImage = img.copyResize(rawImage, width: 224, height: 224);
    final inputData = _preProcess(resizedImage);

    final inputOrt = OrtValueTensor.createTensorWithDataList(
      inputData,
      [1, 3, 224, 224], 
    );

    final inputs = {_inputName!: inputOrt};
    
    try {
      final outputs = await _session!.run(OrtRunOptions(), inputs);
      
      // Diferente da classificação (SoftMax), o modelo de regressão 
      // geralmente devolve uma matriz [[score]]
      final rawOutput = (outputs[0]?.value as List<List<double>>);
      final double score = rawOutput[0][0];

      inputOrt.release();

      return score;

    } catch (e) {
      debugPrint("Erro na inferência OOD: $e");
      inputOrt.release();
      return null;
    }
  }

  // Libera a memória quando não for mais usar
  void dispose() {
    _session?.release();
    _session = null;
  }
}