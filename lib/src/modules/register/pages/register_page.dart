import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_primary_button.dart';
import '../../../shared/widgets/app_text_field.dart';
import 'package:dermalyze/src/core/l10n/app_localizations.dart';

// Importe os controllers da sua arquitetura
import 'package:dermalyze/src/features/auth/controller/auth_controller.dart';
import '../controller/register_controller.dart';

enum UserType { agent, doctor }

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Injeção de dependência dos controllers
  late final AuthController _authController;
  late final RegisterController _registerController;

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  // Controle do tipo de usuário
  UserType _selectedType = UserType.agent;

  @override
  void initState() {
    super.initState();
    // Recupera o estado global e inicializa o controlador local
    _authController = context.read<AuthController>();
    _registerController = RegisterController(_authController);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: AppColors.primary),
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

                // Botão Modularizado conectado ao estado de carregamento
                AppPrimaryButton(
                  text: l10n.registerBtn,
                  onPressed: _onRegisterPressed,
                  isLoading: _registerController.isLoading, 
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

  void _onRegisterPressed() async {
    // Validação básica do formulário
    if (_formKey.currentState!.validate()) {
      
      // Converte o enum para a string que o FastAPI aguarda
      final roleString = _selectedType == UserType.doctor ? 'doctor' : 'agent';
      
      final l10n = AppLocalizations.of(context)!;
      
      // Dispara a lógica de negócio
      final error = await _registerController.signUp(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        roleString,
      );

      // Previne erros se o usuário fechar a tela enquanto a requisição carrega
      if (!mounted) return;

      if (error != null) {
        _handleRegisterError(error, l10n);
      } else {
        // Sucesso absoluto! Fecha a tela de registro.
        // O AuthRouter na main assumirá o controle e carregará o dashboard.
        Navigator.pop(context);
      }
    }
  }

  void _handleRegisterError(String errorCode, AppLocalizations l10n) {
    String message;
    switch (errorCode) {
      case 'email-already-in-use':
        message = "Este email já está cadastrado.";
        break;
      case 'invalid-email':
        message = l10n.errorInvalidEmail;
        break;
      case 'weak-password':
        message = "A senha é muito fraca.";
        break;
      default:
        message = errorCode; // Exibe a resposta do backend FastAPI
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}