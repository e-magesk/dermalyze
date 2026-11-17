import 'dart:io';

import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/modules/library/data/disease_catalog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppLocalizations l10n;
  late List<Disease> catalog;

  setUpAll(() async {
    l10n = await AppLocalizations.delegate.load(const Locale('pt'));
    catalog = buildDiseaseCatalog(l10n);
  });

  group('normalizeForSearch', () {
    test('ignora acentos e caixa', () {
      expect(normalizeForSearch('Ceratose Actínica'), 'ceratose actinica');
      expect(normalizeForSearch('DOENÇA DE BOWEN'), 'doenca de bowen');
    });
  });

  group('filterDiseases', () {
    test('sem filtro devolve todas as doenças', () {
      expect(filterDiseases(catalog).length, catalog.length);
    });

    test('busca pelo nome sem acento', () {
      final names = filterDiseases(catalog, query: 'actinica').map((d) => d.name);
      expect(names, contains(l10n.diagAKName));
    });

    test('busca ignora espaços nas bordas', () {
      expect(filterDiseases(catalog, query: '  melanoma  ').map((d) => d.name), contains(l10n.diagMelanomaName));
    });

    test('cada característica marcada estreita a lista', () {
      final pigmented = filterDiseases(catalog, tags: {DiseaseTag.pigmented});
      final pigmentedAndAsymmetric = filterDiseases(catalog, tags: {DiseaseTag.pigmented, DiseaseTag.asymmetry});

      expect(pigmented, isNotEmpty);
      expect(pigmentedAndAsymmetric.length, lessThan(pigmented.length));
      for (final disease in pigmentedAndAsymmetric) {
        expect(disease.tags, containsAll([DiseaseTag.pigmented, DiseaseTag.asymmetry]));
      }
    });

    test('busca e características combinam', () {
      final result = filterDiseases(catalog, query: 'ceratose', tags: {DiseaseTag.pigmented});
      expect(result.map((d) => d.name), [l10n.diagSKName]);
    });

    test('critério sem correspondência devolve lista vazia', () {
      expect(filterDiseases(catalog, query: 'xyz'), isEmpty);
    });
  });

  group('catálogo', () {
    test('tem as 15 doenças, de P1 a P5, em ordem de prioridade', () {
      expect(catalog.length, 15);
      final order = catalog.map((d) => d.priority.index).toList();
      expect(order, List.of(order)..sort());
    });

    test('toda imagem declarada existe em assets e tem crédito', () {
      for (final disease in catalog) {
        final image = disease.image;
        if (image == null) continue;
        expect(File(image.asset).existsSync(), isTrue, reason: '${disease.name}: ${image.asset}');
        expect(image.author, isNotEmpty);
        expect(image.license, isNotEmpty);
      }
    });

    test('cada imagem está listada no CREDITS.md', () {
      final credits = File('assets/images/diseases/CREDITS.md').readAsStringSync();
      for (final disease in catalog) {
        final image = disease.image;
        if (image == null) continue;
        expect(credits, contains(image.asset.split('/').last), reason: disease.name);
      }
    });
  });
}
