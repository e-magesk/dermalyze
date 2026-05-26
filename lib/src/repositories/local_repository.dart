import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dermalyze/src/models/clinical_record.dart';
import 'package:dermalyze/src/models/analysis_type.dart';

class PendingSyncTask {
  final String id;
  final ClinicalRecord record;
  final InferenceResult result;

  PendingSyncTask({required this.id, required this.record, required this.result});

  // Converte a tarefa toda para JSON para salvar localmente
  Map<String, dynamic> toJson() => {
    'id': id,
    'record': {
      'age': record.age,
      'history': record.history?.name,
      'region': record.region,
      'imagePath': record.imagePath,
      'symptoms': record.symptoms.map((k, v) => MapEntry(k, v.name)),
    },
    'result': {
      'label': result.label,
      'confidence': result.confidence,
      'type': result.type.name,
    }
  };

  // Lógica reversa para quando a internet voltar
  factory PendingSyncTask.fromJson(Map<String, dynamic> json) {
    // Helper local para reconstruir o enum
    TripleOption parseTriple(String? val) {
      return TripleOption.values.firstWhere((e) => e.name == val, orElse: () => TripleOption.dontKnow);
    }

    final rMap = json['record'];
    final resMap = json['result'];

    return PendingSyncTask(
      id: json['id'],
      record: ClinicalRecord(
        age: rMap['age'],
        history: parseTriple(rMap['history']),
        region: rMap['region'],
        imagePath: rMap['imagePath'],
        symptoms: (rMap['symptoms'] as Map<String, dynamic>).map((k, v) => MapEntry(k, parseTriple(v))),
      ),
      result: InferenceResult(
        label: resMap['label'],
        confidence: resMap['confidence'],
        type: AnalysisType.values.firstWhere((e) => e.name == resMap['type']),
      ),
    );
  }
}

class LocalRepository {
  static const String _queueKey = 'sync_queue';

  // Salva um novo caso na fila local
  Future<void> saveToQueue(ClinicalRecord record, InferenceResult result) async {
    final prefs = await SharedPreferences.getInstance();
    final queue = await getQueue();
    
    final task = PendingSyncTask(
      id: DateTime.now().millisecondsSinceEpoch.toString(), 
      record: record, 
      result: result
    );
    
    queue.add(task);
    
    final List<String> jsonList = queue.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList(_queueKey, jsonList);
  }

  // Resgata todos os casos pendentes
  Future<List<PendingSyncTask>> getQueue() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList(_queueKey);
    
    if (jsonList == null || jsonList.isEmpty) return [];
    
    return jsonList.map((str) => PendingSyncTask.fromJson(jsonDecode(str))).toList();
  }

  // Remove um caso específico da fila após ser enviado com sucesso
  Future<void> removeFromQueue(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final queue = await getQueue();
    
    queue.removeWhere((task) => task.id == id);
    
    final List<String> jsonList = queue.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList(_queueKey, jsonList);
  }
}