import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importante para o context.read
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dermalyze/src/shared/widgets/app_primary_button.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../controller/login_controller.dart';
import 'package:dermalyze/src/features/auth/access_control.dart';
import 'package:dermalyze/src/features/auth/controller/auth_controller.dart';
import 'access_message_dialog.dart';
import 'complete_profile_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Usamos late para inicializar os controllers no initState
  late final AuthController _authController;
  late final LoginController _loginController;
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authController = context.read<AuthController>();
    _loginController = LoginController(_authController);

    // A sessão pode ter terminado por revogação de acesso com o app aberto: o
    // AuthRouter troca para esta tela e o aviso é mostrado assim que ela abre.
    final notice = _authController.consumeNotice();
    if (notice != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) showAccessMessage(context, notice);
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() async {
    final l10n = AppLocalizations.of(context)!;
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorSnackBar(l10n.errorEmptyFields);
      return;
    }

    // Chamada ao controller da tela
    final String? error;
    try {
      error = await _loginController.signIn(email, password);
    } on AccessNotGrantedException {
      if (!mounted) return;
      await showAccessMessage(context, AccessNotice.notGranted);
      return;
    } on ProfileIncompleteException {
      if (!mounted) return;
      await _completeProfile();
      return;
    }

    if (!mounted) return;

    if (error != null) {
      _handleLoginError(error, l10n);
    }
  }

  /// Contas sem perfil no Firestore (anteriores ao controle de acesso): pede
  /// nome e perfil, envia o cadastro e avisa que falta a liberação do Padtech.
  Future<void> _completeProfile() async {
    final l10n = AppLocalizations.of(context)!;

    final answer = await showDialog<ProfileAnswer>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CompleteProfileDialog(),
    );

    if (answer == null) {
      await _authController.cancelProfileCompletion();
      return;
    }

    final String? error = await _runCompleteProfile(answer);

    if (!mounted) return;

    if (error != null) {
      _handleLoginError(error, l10n);
      return;
    }

    await showAccessMessage(context, AccessNotice.registered);
  }

  Future<String?> _runCompleteProfile(ProfileAnswer answer) async {
    try {
      _loginController.isLoading.value = true;
      await _authController.completeProfile(name: answer.name, role: answer.role);
      return null;
    } on FirebaseException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    } finally {
      _loginController.isLoading.value = false;
    }
  }

  void _handleLoginError(String errorCode, AppLocalizations l10n) {
    String message;
    
    switch (errorCode) {
      case 'invalid-credential': 
      case 'wrong-password':
        message = l10n.errorInvalidCredential;
        break;
      case 'user-not-found':
        message = l10n.errorUserNotFound;
        break;
      case 'too-many-requests':
        message = l10n.errorTooManyRequests;
        break;
      case 'invalid-email':
        message = l10n.errorInvalidEmail;
        break;
      case 'network-request-failed':
      case 'unavailable':
        message = l10n.errorNetwork;
        break;
      default:
        message = errorCode; 
    }
    
    _showErrorSnackBar(message);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error, 
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2), // Sombra suave
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.appName,
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
              ),
              Text(
                l10n.appSubtitle,
                style: const TextStyle(color: AppColors.textLight, fontSize: 14),
              ),

              const SizedBox(height: 60),

              AppTextField(
                controller: _emailController,
                hintText: l10n.emailPlaceholder, 
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _passwordController,
                hintText: l10n.passwordPlaceholder,
                isPassword: true,
              ),
              const SizedBox(height: 32),

              AppPrimaryButton(
                text: l10n.authBtn,
                onPressed: _onLoginPressed,
                isLoading: _loginController.isLoading,
              ),

              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pushNamed(context, '/forgot-password'),
                child: Text(
                  l10n.forgotPasswordLink,
                  style: const TextStyle(
                    color: AppColors.textMedium,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.noAccount,
                    style: const TextStyle(color: AppColors.textMedium, fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/register'),
                    child: Text(
                      l10n.registerLink,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
