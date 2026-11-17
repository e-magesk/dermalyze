import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/shared/clinical/priority_level.dart';

/// Características usadas para filtrar as doenças na Biblioteca.
enum DiseaseTag {
  asymmetry,
  irregularBorders,
  multipleColors,
  pigmented,
  growth,
  bleeding,
  itching,
  scaling,
  redness,
  raised,
  nonHealing,
  sunExposed;

  String label(AppLocalizations l10n) {
    switch (this) {
      case DiseaseTag.asymmetry:
        return l10n.tagAsymmetry;
      case DiseaseTag.irregularBorders:
        return l10n.tagIrregularBorders;
      case DiseaseTag.multipleColors:
        return l10n.tagMultipleColors;
      case DiseaseTag.pigmented:
        return l10n.tagPigmented;
      case DiseaseTag.growth:
        return l10n.tagGrowth;
      case DiseaseTag.bleeding:
        return l10n.tagBleeding;
      case DiseaseTag.itching:
        return l10n.tagItching;
      case DiseaseTag.scaling:
        return l10n.tagScaling;
      case DiseaseTag.redness:
        return l10n.tagRedness;
      case DiseaseTag.raised:
        return l10n.tagRaised;
      case DiseaseTag.nonHealing:
        return l10n.tagNonHealing;
      case DiseaseTag.sunExposed:
        return l10n.tagSunExposed;
    }
  }
}

/// Imagem ilustrativa e seu crédito (ver `assets/images/diseases/CREDITS.md`).
class DiseaseImage {
  final String asset;
  final String author;
  final String license;

  const DiseaseImage({required this.asset, required this.author, required this.license});
}

/// Uma doença da seção "Principais Doenças".
class Disease {
  final String name;
  final String description;
  final PriorityLevel priority;
  final Set<DiseaseTag> tags;
  final DiseaseImage? image;

  const Disease({
    required this.name,
    required this.description,
    required this.priority,
    required this.tags,
    this.image,
  });
}

const String _imageDir = 'assets/images/diseases';

