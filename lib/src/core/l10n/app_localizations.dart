import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt'),
  ];

  /// No description provided for @appName.
  ///
  /// In pt, this message translates to:
  /// **'Dermalyze'**
  String get appName;

  /// No description provided for @appSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Software de Triagem e Diagnóstico PAD-UFES'**
  String get appSubtitle;

  /// No description provided for @doctorAccess.
  ///
  /// In pt, this message translates to:
  /// **'Acesso Médico'**
  String get doctorAccess;

  /// No description provided for @agentAccess.
  ///
  /// In pt, this message translates to:
  /// **'Acesso Agente'**
  String get agentAccess;

  /// No description provided for @doctorBtn.
  ///
  /// In pt, this message translates to:
  /// **'MÉDICO'**
  String get doctorBtn;

  /// No description provided for @agentBtn.
  ///
  /// In pt, this message translates to:
  /// **'AGENTE'**
  String get agentBtn;

  /// No description provided for @emailPlaceholder.
  ///
  /// In pt, this message translates to:
  /// **'E-mail'**
  String get emailPlaceholder;

  /// No description provided for @passwordPlaceholder.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get passwordPlaceholder;

  /// No description provided for @authBtn.
  ///
  /// In pt, this message translates to:
  /// **'Login'**
  String get authBtn;

  /// No description provided for @triageTitle.
  ///
  /// In pt, this message translates to:
  /// **'Triagem de Risco'**
  String get triageTitle;

  /// No description provided for @diagnosticTitle.
  ///
  /// In pt, this message translates to:
  /// **'Diagnóstico Diferencial'**
  String get diagnosticTitle;

  /// No description provided for @msgSuccessLogin.
  ///
  /// In pt, this message translates to:
  /// **'Login realizado com sucesso!'**
  String get msgSuccessLogin;

  /// No description provided for @noAccount.
  ///
  /// In pt, this message translates to:
  /// **'Não possui uma conta?'**
  String get noAccount;

  /// No description provided for @registerLink.
  ///
  /// In pt, this message translates to:
  /// **'Cadastre-se aqui'**
  String get registerLink;

  /// No description provided for @errorEmptyFields.
  ///
  /// In pt, this message translates to:
  /// **'Por favor, preencha todos os campos.'**
  String get errorEmptyFields;

  /// No description provided for @errorInvalidEmail.
  ///
  /// In pt, this message translates to:
  /// **'O formato do e-mail é inválido.'**
  String get errorInvalidEmail;

  /// No description provided for @errorUserNotFound.
  ///
  /// In pt, this message translates to:
  /// **'Usuário não cadastrado.'**
  String get errorUserNotFound;

  /// No description provided for @errorWrongPassword.
  ///
  /// In pt, this message translates to:
  /// **'Senha incorreta. Tente novamente.'**
  String get errorWrongPassword;

  /// No description provided for @errorInvalidCredential.
  ///
  /// In pt, this message translates to:
  /// **'E-mail ou senha inválidos.'**
  String get errorInvalidCredential;

  /// No description provided for @errorTooManyRequests.
  ///
  /// In pt, this message translates to:
  /// **'Muitas tentativas. Tente mais tarde.'**
  String get errorTooManyRequests;

  /// No description provided for @errorUnknown.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro inesperado.'**
  String get errorUnknown;

  /// No description provided for @registerTitle.
  ///
  /// In pt, this message translates to:
  /// **'Criar Conta'**
  String get registerTitle;

  /// No description provided for @fullNameLabel.
  ///
  /// In pt, this message translates to:
  /// **'Nome Completo'**
  String get fullNameLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar Senha'**
  String get confirmPasswordLabel;

  /// No description provided for @healthAgent.
  ///
  /// In pt, this message translates to:
  /// **'Agente de Saúde'**
  String get healthAgent;

  /// No description provided for @doctor.
  ///
  /// In pt, this message translates to:
  /// **'Médico(a)'**
  String get doctor;

  /// No description provided for @userTypeLabel.
  ///
  /// In pt, this message translates to:
  /// **'Eu sou:'**
  String get userTypeLabel;

  /// No description provided for @registerBtn.
  ///
  /// In pt, this message translates to:
  /// **'Finalizar Cadastro'**
  String get registerBtn;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In pt, this message translates to:
  /// **'Já possui uma conta? Faça login'**
  String get alreadyHaveAccount;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
