import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:dermalyze/src/modules/library/data/disease_catalog.dart';
import 'package:dermalyze/src/modules/library/widgets/library_section_banner.dart';
import 'package:dermalyze/src/shared/clinical/priority_level.dart';
import 'package:flutter/material.dart';
import 'package:dermalyze/src/core/l10n/app_localizations.dart';

/// "Principais Doenças": busca pelo nome, filtro por características e lista
/// agrupada por prioridade, com uma imagem ilustrativa por doença.
class LibraryDiseasesView extends StatefulWidget {
  final AppLocalizations l10n;
  const LibraryDiseasesView({super.key, required this.l10n});

  @override
  State<LibraryDiseasesView> createState() => _LibraryDiseasesViewState();
}

class _LibraryDiseasesViewState extends State<LibraryDiseasesView> {
  final _searchController = TextEditingController();
  final Set<DiseaseTag> _selectedTags = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool get _hasFilters => _searchController.text.trim().isNotEmpty || _selectedTags.isNotEmpty;

  void _clearFilters() {
    setState(() {
      _searchController.clear();
      _selectedTags.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    final catalog = buildDiseaseCatalog(l10n);
    final results = filterDiseases(catalog, query: _searchController.text, tags: _selectedTags);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LibrarySectionBanner(
          icon: Icons.biotech_rounded,
          title: l10n.libDiseasesHeroTitle,
          description: l10n.libDiseasesHeroDesc1,
        ),
        const SizedBox(height: 24),

        _buildSearchField(l10n),
        const SizedBox(height: 16),
        _buildTagFilter(l10n),
        const SizedBox(height: 24),

        if (results.isEmpty)
          _buildEmptyState(l10n)
        else
          for (final level in PriorityLevel.values)
            ..._buildPriorityGroup(level, results.where((d) => d.priority == level).toList(), l10n),

        const SizedBox(height: 8),
        Center(
          child: TextButton.icon(
            onPressed: () => _showCredits(context, catalog, l10n),
            icon: const Icon(Icons.photo_library_outlined, size: 16),
            label: Text(l10n.libImageCredits),
            style: TextButton.styleFrom(foregroundColor: AppColors.textMedium),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField(AppLocalizations l10n) {
    return TextField(
      controller: _searchController,
      onChanged: (_) => setState(() {}),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: l10n.libDiseasesSearchHint,
        hintStyle: const TextStyle(color: AppColors.textLight, fontWeight: FontWeight.w500),
        prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textLight),
        suffixIcon: _searchController.text.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.close_rounded, color: AppColors.textLight),
                onPressed: () => setState(_searchController.clear),
              ),
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFF1F5F9))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Color(0xFFF1F5F9))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
      ),
    );
  }

  Widget _buildTagFilter(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.libDiseasesFilterTitle.toUpperCase(),
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.textLight, letterSpacing: 1.5),
              ),
            ),
            if (_hasFilters)
              TextButton(
                onPressed: _clearFilters,
                style: TextButton.styleFrom(visualDensity: VisualDensity.compact, foregroundColor: AppColors.primary),
                child: Text(l10n.libDiseasesClearFilters, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final tag in DiseaseTag.values)
              FilterChip(
                label: Text(tag.label(l10n)),
                selected: _selectedTags.contains(tag),
                onSelected: (selected) => setState(() {
                  selected ? _selectedTags.add(tag) : _selectedTags.remove(tag);
                }),
                showCheckmark: false,
                labelStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: _selectedTags.contains(tag) ? Colors.white : AppColors.textMedium,
                ),
                selectedColor: AppColors.primary,
                backgroundColor: AppColors.surface,
                side: BorderSide(color: _selectedTags.contains(tag) ? AppColors.primary : const Color(0xFFE2E8F0)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          const Icon(Icons.search_off_rounded, color: AppColors.textLight, size: 40),
          const SizedBox(height: 12),
          Text(
            l10n.libDiseasesNoResults,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textMedium, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPriorityGroup(PriorityLevel level, List<Disease> diseases, AppLocalizations l10n) {
    if (diseases.isEmpty) return const [];

    return [
      Row(
        children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: level.color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(
            level.label(l10n).toUpperCase(),
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w900, color: level.color, letterSpacing: 1.2),
          ),
        ],
      ),
      const SizedBox(height: 12),
      for (final disease in diseases)
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _DiseaseCard(disease: disease, l10n: l10n),
        ),
      const SizedBox(height: 8),
    ];
  }

  void _showCredits(BuildContext context, List<Disease> catalog, AppLocalizations l10n) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (sheetContext) => SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.7),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(24),
            children: [
              Text(l10n.libImageCredits, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.textDark)),
              const SizedBox(height: 4),
              Text(l10n.libImageCreditsIntro, style: const TextStyle(fontSize: 13, color: AppColors.textMedium)),
              const SizedBox(height: 16),
              for (final disease in catalog)
                if (disease.image != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: '${disease.name}: ', style: const TextStyle(fontWeight: FontWeight.w800)),
                          TextSpan(text: '${disease.image!.author} · ${disease.image!.license} · Wikimedia Commons'),
                        ],
                      ),
                      style: const TextStyle(fontSize: 12, color: AppColors.textMedium, height: 1.4),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DiseaseCard extends StatelessWidget {
  final Disease disease;
  final AppLocalizations l10n;

  const _DiseaseCard({required this.disease, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final level = disease.priority;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Faixa com a cor da prioridade, para leitura rápida.
          Container(height: 6, color: level.color),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildThumbnail(level),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        disease.name,
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: AppColors.textDark),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: level.background, borderRadius: BorderRadius.circular(100)),
                        child: Text(
                          level.code(l10n),
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: level.color),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  disease.description,
                  style: const TextStyle(fontSize: 13, color: AppColors.textMedium, fontWeight: FontWeight.w500, height: 1.5),
                ),
                if (disease.tags.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final tag in DiseaseTag.values.where(disease.tags.contains))
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(100)),
                          child: Text(
                            tag.label(l10n),
                            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMedium),
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Foto ilustrativa ou, sem foto, um ícone com a cor da prioridade.
  Widget _buildThumbnail(PriorityLevel level) {
    final image = disease.image;
    final placeholder = Container(
      color: level.background,
      child: Icon(Icons.medical_information_outlined, color: level.color, size: 32),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 80,
        height: 80,
        child: image == null
            ? placeholder
            : Image.asset(
                image.asset,
                fit: BoxFit.cover,
                // Miniatura: decodifica pequeno para não pesar a lista.
                cacheWidth: 240,
                errorBuilder: (context, error, stackTrace) => placeholder,
              ),
      ),
    );
  }
}
