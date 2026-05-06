import 'package:dermalyze/src/features/language/controller/locale_controller.dart';
import 'package:dermalyze/src/modules/home/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';

import 'src/core/firebase_options/firebase_options.dart';
import 'src/core/theme/app_colors.dart';
import 'src/core/l10n/app_localizations.dart';
import 'src/services/local_storage_service.dart';

import 'src/modules/login/pages/login_page.dart';
import 'src/modules/register/pages/register_page.dart';
import 'src/features/auth/repositories/auth_repository.dart';
import 'src/features/auth/repositories/user_api_repository.dart';
import 'src/features/auth/controller/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        // Serviços de Infraestrutura
        Provider(create: (_) => Dio()),
        Provider(create: (_) => LocalStorageService()),
        Provider(create: (_) => AuthRepository()),
        
        // Repositórios de Dados
        ProxyProvider<Dio, UserApiRepository>(
          update: (_, dio, __) => UserApiRepository(dio: dio),
        ),

        // Controller Global de Autenticação
        ChangeNotifierProvider(
          create: (context) => AuthController(
            authRepository: context.read<AuthRepository>(),
            apiRepository: context.read<UserApiRepository>(),
            localStorage: context.read<LocalStorageService>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => LocaleController(
            localStorage: context.read<LocalStorageService>(),
            )
        ),
      ],
      child: const DermalyzeApp(),
    ),
  );
}

class DermalyzeApp extends StatelessWidget {
  const DermalyzeApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = context.watch<LocaleController>();

    return MaterialApp(
      title: 'Dermalyze',
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