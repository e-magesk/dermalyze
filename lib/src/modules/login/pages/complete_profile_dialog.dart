import 'package:flutter/material.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_text_field.dart';
import 'package:dermalyze/src/features/auth/access_control.dart';

/// Resposta do diálogo de completar o cadastro.
class ProfileAnswer {
  final String name;

  /// [kRoleAgent] ou [kRoleDoctor], no formato do campo `role` do Firestore.
  final String role;

  const ProfileAnswer({required this.name, required this.role});
}

enum _ProfileOption { agent, doctor }

/// Pede nome e perfil para contas que ainda não têm perfil no Firestore —
/// criadas antes do controle de acesso, ou cujo cadastro falhou no meio.
///
/// Devolve um [ProfileAnswer] via `Navigator.pop`, ou `null` se o usuário
/// desistir. O perfil é criado pendente, até o Padtech liberar.
///
/// É um widget próprio de propósito: assim o [TextEditingController] nasce e
/// morre junto com o diálogo. Criá-lo fora e descartá-lo logo após o
/// `await showDialog` o destruía no meio da animação de saída, enquanto o campo
/// de texto ainda estava montado — o que quebrava a desmontagem da árvore.
class CompleteProfileDialog extends StatefulWidget {
  const CompleteProfileDialog({super.key});

  @override
  State<CompleteProfileDialog> createState() => _CompleteProfileDialogState();
}

class _CompleteProfileDialogState extends State<CompleteProfileDialog> {
  final _nameController = TextEditingController();
  _ProfileOption _selected = _ProfileOption.agent;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _confirm() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    Navigator.of(context).pop(
      ProfileAnswer(
        name: name,
        role: _selected == _ProfileOption.doctor ? kRoleDoctor : kRoleAgent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Text(
        l10n.completeProfileTitle,
        style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.textDark, fontSize: 18),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.completeProfileMessage,
              style: const TextStyle(color: AppColors.textMedium, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 20),
            AppTextField(
              controller: _nameController,
              hintText: l10n.fullNameLabel,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 20),
            Text(
              l10n.userTypeLabel,
              style: const TextStyle(color: AppColors.textMedium, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: SegmentedButton<_ProfileOption>(
                segments: [
                  ButtonSegment(value: _ProfileOption.agent, label: Text(l10n.healthAgent)),
                  ButtonSegment(value: _ProfileOption.doctor, label: Text(l10n.doctor)),
                ],
                selected: {_selected},
                onSelectionChanged: (selection) {
                  setState(() => _selected = selection.first);
                },
                style: SegmentedButton.styleFrom(
                  selectedBackgroundColor: AppColors.primary,
                  selectedForegroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            l10n.btnCancel,
            style: const TextStyle(color: AppColors.textMedium, fontWeight: FontWeight.w700),
          ),
        ),
        // Só habilita com o nome preenchido, em vez de ignorar o toque.
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _nameController,
          builder: (context, value, _) {
            final hasName = value.text.trim().isNotEmpty;
            return TextButton(
              onPressed: hasName ? _confirm : null,
              child: Text(
                l10n.completeProfileConfirm,
                style: TextStyle(
                  color: hasName ? AppColors.primary : AppColors.textLight,
                  fontWeight: FontWeight.w900,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
