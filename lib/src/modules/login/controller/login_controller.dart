import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dermalyze/src/features/auth/access_control.dart';
import 'package:dermalyze/src/features/auth/controller/auth_controller.dart';
class LoginController {

  final AuthController _authController;

  LoginController(this._authController);

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  /// Retorna `null` em caso de sucesso ou o código do erro.
  ///
  /// [AccessNotGrantedException] e [ProfileIncompleteException] sobem para a
  /// página, que mostra o diálogo correspondente.
  Future<String?> signIn(String email, String password) async {
    try {
      isLoading.value = true;

      await _authController.login(email, password);

      return null;
    }
    on AccessNotGrantedException {
      rethrow;
    }
    on ProfileIncompleteException {
      rethrow;
    }
    // Cobre o Auth (senha errada etc.) e o Firestore (sem rede etc.).
    on FirebaseException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
