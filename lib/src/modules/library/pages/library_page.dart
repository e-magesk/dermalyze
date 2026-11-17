import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:dermalyze/src/modules/library/views/library_abcde_view.dart';
import 'package:dermalyze/src/modules/library/views/library_diseases_view.dart';
import 'package:dermalyze/src/modules/library/views/library_menu_views.dart';
import 'package:dermalyze/src/modules/library/views/library_triage_view.dart';
import 'package:dermalyze/src/shared/navigation/section_navigation_registry.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:dermalyze/src/core/l10n/app_localizations.dart';

enum LibraryCategory { menu, abcde, diseases, triage }

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> implements SectionNavigation {
  LibraryCategory _currentCategory = LibraryCategory.menu;

  // Guardado no initState porque ler o Provider no dispose não é seguro.
  late final SectionNavigationRegistry _sections;

  @override
  void initState() {
    super.initState();
    _sections = context.read<SectionNavigationRegistry>();
    _sections.register(SectionScope.library, this);
  }

  @override
  void dispose() {
    _sections.unregister(SectionScope.library, this);
    super.dispose();
  }

  void _setCategory(LibraryCategory category) {
    setState(() => _currentCategory = category);
  }

  /// Volta da subpágina para o menu da Biblioteca. Retorna false quando já
  /// está no menu, deixando o evento seguir para a MainPage.
  @override
  bool handleBack() {
    if (_currentCategory != LibraryCategory.menu) {
      _setCategory(LibraryCategory.menu);
      return true;
    }
    return false;
  }

  /// Ler a Biblioteca não gera nada que se perca: volta ao menu sem confirmar.
  @override
  bool get hasProgress => false;

  @override
  void resetToStart() {
    if (_currentCategory != LibraryCategory.menu) _setCategory(LibraryCategory.menu);
  }

  /// Mesmo nome do item clicado no menu, para o breadcrumb.
  String _categoryTitle(AppLocalizations l10n) {
    switch (_currentCategory) {
      case LibraryCategory.menu:
        return l10n.libTitle;
      case LibraryCategory.abcde:
        return l10n.libMenuAbcdeTitle;
      case LibraryCategory.diseases:
        return l10n.libMenuDiseasesTitle;
      case LibraryCategory.triage:
        return l10n.libMenuTriageTitle;
    }
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
        title: isMenu
            ? Text(
                l10n.libTitle,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.textDark, letterSpacing: -0.5),
              )
            : _buildBreadcrumb(l10n),
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

  /// "Biblioteca Técnica › Principais Doenças": deixa claro onde o usuário está,
  /// mesmo quando o título interno da subpágina é diferente do item clicado.
  Widget _buildBreadcrumb(AppLocalizations l10n) {
    return Row(
      children: [
        Flexible(
          child: GestureDetector(
            onTap: () => _setCategory(LibraryCategory.menu),
            child: Text(
              l10n.libTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textMedium, letterSpacing: -0.5),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.chevron_right_rounded, color: AppColors.textLight, size: 20),
        ),
        Flexible(
          child: Text(
            _categoryTitle(l10n),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.textDark, letterSpacing: -0.5),
          ),
        ),
      ],
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