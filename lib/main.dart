import 'package:dermalyze/src/modules/login/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'src/core/firebase_options/firebase_options.dart'; // Arquivo gerado pelo flutterfire configure
import 'src/core/theme/app_colors.dart';
import 'src/modules/login/pages/login_page.dart';
import 'src/core/l10n/app_localizations.dart';

void main() async {
  // 1. Garante que os serviços do Flutter estejam prontos antes de iniciar o Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Inicializa o Firebase com as opções da sua plataforma (Android/iOS)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const DermalyzeApp());
}

class DermalyzeApp extends StatelessWidget {
  const DermalyzeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dermalyze',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        // Configura o tema global para usar a cor primária do Dermalyze
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      ),
      
      // Configurações de Idioma
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt'), // Português
        Locale('en'), // Inglês
      ],
      
      // Define a LoginPage como a tela inicial
      // home: const LoginPage(),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        // '/home': (context) => const HomePage(),
      },
    );
  }
}