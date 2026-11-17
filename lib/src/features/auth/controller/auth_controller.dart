import 'dart:async';

import 'package:dermalyze/src/features/auth/access_control.dart';
import 'package:dermalyze/src/features/auth/repositories/auth_repository.dart';
import 'package:dermalyze/src/features/auth/repositories/user_profile_repository.dart';
import 'package:dermalyze/src/services/local_storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

enum AuthState { loading, unauthenticated, doctor, agent }

/// Sessão do usuário e controle de acesso.
///
/// O perfil (agente/médico) e a liberação vêm do Firestore e são definidos pelo
/// Padtech no Console. O armazenamento seguro local guarda uma cópia do perfil
/// liberado, para que o app abra sem internet em campo.
class AuthController extends ChangeNotifier {
  final AuthRepository _authRepository;
  final UserProfileRepository _profileRepository;
  final LocalStorageService _localStorage;

  /// Chamado sempre que a sessão termina, seja pelo botão de sair ou por
  /// acesso revogado. O main.dart usa para fechar telas abertas e descartar
  /// resultados de paciente em memória.
  final VoidCallback? _onSessionEnded;

  AuthState state = AuthState.loading;
  String? _userName;
  AccessNotice? _pendingNotice;

  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<UserProfile?>? _profileSubscription;

  AuthController({
    required AuthRepository authRepository,
    required UserProfileRepository profileRepository,
    required LocalStorageService localStorage,
    VoidCallback? onSessionEnded,
  })  : _authRepository = authRepository,
        _profileRepository = profileRepository,
        _localStorage = localStorage,
        _onSessionEnded = onSessionEnded {
    // O Firebase encerra a sessão sozinho quando a conta é desativada ou
    // excluída no Console (pode levar até ~1h, a validade do token).
    _authSubscription = _authRepository.authStateChanges().listen((user) {
      if (user == null && _isSignedIn) {
        _endSession(notice: AccessNotice.notGranted);
      }
    });

    checkAuthStatus();
  }

  String? get userName => _userName;

  bool get _isSignedIn => state == AuthState.doctor || state == AuthState.agent;

  /// Aviso a ser exibido pela tela de login após o fim da sessão. É devolvido
  /// uma única vez.
  AccessNotice? consumeNotice() {
    final notice = _pendingNotice;
    _pendingNotice = null;
    return notice;
  }

  AuthState _stateForRole(String role) =>
      role == kRoleDoctor ? AuthState.doctor : AuthState.agent;

  // -----------------------------------------------------
  // 1. VERIFICAÇÃO INICIAL (Quem foi o último a logar?)
  // -----------------------------------------------------
  Future<void> checkAuthStatus() async {
    // O primeiro evento traz o usuário que o Firebase restaurou do aparelho.
    final user = await _authRepository.authStateChanges().first;
    final cachedUid = await _localStorage.getCurrentUid();

    String? role;
    String? name;
    if (user != null && user.uid == cachedUid) {
      role = await _localStorage.getRole(user.uid);
      name = await _localStorage.getName(user.uid);
    }

    if (user == null || role == null) {
      // Sem sessão, ou sessão sem perfil liberado em cache — por exemplo, o
      // app foi fechado no meio do "Complete seu cadastro".
      if (user != null) await _authRepository.logout();
      await _localStorage.clearCurrentUser();
      state = AuthState.unauthenticated;
      notifyListeners();
      return;
    }

    // Perfil liberado em cache: entra mesmo sem internet (uso em campo). O
    // listener confirma no servidor assim que houver conexão.
    _userName = name;
    state = _stateForRole(role);
    notifyListeners();
    _watchProfile(user.uid);
  }

  // -----------------------------------------------------
  // 2. LOGIN
  // -----------------------------------------------------

  /// Entra no app se o Padtech tiver liberado o acesso.
  ///
  /// Lança [AccessNotGrantedException] se o acesso não foi liberado e
  /// [ProfileIncompleteException] se a conta ainda não tem perfil.
  Future<void> login(String email, String password) async {
    // A. Login no Firebase
    final credential = await _authRepository.loginWithEmail(email, password);
    final user = credential.user!;

    // B. Perfil e liberação, direto do servidor
    final UserProfile? profile;
    try {
      profile = await _profileRepository.fetchProfile(user.uid);
    } catch (_) {
      // Sem confirmar a liberação, não entra.
      await _authRepository.logout();
      rethrow;
    }

    if (profile == null) {
      // Conta anterior ao controle de acesso. A sessão fica aberta para a
      // tela de login gravar o perfil.
      throw const ProfileIncompleteException();
    }

    if (!profile.canAccess) {
      await _authRepository.logout();
      throw const AccessNotGrantedException();
    }

    // C. Guarda o perfil localmente para abrir offline nas próximas vezes
    await _localStorage.saveUserData(uid: user.uid, role: profile.role, name: profile.name);

    _userName = profile.name;
    state = _stateForRole(profile.role);
    notifyListeners();
    _watchProfile(user.uid);
  }

