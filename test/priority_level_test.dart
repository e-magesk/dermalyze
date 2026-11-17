import 'dart:math' as math;

import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/shared/clinical/priority_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Contraste WCAG 2.x entre duas cores.
double _contrast(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
}

void main() {
  group('PriorityLevel', () {
    test('converte os rótulos do modelo de triagem', () {
      expect(PriorityLevel.fromCode('P1'), PriorityLevel.p1);
      expect(PriorityLevel.fromCode('p5'), PriorityLevel.p5);
      expect(PriorityLevel.fromCode('X'), isNull);
    });

    test('texto branco no card preenchido tem contraste AA (≥ 4,5:1)', () {
      for (final level in PriorityLevel.values) {
        expect(
          _contrast(level.fill, Colors.white),
          greaterThanOrEqualTo(4.5),
          reason: '${level.name}: o card do resultado precisa ser legível',
        );
      }
    });

    test('cada nível tem código, título, descrição e conduta', () async {
      final l10n = await AppLocalizations.delegate.load(const Locale('pt'));
      final codes = <String>{};

      for (final level in PriorityLevel.values) {
        codes.add(level.code(l10n));
        expect(level.title(l10n), isNotEmpty);
        expect(level.description(l10n), isNotEmpty);
        expect(level.conduct(l10n), isNotEmpty);
        expect(level.label(l10n), '${level.code(l10n)} · ${level.title(l10n)}');
      }

      expect(codes, {'P1', 'P2', 'P3', 'P4', 'P5'});
    });
  });

  group('priorityForDiagnosisLabel', () {
    test('nevo melanocítico (NEV) é P1, como o melanoma', () {
      expect(priorityForDiagnosisLabel('NEV'), PriorityLevel.p1);
      expect(priorityForDiagnosisLabel('MEL'), PriorityLevel.p1);
    });

    test('demais classes do modelo', () {
      expect(priorityForDiagnosisLabel('BCC'), PriorityLevel.p2);
      expect(priorityForDiagnosisLabel('SCC'), PriorityLevel.p2);
      expect(priorityForDiagnosisLabel('ACK'), PriorityLevel.p3);
      expect(priorityForDiagnosisLabel('SEK'), PriorityLevel.p4);
    });

    test('classe desconhecida não subestima o risco', () {
      expect(priorityForDiagnosisLabel('???'), PriorityLevel.p3);
    });
  });
}
