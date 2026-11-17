import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/shared/navigation/section_navigation_registry.dart';
import 'package:dermalyze/src/shared/widgets/app_clinical_data_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class _FakeSection implements SectionNavigation {
  _FakeSection({this.consumesBack = false, this.progress = false});

  bool consumesBack;
  bool progress;
  int backCalls = 0;
  int resetCalls = 0;

  @override
  bool handleBack() {
    backCalls++;
    return consumesBack;
  }

  @override
  bool get hasProgress => progress;

  @override
  void resetToStart() => resetCalls++;
}

Future<SectionNavigationRegistry> _pumpForm(WidgetTester tester) async {
  final registry = SectionNavigationRegistry();

  await tester.pumpWidget(
    Provider<SectionNavigationRegistry>.value(
      value: registry,
      child: MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: ClinicalDataForm(
              sectionScope: SectionScope.diagnosis,
              captureMode: CaptureMode.dermoscopic,
              onSubmit: (_) {},
            ),
          ),
        ),
      ),
    ),
  );

  return registry;
}

/// Preenche o passo 1 (idade, histórico e região) e avança para o passo 2.
Future<void> _fillStep1AndAdvance(WidgetTester tester) async {
  await tester.enterText(find.byType(TextFormField), '45');
  await tester.tap(find.text('SIM'));
  await tester.pump();

  await tester.tap(find.byType(DropdownButtonFormField<String>));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Face').last);
  await tester.pumpAndSettle();

  await tester.tap(find.text('PRÓXIMO'));
  await tester.pumpAndSettle();
}

void main() {
  group('SectionNavigationRegistry', () {
    test('voltar consulta da tela mais recente para a mais antiga', () {
      final registry = SectionNavigationRegistry();
      final older = _FakeSection(consumesBack: true);
      final newer = _FakeSection(consumesBack: true);
      registry.register(SectionScope.triage, older);
      registry.register(SectionScope.triage, newer);

      expect(registry.handleBack(SectionScope.triage), isTrue);
      expect(newer.backCalls, 1);
      expect(older.backCalls, 0);
    });

    test('voltar sem ninguém para consumir devolve false', () {
      final registry = SectionNavigationRegistry();
      registry.register(SectionScope.library, _FakeSection());

      expect(registry.handleBack(SectionScope.library), isFalse);
      expect(registry.handleBack(SectionScope.triage), isFalse);
    });

    test('progresso de qualquer tela da seção conta, e só daquela seção', () {
      final registry = SectionNavigationRegistry();
      registry.register(SectionScope.triage, _FakeSection());
      registry.register(SectionScope.triage, _FakeSection(progress: true));
      registry.register(SectionScope.diagnosis, _FakeSection());

      expect(registry.hasProgress(SectionScope.triage), isTrue);
      expect(registry.hasProgress(SectionScope.diagnosis), isFalse);
    });

    test('voltar ao início atinge todas as telas da seção e nenhuma outra', () {
      final registry = SectionNavigationRegistry();
      final a = _FakeSection();
      final b = _FakeSection();
      final other = _FakeSection();
      registry.register(SectionScope.triage, a);
      registry.register(SectionScope.triage, b);
      registry.register(SectionScope.library, other);

      registry.resetToStart(SectionScope.triage);

      expect(a.resetCalls, 1);
      expect(b.resetCalls, 1);
      expect(other.resetCalls, 0);
    });

    test('tela removida deixa de receber eventos', () {
      final registry = SectionNavigationRegistry();
      final section = _FakeSection(consumesBack: true);
      registry.register(SectionScope.triage, section);
      registry.unregister(SectionScope.triage, section);

      expect(registry.handleBack(SectionScope.triage), isFalse);
      registry.resetToStart(SectionScope.triage);
      expect(section.resetCalls, 0);
    });
  });

  group('ClinicalDataForm na navegação por seção', () {
    testWidgets('sem nada preenchido não há progresso', (tester) async {
      final registry = await _pumpForm(tester);

      expect(registry.hasProgress(SectionScope.diagnosis), isFalse);
    });

    testWidgets('preencher um campo conta como progresso', (tester) async {
      final registry = await _pumpForm(tester);

      await tester.enterText(find.byType(TextFormField), '45');
      await tester.pump();

      expect(registry.hasProgress(SectionScope.diagnosis), isTrue);
    });

    testWidgets('voltar ao início limpa os campos, inclusive o texto digitado', (tester) async {
      final registry = await _pumpForm(tester);

      await tester.enterText(find.byType(TextFormField), '45');
      await tester.pump();

      registry.resetToStart(SectionScope.diagnosis);
      await tester.pump();

      expect(find.text('45'), findsNothing, reason: 'o campo guarda o próprio texto e precisa ser recriado');
      expect(registry.hasProgress(SectionScope.diagnosis), isFalse);
    });

    testWidgets('voltar do sistema retrocede um passo e para no primeiro', (tester) async {
      final registry = await _pumpForm(tester);
      await _fillStep1AndAdvance(tester);

      expect(find.text('Sintomas da Lesão'), findsOneWidget);

      expect(registry.handleBack(SectionScope.diagnosis), isTrue);
      await tester.pump();
      expect(find.text('Dados Básicos'), findsOneWidget);

      // Já no primeiro passo: o evento segue para a MainPage.
      expect(registry.handleBack(SectionScope.diagnosis), isFalse);
    });

    testWidgets('voltar ao início a partir do segundo passo volta ao primeiro, vazio', (tester) async {
      final registry = await _pumpForm(tester);
      await _fillStep1AndAdvance(tester);

      registry.resetToStart(SectionScope.diagnosis);
      await tester.pump();

      expect(find.text('Dados Básicos'), findsOneWidget);
      expect(find.text('45'), findsNothing);
      expect(registry.hasProgress(SectionScope.diagnosis), isFalse);
    });
  });
}
