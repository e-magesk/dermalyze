import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dermalyze/src/features/auth/controller/auth_controller.dart';

class RegisterController {
  final AuthController _authController;

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  RegisterController(this._authController);

  Future<String?> signUp(String name, String email, String password, String role) async {
    try {
      isLoading.value = true;

      await _authController.register(email, password, name, role);

      return null; // Sucesso
    } on FirebaseException catch (e) {
      return e.code; // Erros do Auth (ex: email-already-in-use) e do Firestore
    } catch (e) {
      return e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
