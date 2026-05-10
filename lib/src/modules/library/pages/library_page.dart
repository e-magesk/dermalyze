import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:dermalyze/src/modules/library/views/library_abcde_view.dart';
import 'package:dermalyze/src/modules/library/views/library_diseases_view.dart';
import 'package:dermalyze/src/modules/library/views/library_menu_views.dart';
import 'package:dermalyze/src/modules/library/views/library_triage_view.dart';
import 'package:flutter/material.dart';
import 'package:dermalyze/src/core/l10n/app_localizations.dart';

enum LibraryCategory { menu, abcde, diseases, triage }

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  LibraryCategory _currentCategory = LibraryCategory.menu;

  void _setCategory(LibraryCategory category) {
    setState(() => _currentCategory = category);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isMenu = _currentCategory == LibraryCategory.menu;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false,
        titleSpacing: isMenu ? 24 : 0,
        leading: isMenu 
            ? null 
            : IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textMedium, size: 20),
                onPressed: () => _setCategory(LibraryCategory.menu),
              ),
        title: Text(
          l10n.libTitle,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.textDark, letterSpacing: -0.5),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          // Transição suave entre as telas
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: _buildCurrentView(l10n),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentView(AppLocalizations l10n) {
    switch (_currentCategory) {
      case LibraryCategory.menu:
        return LibraryMenuView(key: const ValueKey('menu'), onSelect: _setCategory, l10n: l10n);
      case LibraryCategory.abcde:
        return LibraryAbcdeView(key: const ValueKey('abcde'), l10n: l10n);
      case LibraryCategory.diseases:
        return LibraryDiseasesView(key: const ValueKey('diseases'), l10n: l10n);
      case LibraryCategory.triage:
        return LibraryTriageView(key: const ValueKey('triage'), l10n: l10n);
    }
  }
}