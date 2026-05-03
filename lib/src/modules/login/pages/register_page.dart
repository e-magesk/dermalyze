import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_primary_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import 'package:dermalyze/src/core/l10n/app_localizations.dart';

enum UserType { agent, doctor }

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  // Controle do tipo de usuário
  UserType _selectedType = UserType.agent;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: AppColors.primary),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Logo Reduzido para dar espaço aos novos campos
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 80,
                  height: 80,
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.registerTitle,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppColors.textDark),
                ),
                const SizedBox(height: 32),

                // Seleção de Perfil (Agente ou Médico)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.userTypeLabel, style: const TextStyle(color: AppColors.textMedium, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: SegmentedButton<UserType>(
                        segments: [
                          ButtonSegment(value: UserType.agent, label: Text(l10n.healthAgent), icon: const Icon(Icons.person_search)),
                          ButtonSegment(value: UserType.doctor, label: Text(l10n.doctor), icon: const Icon(Icons.medical_services)),
                        ],
                        selected: {_selectedType},
                        onSelectionChanged: (newSelection) {
                          setState(() => _selectedType = newSelection.first);
                        },
                        style: SegmentedButton.styleFrom(
                          selectedBackgroundColor: AppColors.primary,
                          selectedForegroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Campos de Texto
                AppTextField(
                  controller: _nameController,
                  hintText: l10n.fullNameLabel,
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) return l10n.errorEmptyFields;
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _emailController,
                  hintText: l10n.emailPlaceholder,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) return l10n.errorEmptyFields;
                    // Regex simples para feedback visual imediato
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return l10n.errorInvalidEmail;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _passwordController,
                  hintText: l10n.passwordPlaceholder,
                  isPassword: true,
                  prefixIcon: Icons.lock_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) return l10n.errorEmptyFields;
                    if (value.length < 6) return "A senha deve ter pelo menos 6 caracteres";
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _confirmPasswordController,
                  hintText: l10n.confirmPasswordLabel,
                  isPassword: true,
                  prefixIcon: Icons.lock_reset_outlined,
                  validator: (value) {
                    if (value == null || value.isEmpty) return l10n.errorEmptyFields;
                    if (value != _passwordController.text) return "As senhas não coincidem";
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // Botão Modularizado
                AppPrimaryButton(
                  text: l10n.registerBtn,
                  onPressed: _onRegisterPressed,
                  // isLoading: _controller.isLoading, // Conectaremos ao controller depois
                ),

                const SizedBox(height: 24),
                
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    l10n.alreadyHaveAccount,
                    style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onRegisterPressed() {
    // Validação básica de confirmação de senha
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Sucesso! Todos os campos estão válidos.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green.shade600, // Cor de sucesso
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
    }
  }
}