import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter_onnxruntime/flutter_onnxruntime.dart';
import 'package:image/image.dart' as img;

class OodOnnxService {
  static final OodOnnxService _instance = OodOnnxService._internal();
  factory OodOnnxService() => _instance;
  OodOnnxService._internal();

  OrtSession? _session;
  String? _inputName;

  Future<void> initModel() async {
    if (_session != null) return;
    
    final ort = OnnxRuntime();
    _session = await ort.createSessionFromAsset('assets/models/ood_model.onnx');
    _inputName = _session?.inputNames[0];
  }

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

  Future<double?> predictQualityScore(String imagePath) async {
    await initModel();

    final imageFile = File(imagePath);
    final rawImage = img.decodeImage(imageFile.readAsBytesSync());
    if (rawImage == null) return null;

    final resizedImage = img.copyResize(rawImage, width: 224, height: 224);
    final inputData = _preProcess(resizedImage);

    final inputOrt = await OrtValue.fromList(
      inputData,
      [1, 3, 224, 224], 
    );

    final inputs = {_inputName!: inputOrt};
    
    try {
      final outputs = await _session!.run(inputs, options: OrtRunOptions());
      
      final outputName = _session!.outputNames[0];
      final rawOutput = await outputs[outputName]!.asFlattenedList();
      final double score = rawOutput[0].toDouble(); // Regressão simples

      await inputOrt.dispose();
      await outputs[outputName]!.dispose();

      return score;

    } catch (e) {
      debugPrint("Erro na inferência OOD: $e");
      await inputOrt.dispose();
      return null;
    }
  }

  // O dispose da sessão precisa ser async agora
  Future<void> dispose() async {
    await _session?.close();
    _session = null;
  }
}