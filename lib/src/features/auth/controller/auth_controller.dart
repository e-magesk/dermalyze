import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dermalyze/src/features/auth/repositories/auth_repository.dart';
import 'package:dermalyze/src/features/auth/repositories/user_api_repository.dart';
import 'package:dermalyze/src/services/local_storage_service.dart';

enum AuthState { loading, unauthenticated, doctor, agent }

class AuthController extends ChangeNotifier {
  final AuthRepository _authRepository;
  final UserApiRepository _apiRepository;
  final LocalStorageService _localStorage;

  AuthState state = AuthState.loading;

  AuthController({
    required AuthRepository authRepository,
    required UserApiRepository apiRepository,
    required LocalStorageService localStorage,
  })  : _authRepository = authRepository,
        _apiRepository = apiRepository,
        _localStorage = localStorage {
    checkAuthStatus();
  }

  // -----------------------------------------------------
  // 1. VERIFICAÇÃO INICIAL (Quem foi o último a logar?)
  // -----------------------------------------------------
  Future<void> checkAuthStatus() async {
    // Busca o UID do usuário que estava ativo por último
    final currentUid = await _localStorage.getCurrentUid();

    if (currentUid == null) {
      state = AuthState.unauthenticated;
    } else {
      // Busca a role específica para esse UID no banco local
      final role = await _localStorage.getRole(currentUid);
      
      if (role != null) {
        state = role == 'doctor' ? AuthState.doctor : AuthState.agent;
      } else {
        // Caso raro: UID existe mas os dados foram corrompidos
        state = AuthState.unauthenticated;
      }
    }
    
    notifyListeners(); 
  }

  // -----------------------------------------------------
  // 2. LOGIN (Com lógica de recuperação via API)
  // -----------------------------------------------------
  Future<void> login(String email, String password) async {
    // A. Login no Firebase
    final credential = await _authRepository.loginWithEmail(email, password);
    final uid = credential.user!.uid;

    // B. Tenta buscar a role localmente usando o UID
    String? role = await _localStorage.getRole(uid);

    // C. Fallback: Se não achar local (app reinstalado), busca no Backend Python
    if (role == null) {
      try {
        final userData = await _apiRepository.getUserByToken(uid);
        role = userData['role'];
        final name = userData['full_name'];

        // Salva localmente com o UID para futuros acessos offline
        await _localStorage.saveUserData(uid: uid, role: role!, name: name);
      } catch (e) {
        // Se o usuário não existir no seu banco central, deslogamos do Firebase
        await _authRepository.logout();
        throw Exception('Usuário não encontrado no banco de dados do Dermalyze.');
      }
    } else {
      // Se a role já existia localmente, apenas garantimos que esse UID 
      // está marcado como o "current_uid" (usuário ativo)
      await _localStorage.saveUserData(
        uid: uid, 
        role: role, 
        name: 'Usuário' // Poderia ser recuperado localmente também
      );
    }

    state = role == 'doctor' ? AuthState.doctor : AuthState.agent;
    notifyListeners();
  }

  // -----------------------------------------------------
  // 3. CADASTRO (Criação de novos usuários)
  // -----------------------------------------------------
  Future<void> register(String email, String password, String name, String role) async {
    // 1. Cria no Firebase
    final credential = await _authRepository.registerWithEmail(email, password);
    final uid = credential.user!.uid;

    // 2. Envia para o seu Backend FastAPI na UFES
    await _apiRepository.registerInBackend(
      fullName: name,
      role: role,
      firebaseToken: uid,
    );

    // 3. Salva no armazenamento seguro local usando o UID como chave
    await _localStorage.saveUserData(uid: uid, role: role, name: name);

    state = role == 'doctor' ? AuthState.doctor : AuthState.agent;
    notifyListeners();
  }

  // -----------------------------------------------------
  // 4. LOGOUT
  // -----------------------------------------------------
  Future<void> logout() async {
    await _authRepository.logout();
    // Apenas limpa quem é o usuário ativo, mantendo os dados salvos 
    // localmente para agilizar o próximo login desse mesmo usuário
    await _localStorage.clearCurrentUser();
    state = AuthState.unauthenticated;
    notifyListeners();
  }
}