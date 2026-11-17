import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:dermalyze/src/features/auth/controller/auth_controller.dart';
import 'package:dermalyze/src/shared/widgets/app_bento_card.dart';

// Constantes de cores
const Color _blue600 = Color(0xFF2563EB);
const Color _slate800 = Color(0xFF1E293B);
const Color _slate400 = Color(0xFF94A3B8);
const Color _slate200 = Color(0xFFE2E8F0);
const Color _slate50 = Color(0xFFF8FAFC);

class HomePage extends StatelessWidget {

  final Function(int) onTabChange;

  const HomePage({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    final isDoctor = authController.state == AuthState.doctor;
    final l10n = AppLocalizations.of(context)!;
    
    // Pega o nome do usuário do controller ou usa o padrão da pesquisa
    final String userName = authController.userName!; 

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, isDoctor, l10n),
              const SizedBox(height: 24),
              
              // 1. Saudação
              // Sem bloco de cor: o card azul era o elemento mais destacado da
              // tela sem ter nenhuma ação. O destaque fica com Triagem e Análise.
              Text(
                l10n.helloUser(userName), // Variável com parâmetro
                style: const TextStyle(color: _slate800, fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: -0.5),
              ),
              const SizedBox(height: 16),

              // 2. Action Grid
              // IntrinsicHeight: os dois cards ficam da mesma altura mesmo com
              // subtítulos de tamanhos diferentes.
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _buildActionCard(
                        icon: Icons.medical_services_outlined,
                        iconColor: _blue600,
                        title: l10n.clinicalTriage,
                        subtitle: l10n.homeTriageDesc,
                        onTap: () => onTabChange(1),
                      ),
                    ),
                    if (isDoctor) ...[
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildActionCard(
                          icon: Icons.search,
                          iconColor: Colors.indigo,
                          title: l10n.differentialAnalysis,
                          subtitle: l10n.homeDiagnosisDesc,
                          onTap: () => onTabChange(2),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // 3. Quick Access
              BentoCard(
                border: Border.all(color: _slate200.withValues(alpha: 0.5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.quickAccess, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: _slate400, letterSpacing: 1.5)),
                    const SizedBox(height: 16),
                    _buildQuickAccessItem(
                      icon: Icons.menu_book_outlined,
                      title: l10n.libTitle,
                      subtitle: l10n.quickAccessLibraryDesc,
                      onTap: () => onTabChange(3),
                    ),
                    const SizedBox(height: 12),
                    _buildQuickAccessItem(
                      icon: Icons.help_outline,
                      title: l10n.appGuide,
                      subtitle: l10n.instructionsResp,
                      onTap: () => onTabChange(4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDoctor, AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
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
                  width: 50,
                  height: 50,
                ),
              ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.appName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: _slate800, letterSpacing: -0.5)),
                Text(isDoctor ? l10n.medicalAccess : l10n.agentAccess, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: _blue600, letterSpacing: 1.5)),
              ],
            ),
          ],
        ),
        // BOTÃO DE CONFIGURAÇÕES
        GestureDetector(
          onTap: () => onTabChange(5), // Chama o índice 5 da MainPage
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: _slate200),
            ),
            child: const Icon(Icons.settings_outlined, color: _slate400, size: 24),
          ),
        ),
      ],
    );
  }

  /// Botão de seção da Home: título e um subtítulo que explica o que a seção faz.
  Widget _buildActionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return BentoCard(
      border: Border.all(color: _slate200.withValues(alpha: 0.5)),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 26),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _slate400, height: 1.3)),
        ],
      ),
    );
  }

  Widget _buildQuickAccessItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: _slate50, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: _slate200.withValues(alpha: 0.5))),
              child: Icon(icon, color: _blue600, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: _slate800)),
                  Text(subtitle, style: const TextStyle(fontSize: 10, color: _slate400, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: _slate400),
          ],
        ),
      ),
    );
  }
}