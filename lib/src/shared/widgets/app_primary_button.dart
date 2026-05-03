import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ValueListenable<bool>? isLoading;

  const AppPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    // Se não for passado um listener de loading, usamos um padrão fixo em falso
    final loadingNotifier = isLoading ?? ValueNotifier<bool>(false);

    return ValueListenableBuilder<bool>(
      valueListenable: loadingNotifier,
      builder: (context, loading, child) {
        return ElevatedButton(
          onPressed: loading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            minimumSize: const Size(double.infinity, 64),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
          ),
          child: loading
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                    strokeWidth: 3,
                  ),
                )
              : Text(
                  text,
                  style: const TextStyle(
                    color: AppColors.white, 
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
        );
      },
    );
  }
}