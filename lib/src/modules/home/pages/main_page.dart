import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'home_page.dart'; 

import 'package:provider/provider.dart';
import 'package:dermalyze/src/features/auth/controller/auth_controller.dart';

// Cores baseadas no seu Tailwind
const Color _blue600 = Color(0xFF2563EB);
const Color _slate400 = Color(0xFF94A3B8);
const Color _slate100 = Color(0xFFF1F5F9);

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const Center(child: Text("Triage Screen")),
    const Center(child: Text("Diagnosis Screen")),
    const Center(child: Text("Library Screen")),
    const Center(child: Text("Guide Screen")),
  ];

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();
    final isDoctor = authController.state == AuthState.doctor;
    final l10n = AppLocalizations.of(context)!; // Atalho para as traduções

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
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