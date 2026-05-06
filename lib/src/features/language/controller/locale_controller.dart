import 'package:flutter/material.dart';
import 'package:dermalyze/src/services/local_storage_service.dart';

class LocaleController extends ChangeNotifier {
  final LocalStorageService _localStorage;
  Locale? _locale;

  LocaleController({required LocalStorageService localStorage}) 
      : _localStorage = localStorage {
    _loadSavedLocale();
  }

  Locale? get locale => _locale;

  // Carrega o idioma salvo assim que o app inicia
  Future<void> _loadSavedLocale() async {
    final languageCode = await _localStorage.getLanguage();
    if (languageCode != null) {
      _locale = Locale(languageCode);
      notifyListeners();
    }
  }

  // Altera o idioma e salva no disco
  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    await _localStorage.saveLanguage(locale.languageCode);
    notifyListeners();
  }
}