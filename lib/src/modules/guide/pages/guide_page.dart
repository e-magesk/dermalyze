import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:dermalyze/src/shared/widgets/app_bento_card.dart';
import 'package:flutter/material.dart';
import 'package:dermalyze/src/core/l10n/app_localizations.dart';

class GuidePage extends StatelessWidget {
  // Simulação do papel do usuário; em produção, viria de um AuthController
  final bool isDoctor;

  const GuidePage({super.key, this.isDoctor = true});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false, // Garante que não centralize no iOS
        titleSpacing: 24,
        title: Text(
          l10n.guideTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: AppColors.textDark,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. CARD DE RESPONSABILIDADE (Estilo Alerta Rose/Red)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.p1Malign, // Rosa/Vermelho do monólito
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.p1Malign.withValues(alpha: .2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.guideRespTitle,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.guideRespBody,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      l10n.guideRespFooter,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // 2. TÍTULO DO FLUXO (DINÂMICO)
            Row(
              children: [
                const Icon(Icons.bolt_rounded, color: AppColors.primary, size: 24),
                const SizedBox(width: 8),
                Text(
                  isDoctor ? l10n.guideFlowTitleDoctor : l10n.guideFlowTitleAgent,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 3. PASSO A PASSO (Bento Grid)
            BentoCard(
              child: Column(
                children: [
                  _buildStep(context, "1", l10n.guideStep1Title, l10n.guideStep1Desc),
                  const Divider(height: 32, color: Color(0xFFF1F5F9)),
                  _buildStep(context, "2", l10n.guideStep2Title, l10n.guideStep2Desc),
                  const Divider(height: 32, color: Color(0xFFF1F5F9)),
                  _buildStep(context, "3", l10n.guideStep3Title, l10n.guideStep3Desc),
                  const Divider(height: 32, color: Color(0xFFF1F5F9)),
                  _buildStep(context, "4", l10n.guideStep4Title, l10n.guideStep4Desc),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, String number, String title, String desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textLight,
                  height: 1.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}