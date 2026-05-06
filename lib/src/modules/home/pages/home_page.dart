import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:dermalyze/src/features/auth/controller/auth_controller.dart';
import 'package:dermalyze/src/shared/widgets/app_bento_card.dart';

// Constantes de cores
const Color _blue600 = Color(0xFF2563EB);
const Color _blue100 = Color(0xFFDBEAFE);
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
              
              // 1. Hero Card
              BentoCard(
                height: 180,
                color: _blue600,
                boxShadow: [
                  BoxShadow(color: _blue100.withValues(alpha: 0.5), blurRadius: 20, offset: const Offset(0, 10)),
                ],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.helloUser(userName), // Variável com parâmetro
                          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.connectedUFES,
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 9, fontWeight: FontWeight.w900, letterSpacing: 1.5),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.databaseUpdated, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 2. Action Grid
              Row(
                children: [
                  Expanded(
                    child: BentoCard(
                      height: 128,
                      border: Border.all(color: _slate200.withValues(alpha: 0.5)),
                      onTap: () => onTabChange(1),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.medical_services_outlined, color: _blue600, size: 26),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l10n.clinicalTriage, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
                              const SizedBox(height: 4),
                              Text(l10n.triageLevels, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: _slate400, letterSpacing: 0.5)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isDoctor) ...[
                    const SizedBox(width: 16),
                    Expanded(
                      child: BentoCard(
                        height: 128,
                        border: Border.all(color: _slate200.withValues(alpha: 0.5)),
                        onTap: () => onTabChange(2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.search, color: Colors.indigo, size: 26),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(l10n.differentialAnalysis, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
                                const SizedBox(height: 4),
                                Text(l10n.aiDiagnosis, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: _slate400, letterSpacing: 0.5)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              
              const SizedBox(height: 24),
              
              // 3. Quick Access
              BentoCard(
                border: Border.all(color: _slate200.withValues(alpha: 0.5)),
                onTap: () => onTabChange(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.quickAccess, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: _slate400, letterSpacing: 1.5)),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: _slate50, borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), border: Border.all(color: _slate200.withValues(alpha: 0.5))),
                            child: const Icon(Icons.help_outline, color: _blue600, size: 22),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(l10n.appGuide, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: _slate800)),
                                Text(l10n.instructionsResp, style: const TextStyle(fontSize: 10, color: _slate400, fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right, color: _slate400),
                        ],
                      ),
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
}