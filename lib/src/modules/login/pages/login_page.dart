import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importante para o context.read
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dermalyze/src/shared/widgets/app_primary_button.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../controller/login_controller.dart';
import 'package:dermalyze/src/features/auth/controller/auth_controller.dart';

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
    final error = await _loginController.signIn(email, password);

    if (!mounted) return;

    if (error != null) {
      _handleLoginError(error, l10n);
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
              
              const SizedBox(height: 24),
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