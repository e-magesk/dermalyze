import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:dermalyze/src/features/auth/controller/auth_controller.dart';
import 'package:dermalyze/src/modules/guide/pages/guide_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Abre as dúvidas frequentes já na seção da tela atual. Ao voltar, a tela de
/// origem continua como estava (formulário preenchido, resultado etc.).
class FaqHelpButton extends StatelessWidget {
  final GuideSection section;

  const FaqHelpButton({super.key, required this.section});

  void _open(BuildContext context) {
    // Lido no toque, e não no build: o perfil só define quais dúvidas aparecem.
    final isDoctor = context.read<AuthController>().state == AuthState.doctor;

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => GuidePage(isDoctor: isDoctor, focusSection: section),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return IconButton(
      onPressed: () => _open(context),
      // Também é o rótulo lido pelo leitor de tela.
      tooltip: l10n.guideFaqTitle,
      icon: const Icon(Icons.help_outline_rounded, color: AppColors.primary, size: 24),
    );
  }
}

/// Título de tela com o ícone de dúvidas frequentes logo ao lado.
///
/// O ícone fica junto ao título, e não no canto superior direito, porque é ali
/// que o dermatoscópio fica preso ao tablet durante a Análise Assistida.
class ScreenTitleWithHelp extends StatelessWidget {
  final String title;
  final TextStyle style;
  final GuideSection helpSection;

  const ScreenTitleWithHelp({
    super.key,
    required this.title,
    required this.style,
    required this.helpSection,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(child: Text(title, style: style)),
        const SizedBox(width: 4),
        FaqHelpButton(section: helpSection),
      ],
    );
  }
}