  /// Cria o perfil de uma conta que ainda não tinha (ver
  /// [ProfileIncompleteException]) e encerra a sessão: o perfil nasce pendente
  /// até o Padtech liberar.
  Future<void> completeProfile({required String name, required String role}) async {
    final user = _authRepository.currentUser;
    if (user == null) {
      throw StateError('Nenhuma sessão ativa para completar o cadastro.');
    }

    try {
      await user.updateDisplayName(name);
      await _profileRepository.createProfile(
        uid: user.uid,
        name: name,
        email: user.email!,
        role: role,
      );
    } finally {
      await _authRepository.logout();
    }
  }

  /// Encerra a sessão aberta para completar o cadastro quando o usuário desiste.
  Future<void> cancelProfileCompletion() => _authRepository.logout();

  // -----------------------------------------------------
  // 3. CADASTRO (Criação de novos usuários)
  // -----------------------------------------------------

  /// Cria a conta e o perfil pendente, e encerra a sessão: o usuário só entra
  /// depois que o Padtech liberar o acesso no Console.
  ///
  /// Se a criação do perfil falhar, a conta fica sem perfil e o próximo login
  /// cai em [ProfileIncompleteException], que permite completar o cadastro.
  Future<void> register(String email, String password, String name, String role) async {
    final credential = await _authRepository.registerWithEmail(email, password);
    final user = credential.user!;

    try {
      await user.updateDisplayName(name);
      await _profileRepository.createProfile(
        uid: user.uid,
        name: name,
        email: user.email ?? email,
        role: role,
      );
    } finally {
      await _authRepository.logout();
    }
  }

  // -----------------------------------------------------
  // 4. ACOMPANHAMENTO EM TEMPO REAL
  // -----------------------------------------------------

  /// Aplica na hora o que o Padtech mudar no Console: revogar o acesso encerra
  /// a sessão, trocar o perfil troca as abas disponíveis.
  void _watchProfile(String uid) {
    _profileSubscription?.cancel();
    _profileSubscription = _profileRepository.watchProfile(uid).listen(
      (profile) => _applyServerProfile(uid, profile),
      // Erros não encerram a sessão: sem conseguir confirmar a revogação, o
      // profissional não pode ficar travado no meio de um atendimento.
      onError: (Object error) => debugPrint('Falha ao acompanhar o perfil: $error'),
    );
  }

  Future<void> _applyServerProfile(String uid, UserProfile? profile) async {
    if (!_isSignedIn) return;

    if (profile == null || !profile.canAccess) {
      await _endSession(notice: AccessNotice.notGranted);
      return;
    }

    final newState = _stateForRole(profile.role);
    if (newState == state && profile.name == _userName) return;

    await _localStorage.saveUserData(uid: uid, role: profile.role, name: profile.name);
    _userName = profile.name;
    state = newState;
    notifyListeners();
  }

  // -----------------------------------------------------
  // 5. LOGOUT
  // -----------------------------------------------------
  Future<void> logout() => _endSession();

  Future<void> _endSession({AccessNotice? notice}) async {
    if (!_isSignedIn) return;

    // O estado muda antes de qualquer await: assim o authStateChanges disparado
    // pelo próprio signOut não chama esta função de novo.
    final profileSubscription = _profileSubscription;
    _profileSubscription = null;
    _pendingNotice = notice;
    _userName = null;
    state = AuthState.unauthenticated;
    _onSessionEnded?.call();
    notifyListeners();

    await profileSubscription?.cancel();

    // O perfil em cache sai junto: um acesso revogado não pode continuar
    // valendo offline neste aparelho. O próximo login busca tudo no servidor.
    final uid = await _localStorage.getCurrentUid();
    if (uid != null) await _localStorage.clearUserData(uid);
    await _localStorage.clearCurrentUser();

    await _authRepository.logout();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    _profileSubscription?.cancel();
    super.dispose();
  }
}
