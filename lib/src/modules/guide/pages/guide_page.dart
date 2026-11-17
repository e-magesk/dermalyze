import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:dermalyze/src/shared/widgets/app_bento_card.dart';
import 'package:flutter/material.dart';
import 'package:dermalyze/src/core/l10n/app_localizations.dart';

/// Pergunta e resposta do Guia.
class _Faq {
  final String question;
  final String answer;

  const _Faq(this.question, this.answer);
}

/// Contextos das dúvidas frequentes.
enum GuideSection { general, triage, diagnosis, library, account }

/// Grupo de perguntas de um mesmo contexto.
class _FaqSection {
  final GuideSection id;
  final String title;
  final IconData icon;
  final List<_Faq> items;

  const _FaqSection(this.id, this.title, this.icon, this.items);
}

/// Página de ajuda: responsabilidade profissional e dúvidas frequentes,
/// organizadas por contexto.
class GuidePage extends StatefulWidget {
  /// Agentes de saúde não usam a Análise Assistida, então não veem essas dúvidas.
  final bool isDoctor;

  /// Seção mostrada ao abrir. Usada pelo ícone de ajuda das telas de Triagem
  /// e Análise Assistida, para cair direto nas dúvidas daquela tela.
  final GuideSection? focusSection;

  const GuidePage({super.key, required this.isDoctor, this.focusSection});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  final Map<GuideSection, GlobalKey> _sectionKeys = {
    for (final section in GuideSection.values) section: GlobalKey(),
  };

  @override
  void initState() {
    super.initState();

    final focus = widget.focusSection;
    if (focus != null) {
      // Depois do primeiro frame, quando as seções já têm posição na tela.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final target = _sectionKeys[focus]?.currentContext;
        if (target != null) Scrollable.ensureVisible(target);
      });
    }
  }

  List<_FaqSection> _sections(AppLocalizations l10n) {
    return [
      _FaqSection(GuideSection.general, l10n.faqGeneralTitle, Icons.info_outline, [
        _Faq(l10n.faqWhatIsQ, l10n.faqWhatIsA),
        _Faq(l10n.faqOfflineQ, l10n.faqOfflineA),
        _Faq(l10n.faqDataQ, l10n.faqDataA),
        _Faq(l10n.faqConfidenceQ, l10n.faqConfidenceA),
      ]),
      _FaqSection(GuideSection.triage, l10n.faqTriageTitle, Icons.medical_services_outlined, [
        _Faq(l10n.faqTriageHowQ, l10n.faqTriageHowA),
        _Faq(l10n.faqPriorityLevelsQ, l10n.faqPriorityLevelsA),
        _Faq(l10n.faqPhotoRejectedQ, l10n.faqPhotoRejectedA),
      ]),
      if (widget.isDoctor)
        _FaqSection(GuideSection.diagnosis, l10n.faqDiagnosisTitle, Icons.search, [
          _Faq(l10n.faqDiagnosisHowQ, l10n.faqDiagnosisHowA),
          _Faq(l10n.faqReplacesDiagnosisQ, l10n.faqReplacesDiagnosisA),
        ]),
      _FaqSection(GuideSection.library, l10n.faqLibraryTitle, Icons.menu_book_outlined, [
        _Faq(l10n.faqLibraryQ, l10n.faqLibraryA),
      ]),
      _FaqSection(GuideSection.account, l10n.faqAccountTitle, Icons.person_outline, [
        _Faq(l10n.faqPasswordQ, l10n.faqPasswordA),
        _Faq(l10n.faqAccessQ, l10n.faqAccessA),
        _Faq(l10n.faqLanguageQ, l10n.faqLanguageA),
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Aberta pelo ícone de ajuda, a página ganha a seta de voltar automaticamente.
    final openedAsHelp = ModalRoute.of(context)?.canPop ?? false;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: false, // Garante que não centralize no iOS
        titleSpacing: openedAsHelp ? 0 : 24,
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
            _buildResponsibilityCard(l10n),

            const SizedBox(height: 32),

            Row(
              children: [
                const Icon(Icons.help_outline_rounded, color: AppColors.primary, size: 24),
                const SizedBox(width: 8),
                Text(
                  l10n.guideFaqTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppColors.textDark),
                ),
              ],
            ),

            for (final section in _sections(l10n)) ...[
              const SizedBox(height: 24),
              KeyedSubtree(key: _sectionKeys[section.id], child: _buildSection(section)),
            ],
          ],
        ),
      ),
    );
  }

  // CARD DE RESPONSABILIDADE (Estilo Alerta Rose/Red)
  Widget _buildResponsibilityCard(AppLocalizations l10n) {
    return Container(
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
    );
  }

  Widget _buildSection(_FaqSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(section.icon, size: 16, color: AppColors.textLight),
            const SizedBox(width: 8),
            Text(
              section.title.toUpperCase(),
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: AppColors.textLight, letterSpacing: 1.5),
            ),
          ],
        ),
        const SizedBox(height: 12),
        BentoCard(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              for (var i = 0; i < section.items.length; i++) ...[
                if (i > 0) const Divider(height: 1, indent: 24, endIndent: 24, color: Color(0xFFF1F5F9)),
                _buildFaqTile(section.items[i]),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFaqTile(_Faq faq) {
    return Theme(
      // Sem as linhas que o ExpansionTile desenha ao abrir.
      data: ThemeData(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 24),
        childrenPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        iconColor: AppColors.primary,
        collapsedIconColor: AppColors.textLight,
        shape: const Border(),
        collapsedShape: const Border(),
        title: Text(
          faq.question,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.textDark),
        ),
        children: [
          Text(
            faq.answer,
            style: const TextStyle(fontSize: 13, height: 1.5, color: AppColors.textMedium, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
