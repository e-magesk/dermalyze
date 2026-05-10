import 'package:dermalyze/src/models/analysis_type.dart';
import 'package:dermalyze/src/models/clinical_record.dart';
import 'package:dio/dio.dart';

class UserApiRepository {
  final Dio _dio;

  final String baseUrl = 'http://192.168.1.75:8000'; 

  UserApiRepository({required Dio dio}) : _dio = dio;

  // Chamada para o POST /auth/register
  Future<Map<String, dynamic>> registerInBackend({
    required String fullName,
    required String role,
    required String firebaseToken,
  }) async {
    try {
      final response = await _dio.post(
        '$baseUrl/user/register',
        data: {
          'full_name': fullName,
          'role': role,
          'firebase_token': firebaseToken,
        },
      );
      return response.data; // Retorna o JSON validado pelo Pydantic
    } on DioException catch (e) {
      throw Exception('Erro ao salvar no backend: ${e.response?.data['detail'] ?? e.message}');
    }
  }

  Future<Map<String, dynamic>> getUserByToken(String firebaseToken) async {
    try {
      final response = await _dio.get('$baseUrl/user/$firebaseToken');
      return response.data; // Retorna o JSON com nome, role, etc.
    } on DioException catch (e) {
      throw Exception('Erro ao buscar usuário no servidor: ${e.response?.data['detail'] ?? e.message}');
    }
  }
}

// Mock do Serviço de API (Pode ficar em outro arquivo depois)
class AnalysisApiRepository {
  Future<void> saveAnalysis({
    required ClinicalRecord record,
    required InferenceResult result,
  }) async {
    // Aqui você enviaria um multipart/form-data com a imagem, 
    // JSON dos metadados, result.label e result.confidence para o seu servidor.
    print("Enviando para o servidor... ${result.label} (${result.confidence * 100}%)");
    await Future.delayed(const Duration(seconds: 1)); 
  }
}