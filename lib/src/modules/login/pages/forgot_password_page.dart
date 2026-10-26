import 'package:dermalyze/src/features/auth/repositories/auth_repository.dart';
import 'package:dermalyze/src/shared/widgets/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../controller/forgot_password_controller.dart';

/// Fluxo de recuperação de senha a partir da tela de Login.
class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late final ForgotPasswordController _controller;
  final _emailController = TextEditingController();

  /// Alterna o formulário pela confirmação de envio.
  bool _emailSent = false;
  String _sentTo = '';

  @override
  void initState() {
    super.initState();
    _controller = ForgotPasswordController(context.read<AuthRepository>());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onSendPressed() async {
    final l10n = AppLocalizations.of(context)!;
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showErrorSnackBar(l10n.forgotPasswordEmptyEmail);
      return;
    }

    final error = await _controller.sendResetLink(email);

    if (!mounted) return;

    if (error != null) {
      _showErrorSnackBar(_messageForError(error, l10n));
      return;
    }

    setState(() {
      _emailSent = true;
      _sentTo = email;
    });
  }

  String _messageForError(String errorCode, AppLocalizations l10n) {
    switch (errorCode) {
      case 'invalid-email':
        return l10n.errorInvalidEmail;
      case 'too-many-requests':
        return l10n.errorTooManyRequests;
      default:
        return l10n.errorUnknown;
    }
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 25,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(height: 32),
              _emailSent ? _buildSentConfirmation(l10n) : _buildForm(l10n),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(AppLocalizations l10n) {
    return Column(
      children: [
        Text(
          l10n.forgotPasswordTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppColors.textDark),
        ),
        const SizedBox(height: 12),
        Text(
          l10n.forgotPasswordSubtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.textMedium, fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 40),
        AppTextField(
          controller: _emailController,
          hintText: l10n.emailPlaceholder,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 24),
        AppPrimaryButton(
          text: l10n.forgotPasswordBtn,
          onPressed: _onSendPressed,
          isLoading: _controller.isLoading,
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            l10n.forgotPasswordBackToLogin,
            style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildSentConfirmation(AppLocalizations l10n) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: const BoxDecoration(
            color: AppColors.p5Bg,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.mark_email_read_outlined, color: AppColors.success, size: 34),
        ),
        const SizedBox(height: 24),
        Text(
          l10n.forgotPasswordSentTitle,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: AppColors.textDark),
        ),
        const SizedBox(height: 12),
        Text(
          l10n.forgotPasswordSentMessage(_sentTo),
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppColors.textMedium, fontSize: 14, height: 1.5),
        ),
        const SizedBox(height: 40),
        AppPrimaryButton(
          text: l10n.forgotPasswordBackToLogin,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
