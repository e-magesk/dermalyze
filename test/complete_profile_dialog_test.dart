import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/modules/login/pages/complete_profile_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Guarda o que o diálogo devolveu ao fechar.
class _Host {
  ProfileAnswer? answer;
  bool closed = false;
}

/// Monta um app mínimo com um botão que abre o diálogo.
Future<_Host> _pumpHost(WidgetTester tester) async {
  final host = _Host();

  await tester.pumpWidget(
    MaterialApp(
      locale: const Locale('pt'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () async {
                host.answer = await showDialog<ProfileAnswer>(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => const CompleteProfileDialog(),
                );
                host.closed = true;
              },
              child: const Text('abrir'),
            ),
          ),
        ),
      ),
    ),
  );

  await tester.tap(find.text('abrir'));
  await tester.pumpAndSettle();

  return host;
}

void main() {
  group('CompleteProfileDialog', () {
    testWidgets('confirma com perfil de agente e devolve nome e role', (tester) async {
      final host = await _pumpHost(tester);

      await tester.enterText(find.byType(TextFormField), '  Ana Teste  ');
      await tester.pump();

      await tester.tap(find.text('Enviar cadastro'));
      // pumpAndSettle roda a animação de saída até o fim: é aqui que o
      // controller descartado cedo demais derrubava a árvore.
      await tester.pumpAndSettle();

      expect(host.closed, isTrue);
      expect(host.answer, isNotNull);
      expect(host.answer!.name, 'Ana Teste', reason: 'o nome deve vir sem espaços nas bordas');
      expect(host.answer!.role, 'agent');
    });

    testWidgets('confirma com perfil de médico', (tester) async {
      final host = await _pumpHost(tester);

      await tester.enterText(find.byType(TextFormField), 'Dr. Teste');
      await tester.tap(find.text('Médico(a)'));
      await tester.pump();

      await tester.tap(find.text('Enviar cadastro'));
      await tester.pumpAndSettle();

      expect(host.answer, isNotNull);
      expect(host.answer!.role, 'doctor');
    });

    testWidgets('cancelar devolve null', (tester) async {
      final host = await _pumpHost(tester);

      await tester.enterText(find.byType(TextFormField), 'Ana Teste');
      await tester.pump();

      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();

      expect(host.closed, isTrue);
      expect(host.answer, isNull);
    });

    // Regressão: confirmar leva o AuthRouter a trocar LoginPage por MainPage
    // enquanto a rota do diálogo ainda está saindo. Com o controller criado
    // fora do diálogo e descartado logo após o `await showDialog`, essa
    // desmontagem lançava "A TextEditingController was used after being
    // disposed" e, em seguida, o assert '_dependents.isEmpty' do framework.
    testWidgets('sobrevive à troca da tela de origem logo após confirmar', (tester) async {
      final logged = ValueNotifier<bool>(false);
      addTearDown(logged.dispose);

      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('pt'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ValueListenableBuilder<bool>(
            valueListenable: logged,
            builder: (context, isLogged, _) {
              if (isLogged) {
                return const Scaffold(body: Center(child: Text('MAIN')));
              }
              return Scaffold(
                body: Center(
                  child: Builder(
                    builder: (innerContext) => ElevatedButton(
                      onPressed: () async {
                        final answer = await showDialog<ProfileAnswer>(
                          context: innerContext,
                          barrierDismissible: false,
                          builder: (_) => const CompleteProfileDialog(),
                        );
                        if (answer != null) logged.value = true;
                      },
                      child: const Text('abrir'),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('abrir'));
      await tester.pumpAndSettle();

      // Foca o campo antes de digitar, como o usuário faz no tablet.
      await tester.tap(find.byType(TextFormField));
      await tester.pump();
      await tester.enterText(find.byType(TextFormField), 'Ana Teste');
      await tester.pump();

      await tester.tap(find.text('Enviar cadastro'));
      await tester.pumpAndSettle();

      expect(find.text('MAIN'), findsOneWidget);
    });

    testWidgets('confirmar fica desabilitado enquanto o nome está vazio', (tester) async {
      await _pumpHost(tester);

      TextButton confirmButton() => tester.widget<TextButton>(
            find.ancestor(
              of: find.text('Enviar cadastro'),
              matching: find.byType(TextButton),
            ),
          );

      expect(confirmButton().onPressed, isNull);

      await tester.enterText(find.byType(TextFormField), 'Ana');
      await tester.pump();

      expect(confirmButton().onPressed, isNotNull);

      // Só espaços não contam como nome preenchido.
      await tester.enterText(find.byType(TextFormField), '   ');
      await tester.pump();

      expect(confirmButton().onPressed, isNull);
    });
  });
}
