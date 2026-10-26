import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:dermalyze/src/features/analysis/controller/analysis_controller.dart';
import 'package:dermalyze/src/models/analysis_type.dart';
import 'package:dermalyze/src/modules/diagnosis/pages/diagnosis_page.dart';
import 'package:dermalyze/src/modules/guide/pages/guide_page.dart';
import 'package:dermalyze/src/modules/library/pages/library_page.dart';
import 'package:dermalyze/src/modules/settings/pages/settings_page.dart';
import 'package:dermalyze/src/modules/triage/pages/triage_page.dart';
import 'package:dermalyze/src/shared/navigation/back_handler_registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';

import 'package:provider/provider.dart';
import 'package:dermalyze/src/features/auth/controller/auth_controller.dart';

// Cores baseadas no seu Tailwind
const Color _blue600 = Color(0xFF2563EB);
const Color _slate400 = Color(0xFF94A3B8);
const Color _slate100 = Color(0xFFF1F5F9);

/// Índice de cada aba dentro do `IndexedStack`.
const int _tabHome = 0;
const int _tabTriage = 1;
const int _tabDiagnosis = 2;
const int _tabLibrary = 3;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  /// Escopo de navegação interna da aba, quando ela tiver um.
  BackScope? get _currentScope {
    switch (_currentIndex) {
      case _tabTriage:
        return BackScope.triage;
      case _tabDiagnosis:
        return BackScope.diagnosis;
      case _tabLibrary:
        return BackScope.library;
      default:
        return null;
    }
  }

  /// Trata o botão de voltar do sistema operacional.
  ///
  /// Antes o app simplesmente fechava, porque toda a navegação é feita por
  /// estado e não havia rota para desempilhar. A ordem aqui vai do passo mais
  /// interno para o mais externo: resultado da análise -> passo do formulário
  /// ou subpágina da Biblioteca -> volta para a Home -> confirma a saída.
  Future<void> _handleSystemBack() async {
    final analysis = context.read<AnalysisController>();

    // 1. Tela de resultado aberta: volta para o formulário da própria aba.
    if (_currentIndex == _tabTriage) {
      if (analysis.triageState == AnalysisState.loading) return; // análise em curso
      if (analysis.triageState != AnalysisState.idle) {
        analysis.reset(AnalysisType.triage);
        return;
      }
    }

    if (_currentIndex == _tabDiagnosis) {
      if (analysis.diagState == AnalysisState.loading) return; // análise em curso
      if (analysis.diagState != AnalysisState.idle) {
        analysis.reset(AnalysisType.diagnosis);
        return;
      }
    }

    // 2. Navegação interna da aba (passo do formulário, subpágina da Biblioteca).
    final scope = _currentScope;
    if (scope != null && context.read<BackHandlerRegistry>().handleBack(scope)) {
      return;
    }

    // 3. Fora da Home: volta para a Home.
    if (_currentIndex != _tabHome) {
      _changeTab(_tabHome);
      return;
    }

    // 4. Já na Home: confirma antes de encerrar o app.
    final shouldExit = await _confirmExit();
    if (shouldExit) {
      await SystemNavigator.pop();
    }
  }

  Future<bool> _confirmExit() async {
    final l10n = AppLocalizations.of(context)!;

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          l10n.exitTitle,
          style: const TextStyle(fontWeight: FontWeight.w900, color: AppColors.textDark, fontSize: 18),
        ),
        content: Text(
          l10n.exitMessage,
          style: const TextStyle(color: AppColors.textMedium, fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              l10n.btnCancel,
              style: const TextStyle(color: AppColors.textMedium, fontWeight: FontWeight.w700),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              l10n.btnExit,
              style: const TextStyle(color: AppColors.error, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {

    final List<Widget> pages = [
      HomePage(onTabChange: _changeTab),
      TriagePage(),
      DiagnosisPage(),
      LibraryPage(),
      GuidePage(),
      SettingsPage(onTabChange: _changeTab),
    ];

    final authController = context.watch<AuthController>();
    final isDoctor = authController.state == AuthState.doctor;
    final l10n = AppLocalizations.of(context)!; // Atalho para as traduções

    return PopScope(
      // O voltar nunca desempilha sozinho: quem decide é _handleSystemBack.
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleSystemBack();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: IndexedStack(
          index: _currentIndex,
          children: pages,
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.95),
            border: const Border(top: BorderSide(color: _slate100)),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 30, offset: const Offset(0, -10)),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(icon: Icons.home_outlined, label: l10n.navHome, realIndex: 0),
                  _buildNavItem(icon: Icons.medical_services_outlined, label: l10n.navTriage, realIndex: 1),
                  if (isDoctor)
                    _buildNavItem(icon: Icons.search, label: l10n.navDiagnosis, realIndex: 2),
                  _buildNavItem(icon: Icons.menu_book_outlined, label: l10n.navLibrary, realIndex: 3),
                  _buildNavItem(icon: Icons.help_outline, label: l10n.navGuide, realIndex: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required int realIndex}) {
    final isSelected = _currentIndex == realIndex;
    final color = isSelected ? _blue600 : _slate400;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => setState(() => _currentIndex = realIndex),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 9,
                fontWeight: FontWeight.w900,
                letterSpacing: (label.length > 8) ? -0.5 : 0.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
