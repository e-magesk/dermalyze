import 'package:dermalyze/src/features/analysis/controller/analysis_controller.dart';
import 'package:dermalyze/src/features/language/controller/locale_controller.dart';
import 'package:dermalyze/src/modules/home/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/core/firebase_options/firebase_options.dart';
import 'src/core/theme/app_colors.dart';
import 'src/core/l10n/app_localizations.dart';
import 'src/services/local_storage_service.dart';
import 'src/shared/navigation/section_navigation_registry.dart';

import 'src/modules/login/pages/forgot_password_page.dart';
import 'src/modules/login/pages/login_page.dart';
import 'src/modules/register/pages/register_page.dart';
import 'src/features/auth/repositories/auth_repository.dart';
import 'src/features/auth/repositories/user_profile_repository.dart';
import 'src/features/auth/controller/auth_controller.dart';

/// Navigator raiz. Ao encerrar a sessão, fecha qualquer tela ou diálogo aberto
/// por cima (ex.: a tela de recorte), para o login não ficar escondido.
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _discardLegacySyncQueue();

  runApp(
    MultiProvider(
      providers: [
        // Serviços de Infraestrutura
        Provider(create: (_) => LocalStorageService()),
        Provider(create: (_) => AuthRepository()),
        Provider(create: (_) => UserProfileRepository()),
        Provider(create: (_) => SectionNavigationRegistry()),

        ChangeNotifierProvider(create: (_) => AnalysisController()),

        // Controller Global de Autenticação
        ChangeNotifierProvider(
          create: (context) => AuthController(
            authRepository: context.read<AuthRepository>(),
            profileRepository: context.read<UserProfileRepository>(),
            localStorage: context.read<LocalStorageService>(),
            onSessionEnded: () {
              // O próximo usuário do tablet não pode ver o paciente anterior.
              context.read<AnalysisController>().clearAll();
              rootNavigatorKey.currentState?.popUntil((route) => route.isFirst);
            },
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => LocaleController(
            localStorage: context.read<LocalStorageService>())
        ),
      ],
      child: const DermalyzeApp(),
    ),
  );
}

/// A v1.0 não guarda mais os casos analisados. Versões anteriores mantinham
/// uma fila local para enviar ao servidor, que foi removido; aqui ela é apagada
/// dos aparelhos que já a tinham. Pode sair numa versão futura, junto com a
/// dependência shared_preferences.
Future<void> _discardLegacySyncQueue() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('sync_queue');
  } catch (e) {
    debugPrint('Falha ao apagar a fila de sincronização antiga: $e');
  }
}

class DermalyzeApp extends StatelessWidget {
  const DermalyzeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = context.watch<LocaleController>();

    return MaterialApp(
      title: 'Dermalyze',
      navigatorKey: rootNavigatorKey,
      debugShowCheckedModeBanner: false,
      locale: localeController.locale,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),

      // Mantendo suas configurações de Idioma
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt'),
        Locale('en'),
      ],

      // O AuthRouter decide qual é a primeira tela baseada no login
      home: const AuthRouter(),

      // Mantemos as rotas nomeadas para navegações específicas (como ir para o registro)
      routes: {
        '/register': (context) => const RegisterPage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
      },
    );
  }
}

/// Widget responsável por escutar o estado de autenticação e trocar a tela base
class AuthRouter extends StatelessWidget {
  const AuthRouter({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();

    switch (authController.state) {
      case AuthState.loading:
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      case AuthState.unauthenticated:
        return const LoginPage();
      case AuthState.doctor:
      case AuthState.agent:
        return const MainPage();
    }
  }
}
