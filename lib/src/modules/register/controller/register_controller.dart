import 'package:firebase_auth/firebase_auth.dart';
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
    } on FirebaseAuthException catch (e) {
      return e.code; // Erros do Firebase (ex: email-already-in-use)
    } catch (e) {
      return e.toString(); // Erros do nosso backend Python
    } finally {
      isLoading.value = false;
    }
  }
}