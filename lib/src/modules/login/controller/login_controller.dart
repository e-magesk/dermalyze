import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dermalyze/src/features/auth/controller/auth_controller.dart';
class LoginController {

  final AuthController _authController;

  LoginController(this._authController);

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<String?> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      
      await _authController.login(email, password);
      
      return null;
    } 
    on FirebaseAuthException catch (e) {
      return e.code; // Erros específicos do Firebase (senha errada, etc)
    } catch (e) {
      return e.toString(); // Erros da API Python ou de falha de conexão
    } finally {
      isLoading.value = false;
    }
  }
}