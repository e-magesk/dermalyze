import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/l10n/app_localizations.dart';
import '../controller/login_controller.dart';
import '../../../shared/widgets/app_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller = LoginController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onLoginPressed() async {
    final l10n = AppLocalizations.of(context)!;
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // 1. Validação: Campos Vazios
    if (email.isEmpty || password.isEmpty) {
      _showErrorSnackBar(l10n.errorEmptyFields);
      return;
    }

    final error = await _controller.signIn(email, password);

    if (!mounted) return;

    if (error == null) {
      Navigator.pushReplacementNamed(context, '/home');
    } 
    else {
      _handleFirebaseError(error, l10n);
    }
  }

  // Função auxiliar para mapear erros do Firebase para suas mensagens l10n
  void _handleFirebaseError(String errorCode, AppLocalizations l10n) {
    String message;
    
    switch (errorCode) {
      case 'invalid-credential': 
        message = l10n.errorInvalidCredential;
        break;
      case 'user-not-found':
        message = l10n.errorUserNotFound;
        break;
      case 'wrong-password':
        message = l10n.errorInvalidCredential;
        break;
      case 'too-many-requests':
        message = l10n.errorTooManyRequests;
        break;
      case 'user-disabled':
        message = "Esta conta foi desativada.";
        break;
      case 'invalid-email':
        message = l10n.errorInvalidEmail;
        break;
      default:
        message = l10n.errorUnknown;
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
              // Logo e Título
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

              // Campos
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

              // Botão de Ação
              ValueListenableBuilder<bool>(
                valueListenable: _controller.isLoading,
                builder: (context, loading, child) {
                  return ElevatedButton(
                    onPressed: loading ? null : _onLoginPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 64),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 0,
                    ),
                    child: loading 
                      ? const CircularProgressIndicator(color: AppColors.white)
                      : Text(
                          l10n.authBtn,
                          style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.w900),
                        ),
                  );
                },
              ),
              const SizedBox(height: 24), // Espaçamento entre o botão e o link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.noAccount,
                    style: const TextStyle(
                      color: AppColors.textMedium,
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Futuramente:
                      // Navigator.pushNamed(context, '/register');
                    },
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