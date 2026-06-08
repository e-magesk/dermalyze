import 'dart:convert';
import 'package:dermalyze/src/services/local_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dermalyze/src/models/clinical_record.dart';
import 'package:dermalyze/src/models/analysis_type.dart';
import 'package:dermalyze/src/features/sync/controller/sync_controller.dart';

class ApiRepository {

  final LocalStorageService _localStorage;

  ApiRepository({required LocalStorageService localStorage}) : _localStorage = localStorage;

  // Substitua pelo IP da sua máquina. Se usar emulador Android, pode precisar de 10.0.2.2
  static const String baseUrl = 'http://192.168.1.75:8000'; 

  Future<void> uploadCase(ClinicalRecord record, InferenceResult result) async {
    final uri = Uri.parse('$baseUrl/clinical/upload');
    final request = http.MultipartRequest('POST', uri);

    // 1. Anexando a Imagem (Multipart)
    if (record.imagePath != null && record.imagePath!.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('file', record.imagePath!));
    } else {
      throw Exception('Imagem é obrigatória para o upload');
    }

    debugPrint('Preparando dados para upload: $record');

    // 2. Mapeando os campos do Flutter para o FastAPI (schemas.ClinicalForm)
    // Nota: FastAPI geralmente recebe Depends() form-data como strings que ele converte depois.
    request.fields['age'] = record.age?.toString() ?? '';
    request.fields['macro_body_region'] = record.region ?? '';
    
    // Mapeamento do TripleOption para String/Booleano pro Python
    request.fields['family_cancer_history'] = _tripleToStr(record.history);
    request.fields['has_itched'] = _tripleToStr(record.symptoms['itch']);
    request.fields['has_bled'] = _tripleToStr(record.symptoms['bleed']);
    request.fields['has_grown'] = _tripleToStr(record.symptoms['grow']);
    request.fields['has_hurt'] = _tripleToStr(record.symptoms['hurt']);
    request.fields['has_changed'] = _tripleToStr(record.symptoms['change']);
    request.fields['has_elevation'] = _tripleToStr(record.symptoms['elevate']);

    request.fields['user_id'] = await _localStorage.getCurrentUid() ?? 'unknown_user';

    // Opcional: Enviando o resultado da IA junto (caso você atualize o backend para receber)
    request.fields['prediction'] = result.label;
    request.fields['prediction_confidence'] = result.confidence.toString();
    request.fields['prediction_type'] = result.type.name;

    // 3. Executando a requisição
    final response = await request.send();

    if (response.statusCode != 200 && response.statusCode != 201) {
      final respStr = await response.stream.bytesToString();
      throw Exception('Falha ao enviar para o servidor: $respStr');
    }
  }

  // Função auxiliar para converter o seu Enum TripleOption para formato legível no Python
  String _tripleToStr(TripleOption? option) {
    if (option == TripleOption.yes) return 'true';
    if (option == TripleOption.no) return 'false';
    return 'unknown'; // Ou 'unknown', dependendo de como está o seu backend
  }
}