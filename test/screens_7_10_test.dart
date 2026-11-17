import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/features/analysis/controller/analysis_controller.dart';
import 'package:dermalyze/src/models/analysis_type.dart';
import 'package:dermalyze/src/modules/guide/pages/guide_page.dart';
import 'package:dermalyze/src/modules/library/widgets/evolution_example.dart';
import 'package:dermalyze/src/modules/triage/pages/triage_page.dart';
import 'package:dermalyze/src/shared/clinical/priority_level.dart';
import 'package:dermalyze/src/shared/navigation/section_navigation_registry.dart';
import 'package:dermalyze/src/shared/widgets/app_clinical_data_form.dart';
import 'package:dermalyze/src/shared/widgets/model_confidence_card.dart';
import 'package:dermalyze/src/shared/widgets/priority_scale_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Widget _app(Widget home, {List<SingleChildWidget> providers = const []}) {
  final app = MaterialApp(
    locale: const Locale('pt'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  );
  return providers.isEmpty ? app : MultiProvider(providers: providers, child: app);
}

/// Controller com um resultado de triagem pronto, sem rodar o modelo.
class _FakeAnalysisController extends AnalysisController {
  _FakeAnalysisController(String label, double confidence) {
    triageState = AnalysisState.success;
    triageResult = InferenceResult(label: label, confidence: confidence, type: AnalysisType.triage);
  }
}

void main() {
  group('Resultado da Triagem', () {
    Future<void> pumpResult(WidgetTester tester, String label) async {
      await tester.pumpWidget(_app(
        const TriagePage(),
        providers: [
          ChangeNotifierProvider<AnalysisController>(create: (_) => _FakeAnalysisController(label, 0.873)),
          Provider(create: (_) => SectionNavigationRegistry()),
        ],
      ));
      await tester.pump();
    }

    testWidgets('card principal leva a cor da prioridade e o título "P2 · Alta Prioridade"', (tester) async {
      await pumpResult(tester, 'P2');

      expect(find.text('Resultado da Triagem'), findsOneWidget);
      expect(find.text('P2 · Alta Prioridade'), findsOneWidget);
      expect(find.text('TRIAGEM CLÍNICA'), findsNothing, reason: 'etiqueta removida');

      final card = tester.widget<Container>(
        find.ancestor(of: find.text('P2 · Alta Prioridade'), matching: find.byType(Container)).first,
      );
      expect((card.decoration as BoxDecoration).color, PriorityLevel.p2.fill);
    });

    testWidgets('confiança fica em card próprio, com explicação', (tester) async {
      await pumpResult(tester, 'P1');

      expect(find.byType(ModelConfidenceCard), findsOneWidget);
      expect(find.text('87.3%'), findsOneWidget);
      expect(find.textContaining('Não indica a chance de a lesão ser maligna'), findsOneWidget);
    });

    testWidgets('"Ver todas as prioridades" mostra a escala com P1 a P5', (tester) async {
      await pumpResult(tester, 'P3');

      expect(find.byType(PriorityScaleList), findsNothing);

      await tester.tap(find.text('Ver todas as prioridades'));
      await tester.pumpAndSettle();

      expect(find.byType(PriorityScaleList), findsOneWidget);
      expect(find.text('Ocultar prioridades'), findsOneWidget);
      for (final code in ['P1', 'P2', 'P3', 'P4', 'P5']) {
        expect(find.text(code), findsOneWidget, reason: code);
      }
    });
  });

  group('Guia', () {
    testWidgets('médico vê as dúvidas da Análise Assistida', (tester) async {
      await tester.pumpWidget(_app(const GuidePage(isDoctor: true)));
      await tester.pump();

      expect(find.text('Dúvidas frequentes'), findsOneWidget);
      expect(find.text('Como usar a Análise Assistida?'), findsOneWidget);
    });

    testWidgets('agente de saúde não vê as dúvidas da Análise Assistida', (tester) async {
      await tester.pumpWidget(_app(const GuidePage(isDoctor: false)));
      await tester.pump();

      expect(find.text('Como usar a Triagem?'), findsOneWidget);
      expect(find.text('Como usar a Análise Assistida?'), findsNothing);
    });

    testWidgets('tocar na pergunta mostra a resposta', (tester) async {
      await tester.pumpWidget(_app(const GuidePage(isDoctor: false)));
      await tester.pump();

      expect(find.textContaining('funcionam sem internet'), findsNothing);

      await tester.tap(find.text('O app funciona sem internet?'));
      await tester.pumpAndSettle();

      expect(find.textContaining('funcionam sem internet'), findsOneWidget);
    });
  });

  group('Requisitos da foto', () {
    Future<void> pumpForm(WidgetTester tester, CaptureMode mode) async {
      await tester.pumpWidget(_app(
        Scaffold(
          body: SingleChildScrollView(
            child: ClinicalDataForm(
              sectionScope: SectionScope.triage,
              captureMode: mode,
              initialStep: 2,
              onSubmit: (_) {},
            ),
          ),
        ),
        providers: [Provider(create: (_) => SectionNavigationRegistry())],
      ));
      await tester.pump();
    }

    testWidgets('Triagem lista requisitos de foto sem dermatoscópio', (tester) async {
      await pumpForm(tester, CaptureMode.macroscopic);

      expect(find.text('Para a foto ser aceita'), findsOneWidget);
      expect(find.textContaining('Fotografe de perto'), findsOneWidget);
      expect(find.textContaining('dermatoscópio'), findsNothing);
    });

    testWidgets('Análise Assistida lista requisitos com dermatoscópio', (tester) async {
      await pumpForm(tester, CaptureMode.dermoscopic);

      expect(find.textContaining('dermatoscópio acoplado'), findsOneWidget);
      expect(find.textContaining('Fotografe de perto'), findsNothing);
    });

    testWidgets('área da foto é quadrada', (tester) async {
      await pumpForm(tester, CaptureMode.macroscopic);

      final box = tester.getSize(find.ancestor(of: find.byIcon(Icons.add_a_photo_outlined), matching: find.byType(AspectRatio)));
      expect(box.width, box.height);
    });
  });

  group('Letra E do ABCDE', () {
    testWidgets('"Mudando" anima normalmente', (tester) async {
      await tester.pumpWidget(_app(const Center(child: SizedBox(width: 80, height: 80, child: EvolutionExample(changing: true)))));
      await tester.pump(const Duration(milliseconds: 100));

      expect(tester.hasRunningAnimations, isTrue);
    });

    testWidgets('respeita "reduzir animações" do sistema', (tester) async {
      await tester.pumpWidget(_app(
        const MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: Center(child: SizedBox(width: 80, height: 80, child: EvolutionExample(changing: true))),
        ),
      ));
      await tester.pump(const Duration(milliseconds: 100));

      expect(tester.hasRunningAnimations, isFalse);
    });

    testWidgets('"Estável" não anima', (tester) async {
      await tester.pumpWidget(_app(const Center(child: SizedBox(width: 80, height: 80, child: EvolutionExample(changing: false)))));
      await tester.pump(const Duration(milliseconds: 100));

      expect(tester.hasRunningAnimations, isFalse);
    });
  });
}
