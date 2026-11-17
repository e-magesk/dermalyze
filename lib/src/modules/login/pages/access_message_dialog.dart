import 'package:dermalyze/src/features/auth/access_control.dart';
import 'package:flutter/material.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';

/// Explica ao usuário que o acesso depende de liberação pelo Padtech.
///
/// Usado quando o login é recusado, quando o acesso é revogado com o app aberto
/// e logo após um cadastro.
Future<void> showAccessMessage(BuildContext context, AccessNotice notice) {
  final l10n = AppLocalizations.of(context)!;
  final registered = notice == AccessNotice.registered;

  return showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      icon: Icon(
        registered ? Icons.mark_email_read_outlined : Icons.lock_outline,
        color: registered ? AppColors.success : AppColors.primary,
        size: 32,
      ),
      title: Text(
        registered ? l10n.accessRegisteredTitle : l10n.accessNotGrantedTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.textDark, fontSize: 18),
      ),
      content: Text(
        registered ? l10n.accessRegisteredMessage : l10n.accessNotGrantedMessage,
        textAlign: TextAlign.center,
        style: const TextStyle(color: AppColors.textMedium, fontSize: 14, height: 1.5),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(
            l10n.btnOk,
            style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900),
          ),
        ),
      ],
    ),
  );
}
