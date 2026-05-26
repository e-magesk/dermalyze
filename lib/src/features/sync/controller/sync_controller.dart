import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:dermalyze/src/models/analysis_type.dart';
import 'package:dermalyze/src/models/clinical_record.dart';
import 'package:dermalyze/src/repositories/api_repository.dart';
import 'package:dermalyze/src/repositories/local_repository.dart';

class SyncController extends ChangeNotifier {
  bool hasPendingSync = false;
  int pendingCount = 0;
  bool isSyncing = false;
  
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  
  // Nossos novos repositórios modularizados
  final ApiRepository _apiRepo = ApiRepository();
  final LocalRepository _localRepo = LocalRepository();

  SyncController() {
    _initCheck();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(_handleConnectionChange);
  }

  // Verifica ao abrir o app se ficou algo para trás
  Future<void> _initCheck() async {
    final queue = await _localRepo.getQueue();
    if (queue.isNotEmpty) {
      hasPendingSync = true;
      pendingCount = queue.length;
      notifyListeners();
    }
  }

  void _handleConnectionChange(List<ConnectivityResult> results) {
    if (!results.contains(ConnectivityResult.none)) {
      if (hasPendingSync && !isSyncing) {
        debugPrint("Internet detectada! Iniciando sincronização em background...");
        syncPendingData();
      }
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // MÉTODO PRINCIPAL DE ENTRADA DE DADOS
  Future<void> enqueueOrSync({
    required ClinicalRecord record,
    required InferenceResult result,
  }) async {
    try {
      // 1. Tenta enviar direto pro servidor
      await _apiRepo.uploadCase(record, result);
      debugPrint("Enviado ao servidor imediatamente com sucesso!");
      
      // 2. Aproveita a boa conexão pra esvaziar a fila, se houver
      if (hasPendingSync) await syncPendingData();

    } catch (e) {
      debugPrint("Falha na conexão com servidor. Salvando localmente: $e");
      // 3. Se deu erro (sem internet, timeout, server offline), salva local
      await _localRepo.saveToQueue(record, result);
      
      hasPendingSync = true;
      pendingCount++;
      notifyListeners(); 
    }
  }

  // MÉTODO QUE PROCESSA A FILA
  Future<void> syncPendingData() async {
    if (!hasPendingSync || isSyncing) return;
    
    isSyncing = true;
    notifyListeners();

    try {
      final queue = await _localRepo.getQueue();
      
      for (var task in queue) {
        try {
          // Tenta enviar o caso pendente
          await _apiRepo.uploadCase(task.record, task.result);
          // Se deu sucesso, remove da fila local
          await _localRepo.removeFromQueue(task.id);
          
          pendingCount--;
          notifyListeners();
        } catch (e) {
          debugPrint("Falha ao sincronizar o caso ${task.id}: $e");
          // Aborta o loop se o primeiro falhou (provavelmente a net caiu de novo)
          break; 
        }
      }

      // Atualiza o estado final
      if (pendingCount <= 0) {
        hasPendingSync = false;
        pendingCount = 0;
        debugPrint("Sincronização em lote concluída com sucesso!");
      }
    } finally {
      isSyncing = false;
      notifyListeners();
    }
  }
}