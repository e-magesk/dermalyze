import 'package:dermalyze/src/models/analysis_type.dart';
import 'package:flutter/material.dart';
import 'package:dermalyze/src/models/clinical_record.dart';

import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class SyncController extends ChangeNotifier {
  bool hasPendingSync = false;
  int pendingCount = 0;
  
  // O espião da conexão de internet
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  SyncController() {
    // Inicia o monitoramento assim que o Controller é criado (no main.dart)
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(_handleConnectionChange);
  }

  /// Método automático chamado sempre que a rede muda (ex: sai do modo avião)
  void _handleConnectionChange(List<ConnectivityResult> results) {
    // Se o resultado NÃO for "none" (ou seja, temos wifi ou rede móvel)
    if (!results.contains(ConnectivityResult.none)) {
      if (hasPendingSync) {
        print("Internet detectada! Iniciando sincronização em background...");
        syncPendingData();
      }
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel(); // Boa prática de memória
    super.dispose();
  }

  Future<void> enqueueOrSync({
    required ClinicalRecord record,
    required InferenceResult result,
  }) async {
    try {
      await _sendToServer(record, result);
      if (hasPendingSync) await syncPendingData();
    } catch (e) {
      print("Sem internet. Salvando localmente...");
      await _saveLocally(record, result);
    }
  }

  Future<void> syncPendingData() async {
    if (!hasPendingSync) return;

    try {
      // 1. Busca do banco local...
      // 2. Envia para a API...
      
      // 3. Sucesso!
      print("Sincronização em lote concluída com sucesso!");
      hasPendingSync = false;
      pendingCount = 0;
      notifyListeners();
    } catch (e) {
      print("A sincronização falhou (conexão instável). Tentaremos depois.");
    }
  }

  // --- MÉTODOS PRIVADOS SIMULADOS ---

  Future<void> _sendToServer(ClinicalRecord record, InferenceResult result) async {
    // Simula uma tentativa de API que falha 50% das vezes (para você testar)
    await Future.delayed(const Duration(seconds: 1));
    // throw Exception("Erro de rede"); // Descomente para forçar o erro e testar o offline
  }

  Future<void> _saveLocally(ClinicalRecord record, InferenceResult result) async {
    // Aqui você salvaria no SQLite/Hive.
    // O ideal é salvar o caminho da imagem e um JSON dos metadados.
    hasPendingSync = true;
    pendingCount++;
    notifyListeners(); // <--- ISSO AVISA A HOME PARA FICAR VERMELHA
  }
}