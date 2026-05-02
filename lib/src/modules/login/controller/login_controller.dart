import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Notificador para o estado de loading (reatividade simples)
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<String?> signIn(String email, String password) async {
    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // Sucesso
    } 
    on FirebaseAuthException catch (e) {
      return e.code; // Retorna o erro para a UI tratar
    } 
    finally {
      isLoading.value = false;
    }
  }
}