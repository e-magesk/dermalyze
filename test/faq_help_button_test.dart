import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/features/analysis/controller/analysis_controller.dart';
import 'package:dermalyze/src/features/auth/controller/auth_controller.dart';
import 'package:dermalyze/src/modules/diagnosis/pages/diagnosis_page.dart';
import 'package:dermalyze/src/modules/guide/pages/guide_page.dart';
import 'package:dermalyze/src/modules/triage/pages/triage_page.dart';
import 'package:dermalyze/src/shared/navigation/section_navigation_registry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

/// Só o perfil importa para o botão de ajuda; o resto do AuthController
/// (Firebase, Firestore) não é usado.
class _FakeAuthController extends ChangeNotifier implements AuthController {
  _FakeAuthController(this.state);

  @override
  AuthState state;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<void> _pump(WidgetTester tester, Widget page, AuthState role) async {
  await tester.pumpWidget(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>.value(value: _FakeAuthController(role)),
        ChangeNotifierProvider(create: (_) => AnalysisController()),
        Provider(create: (_) => SectionNavigationRegistry()),
      ],
      child: MaterialApp(
        locale: const Locale('pt'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: page,
      ),
    ),
  );
  await tester.pump();
}

/// Distância do topo da tela até o cabeçalho de uma seção do Guia.
double _sectionTop(WidgetTester tester, String header) => tester.getTopLeft(find.text(header)).dy;

void main() {
  testWidgets('Triagem: ícone ao lado do título abre o Guia na seção da Triagem', (tester) async {
    await _pump(tester, const TriagePage(), AuthState.agent);

    final helpIcon = find.byTooltip('Dúvidas frequentes');
    expect(helpIcon, findsOneWidget);

    // Ao lado do título, não no canto: o dermatoscópio cobre o canto direito.
    final titleRight = tester.getTopRight(find.text('Triagem')).dx;
    final iconLeft = tester.getTopLeft(helpIcon).dx;
    expect(iconLeft - titleRight, lessThan(24));

    await tester.tap(helpIcon);
    await tester.pumpAndSettle();

    expect(find.byType(GuidePage), findsOneWidget);
    // A seção da Triagem fica logo abaixo da barra superior.
    expect(_sectionTop(tester, 'TRIAGEM'), lessThan(150));
    expect(find.text('Como usar a Triagem?'), findsOneWidget);
  });

  testWidgets('voltar do Guia retorna à Triagem', (tester) async {
    await _pump(tester, const TriagePage(), AuthState.agent);

    await tester.tap(find.byTooltip('Dúvidas frequentes'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();

    expect(find.byType(GuidePage), findsNothing);
    expect(find.byType(TriagePage), findsOneWidget);
  });

  testWidgets('Análise Assistida: abre o Guia na seção da Análise Assistida', (tester) async {
    await _pump(tester, const DiagnosisPage(), AuthState.doctor);

    await tester.tap(find.byTooltip('Dúvidas frequentes'));
    await tester.pumpAndSettle();

    expect(_sectionTop(tester, 'ANÁLISE ASSISTIDA'), lessThan(150));
    expect(find.text('Como usar a Análise Assistida?'), findsOneWidget);
  });

  testWidgets('Guia aberto pela aba continua no topo', (tester) async {
    await _pump(tester, const GuidePage(isDoctor: true), AuthState.doctor);

    expect(find.text('Responsabilidade Profissional'), findsOneWidget);
    expect(find.byType(BackButton), findsNothing);
    // Contraprova dos testes acima: sem foco, a seção da Triagem fica bem abaixo.
    expect(_sectionTop(tester, 'TRIAGEM'), greaterThan(400));
  });
}
