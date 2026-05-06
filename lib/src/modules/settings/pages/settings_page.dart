import 'package:dermalyze/src/features/language/controller/locale_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/features/auth/controller/auth_controller.dart';
import 'package:dermalyze/src/shared/widgets/app_bento_card.dart';

class SettingsPage extends StatelessWidget {
  final Function(int) onTabChange;

  const SettingsPage({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    final l10n = AppLocalizations.of(context)!;
    final isDoctor = authController.state == AuthState.doctor;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E293B)),
          onPressed: () => onTabChange(0),
        ),
        title: Text(l10n.settings, style: const TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.w900)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Perfil do Usuário
            Column(
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20)],
                  ),
                  child: const Icon(Icons.person_outline, size: 40, color: Color(0xFF94A3B8)),
                ),
                const SizedBox(height: 16),
                Text(l10n.activeSession, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                Text(
                  isDoctor ? l10n.medicalAccess : l10n.agentAccess,
                  style: const TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.w900, fontSize: 10, letterSpacing: 2),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Seleção de Idioma (Padrão Bento)
            BentoCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.language, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Color(0xFF94A3B8), letterSpacing: 1.5)),
                  const SizedBox(height: 16),
                  _buildLanguageOption(context, "Português", "pt"),
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  _buildLanguageOption(context, "English", "en"),
                ],
              ),
            ),
            
            const SizedBox(height: 16),

            // Botão de Logout
            BentoCard(
              onTap: () => authController.logout(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.logout, style: const TextStyle(color: Color(0xFFE11D48), fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 1)),
                  const Icon(Icons.logout, color: Color(0xFFE11D48), size: 20),
                ],
              ),
            ),
            
            const SizedBox(height: 32),
            const Text("Dermalyze v1.0.0", style: TextStyle(color: Color(0xFF94A3B8), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context, String label, String langCode) {
    final l10n = AppLocalizations.of(context)!;

    final localeController = context.read<LocaleController>();
    // Verifica se este é o idioma atualmente selecionado
    final isSelected = localeController.locale?.languageCode == langCode || 
                      (localeController.locale == null && langCode == 'pt');

    final languageLabel = (langCode == 'pt') ? l10n.portuguese : l10n.english; // Aqui você pode usar traduções se quiser

    return InkWell(
      onTap: () => localeController.setLocale(Locale(langCode)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(languageLabel, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            if (isSelected) const Icon(Icons.check_circle, color: Color(0xFF2563EB), size: 20),
          ],
        ),
      ),
    );
  }
}