/// Doenças exibidas na Biblioteca, da maior para a menor prioridade.
///
/// PENDENTE DE VALIDAÇÃO MÉDICA: as tags de cada doença foram montadas a partir
/// de referências gerais de dermatologia e ainda precisam ser revisadas por um
/// médico. As imagens são temporárias e devem ser trocadas por imagens com
/// licença própria antes do uso real em campo.
List<Disease> buildDiseaseCatalog(AppLocalizations l10n) {
  return [
    // P1 - PRIORIDADE MÁXIMA
    Disease(
      name: l10n.diagMelanomaName,
      description: l10n.diagMelanomaDesc,
      priority: PriorityLevel.p1,
      tags: const {
        DiseaseTag.asymmetry,
        DiseaseTag.irregularBorders,
        DiseaseTag.multipleColors,
        DiseaseTag.pigmented,
        DiseaseTag.growth,
        DiseaseTag.bleeding,
      },
      image: const DiseaseImage(asset: '$_imageDir/melanoma.jpg', author: 'Larry Meyer', license: 'Domínio público'),
    ),
    Disease(
      name: l10n.diagLentigoName,
      description: l10n.diagLentigoDesc,
      priority: PriorityLevel.p1,
      tags: const {
        DiseaseTag.asymmetry,
        DiseaseTag.irregularBorders,
        DiseaseTag.multipleColors,
        DiseaseTag.pigmented,
        DiseaseTag.growth,
        DiseaseTag.sunExposed,
      },
      image: const DiseaseImage(asset: '$_imageDir/lentigo_maligna.jpg', author: 'kilbad', license: 'CC BY 3.0'),
    ),
    Disease(
      name: l10n.diagNevoD22Name,
      description: l10n.diagNevoD22Desc,
      priority: PriorityLevel.p1,
      tags: const {
        DiseaseTag.asymmetry,
        DiseaseTag.irregularBorders,
        DiseaseTag.multipleColors,
        DiseaseTag.pigmented,
        DiseaseTag.growth,
      },
      image: const DiseaseImage(asset: '$_imageDir/atypical_nevus.jpg', author: 'Autor desconhecido (NCI)', license: 'Domínio público'),
    ),

    // P2 - ALTA PRIORIDADE
    Disease(
      name: l10n.diagBCCName,
      description: l10n.diagBCCDesc,
      priority: PriorityLevel.p2,
      tags: const {
        DiseaseTag.raised,
        DiseaseTag.bleeding,
        DiseaseTag.nonHealing,
        DiseaseTag.growth,
        DiseaseTag.sunExposed,
      },
      image: const DiseaseImage(asset: '$_imageDir/basal_cell_carcinoma.jpg', author: 'Kelly Nelson', license: 'Domínio público'),
    ),
    Disease(
      name: l10n.diagSCCName,
      description: l10n.diagSCCDesc,
      priority: PriorityLevel.p2,
      tags: const {
        DiseaseTag.raised,
        DiseaseTag.scaling,
        DiseaseTag.bleeding,
        DiseaseTag.nonHealing,
        DiseaseTag.growth,
        DiseaseTag.sunExposed,
      },
      image: const DiseaseImage(asset: '$_imageDir/squamous_cell_carcinoma.jpg', author: 'Autor desconhecido (NCI)', license: 'Domínio público'),
    ),
    Disease(
      name: l10n.diagBowenName,
      description: l10n.diagBowenDesc,
      priority: PriorityLevel.p2,
      tags: const {
        DiseaseTag.redness,
        DiseaseTag.scaling,
        DiseaseTag.irregularBorders,
        DiseaseTag.growth,
        DiseaseTag.sunExposed,
      },
      image: const DiseaseImage(asset: '$_imageDir/bowen_disease.jpg', author: 'Watplay', license: 'Domínio público'),
    ),
    Disease(
      name: l10n.diagKeratoacanthomaName,
      description: l10n.diagKeratoacanthomaDesc,
      priority: PriorityLevel.p2,
      tags: const {
        DiseaseTag.raised,
        DiseaseTag.growth,
        DiseaseTag.sunExposed,
      },
      image: const DiseaseImage(asset: '$_imageDir/keratoacanthoma.jpg', author: 'Armed Forces Institute of Pathology', license: 'Domínio público'),
    ),
    Disease(
      name: l10n.diagCutaneousHornName,
      description: l10n.diagCutaneousHornDesc,
      priority: PriorityLevel.p2,
      tags: const {
        DiseaseTag.raised,
        DiseaseTag.scaling,
        DiseaseTag.sunExposed,
      },
      image: const DiseaseImage(asset: '$_imageDir/cutaneous_horn.jpg', author: 'Mohammad2018', license: 'CC BY-SA 4.0'),
    ),

    // P3 - PRIORIDADE MÉDIA
    Disease(
      name: l10n.diagAKName,
      description: l10n.diagAKDesc,
      priority: PriorityLevel.p3,
      tags: const {
        DiseaseTag.scaling,
        DiseaseTag.redness,
        DiseaseTag.sunExposed,
      },
      image: const DiseaseImage(asset: '$_imageDir/actinic_keratosis.jpg', author: 'Future FamDoc', license: 'CC BY-SA 4.0'),
    ),
    Disease(
      name: l10n.diagEczemaName,
      description: l10n.diagEczemaDesc,
      priority: PriorityLevel.p3,
      tags: const {
        DiseaseTag.itching,
        DiseaseTag.redness,
        DiseaseTag.scaling,
      },
      image: const DiseaseImage(asset: '$_imageDir/eczema.jpg', author: 'NIAID', license: 'CC BY 2.0'),
    ),
    Disease(
      name: l10n.diagDermatitisName,
      description: l10n.diagDermatitisDesc,
      priority: PriorityLevel.p3,
      tags: const {
        DiseaseTag.itching,
        DiseaseTag.redness,
        DiseaseTag.scaling,
      },
      image: const DiseaseImage(asset: '$_imageDir/dermatitis.jpg', author: 'Hannah Clover', license: 'CC BY 4.0'),
    ),

    // P4 - BAIXA PRIORIDADE
    Disease(
      name: l10n.diagSKName,
      description: l10n.diagSKDesc,
      priority: PriorityLevel.p4,
      tags: const {
        DiseaseTag.pigmented,
        DiseaseTag.raised,
        DiseaseTag.itching,
      },
      image: const DiseaseImage(asset: '$_imageDir/seborrheic_keratosis.jpg', author: 'Assafn', license: 'CC BY-SA 4.0'),
    ),
    Disease(
      name: l10n.diagNevusL78Name,
      description: l10n.diagNevusL78Desc,
      priority: PriorityLevel.p4,
      tags: const {
        DiseaseTag.pigmented,
      },
      image: const DiseaseImage(asset: '$_imageDir/common_nevus.jpg', author: 'Autor desconhecido (NCI)', license: 'Domínio público'),
    ),

    // P5 - PRIORIDADE MÍNIMA
    Disease(
      name: l10n.diagAcneName,
      description: l10n.diagAcneDesc,
      priority: PriorityLevel.p5,
      tags: const {
        DiseaseTag.redness,
        DiseaseTag.raised,
      },
      image: const DiseaseImage(asset: '$_imageDir/acne.jpg', author: 'James Heilman, MD', license: 'CC BY-SA 3.0'),
    ),
    Disease(
      name: l10n.diagNoLesionName,
      description: l10n.diagNoLesionDesc,
      priority: PriorityLevel.p5,
      tags: const {},
      image: const DiseaseImage(asset: '$_imageDir/no_lesion.jpg', author: 'Autor desconhecido', license: 'CC0'),
    ),
  ];
}

/// Remove acentos e caixa, para "lentigo" encontrar "Lêntigo".
String normalizeForSearch(String text) {
  const from = 'áàâãäéèêëíìîïóòôõöúùûüçñ';
  const to = 'aaaaaeeeeiiiiooooouuuucn';
  final lower = text.toLowerCase();
  final buffer = StringBuffer();
  for (final char in lower.split('')) {
    final index = from.indexOf(char);
    buffer.write(index >= 0 ? to[index] : char);
  }
  return buffer.toString();
}

/// Doenças cujo nome contém [query] (sem acento nem caixa) e que têm todas as
/// características em [tags]. Cada característica marcada estreita a lista.
List<Disease> filterDiseases(List<Disease> catalog, {String query = '', Set<DiseaseTag> tags = const {}}) {
  final needle = normalizeForSearch(query.trim());
  return catalog.where((disease) {
    final matchesName = needle.isEmpty || normalizeForSearch(disease.name).contains(needle);
    final matchesTags = disease.tags.containsAll(tags);
    return matchesName && matchesTags;
  }).toList();
}
