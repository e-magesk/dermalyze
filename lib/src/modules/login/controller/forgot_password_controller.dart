import 'package:dermalyze/src/features/auth/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ForgotPasswordController {
  final AuthRepository _authRepository;

  ForgotPasswordController(this._authRepository);

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  /// Envia o link de redefinição de senha.
  ///
  /// Retorna `null` em caso de sucesso, ou o código do erro do Firebase.
  ///
  /// `user-not-found` é tratado como sucesso de propósito: responder de forma
  /// diferente para e-mails cadastrados e não cadastrados permitiria descobrir
  /// quem tem conta no app. A tela mostra sempre a mesma confirmação.
  Future<String?> sendResetLink(String email) async {
    try {
      isLoading.value = true;

      await _authRepository.sendPasswordResetEmail(email);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') return null;
      return e.code;
    } catch (e) {
      return e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void dispose() {
    isLoading.dispose();
  }
}
