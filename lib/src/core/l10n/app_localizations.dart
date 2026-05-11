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
  /// **'ACESSO AGENTE'**
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

  /// No description provided for @medicalAccess.
  ///
  /// In pt, this message translates to:
  /// **'ACESSO MÉDICO'**
  String get medicalAccess;

  /// No description provided for @helloUser.
  ///
  /// In pt, this message translates to:
  /// **'Olá, {userName}'**
  String helloUser(Object userName);

  /// No description provided for @connectedUFES.
  ///
  /// In pt, this message translates to:
  /// **'CONECTADO: LIFE-UFES'**
  String get connectedUFES;

  /// No description provided for @databaseUpdated.
  ///
  /// In pt, this message translates to:
  /// **'Base de Dados Atualizada'**
  String get databaseUpdated;

  /// No description provided for @clinicalTriage.
  ///
  /// In pt, this message translates to:
  /// **'Triagem Clínica'**
  String get clinicalTriage;

  /// No description provided for @triageLevels.
  ///
  /// In pt, this message translates to:
  /// **'NÍVEIS P1 - P5'**
  String get triageLevels;

  /// No description provided for @differentialAnalysis.
  ///
  /// In pt, this message translates to:
  /// **'Análise Diferencial'**
  String get differentialAnalysis;

  /// No description provided for @aiDiagnosis.
  ///
  /// In pt, this message translates to:
  /// **'DIAGNÓSTICO IA'**
  String get aiDiagnosis;

  /// No description provided for @quickAccess.
  ///
  /// In pt, this message translates to:
  /// **'ACESSO RÁPIDO'**
  String get quickAccess;

  /// No description provided for @appGuide.
  ///
  /// In pt, this message translates to:
  /// **'Guia do Aplicativo'**
  String get appGuide;

  /// No description provided for @instructionsResp.
  ///
  /// In pt, this message translates to:
  /// **'Instruções e Responsabilidades'**
  String get instructionsResp;

  /// No description provided for @navHome.
  ///
  /// In pt, this message translates to:
  /// **'HOME'**
  String get navHome;

  /// No description provided for @navTriage.
  ///
  /// In pt, this message translates to:
  /// **'TRIAGEM'**
  String get navTriage;

  /// No description provided for @navDiagnosis.
  ///
  /// In pt, this message translates to:
  /// **'DIAGNÓSTICO'**
  String get navDiagnosis;

  /// No description provided for @navLibrary.
  ///
  /// In pt, this message translates to:
  /// **'BIBLIOTECA'**
  String get navLibrary;

  /// No description provided for @navGuide.
  ///
  /// In pt, this message translates to:
  /// **'GUIA'**
  String get navGuide;

  /// No description provided for @settings.
  ///
  /// In pt, this message translates to:
  /// **'Configurações'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In pt, this message translates to:
  /// **'Idiomas'**
  String get language;

  /// No description provided for @activeSession.
  ///
  /// In pt, this message translates to:
  /// **'Sessão Ativa'**
  String get activeSession;

  /// No description provided for @logout.
  ///
  /// In pt, this message translates to:
  /// **'ENCERRAR SESSÃO'**
  String get logout;

  /// No description provided for @portuguese.
  ///
  /// In pt, this message translates to:
  /// **'Português'**
  String get portuguese;

  /// No description provided for @english.
  ///
  /// In pt, this message translates to:
  /// **'Inglês'**
  String get english;

  /// No description provided for @formStep1Title.
  ///
  /// In pt, this message translates to:
  /// **'Dados Básicos'**
  String get formStep1Title;

  /// No description provided for @formPatientAge.
  ///
  /// In pt, this message translates to:
  /// **'Idade do Paciente'**
  String get formPatientAge;

  /// No description provided for @formCancerHistory.
  ///
  /// In pt, this message translates to:
  /// **'Histórico de Câncer'**
  String get formCancerHistory;

  /// No description provided for @formBodyRegion.
  ///
  /// In pt, this message translates to:
  /// **'Região da Lesão'**
  String get formBodyRegion;

  /// No description provided for @formStep2Title.
  ///
  /// In pt, this message translates to:
  /// **'Sintomas da Lesão'**
  String get formStep2Title;

  /// No description provided for @formSympItch.
  ///
  /// In pt, this message translates to:
  /// **'A lesão coça?'**
  String get formSympItch;

  /// No description provided for @formSympBleed.
  ///
  /// In pt, this message translates to:
  /// **'A lesão sangra?'**
  String get formSympBleed;

  /// No description provided for @formSympGrow.
  ///
  /// In pt, this message translates to:
  /// **'A lesão cresceu?'**
  String get formSympGrow;

  /// No description provided for @formSympHurt.
  ///
  /// In pt, this message translates to:
  /// **'A lesão dói?'**
  String get formSympHurt;

  /// No description provided for @formSympChange.
  ///
  /// In pt, this message translates to:
  /// **'A lesão mudou de cor/forma?'**
  String get formSympChange;

  /// No description provided for @formSympElevate.
  ///
  /// In pt, this message translates to:
  /// **'A lesão tem elevação?'**
  String get formSympElevate;

  /// No description provided for @formStep3Title.
  ///
  /// In pt, this message translates to:
  /// **'Captura de Imagem'**
  String get formStep3Title;

  /// No description provided for @formBtnNext.
  ///
  /// In pt, this message translates to:
  /// **'PRÓXIMO'**
  String get formBtnNext;

  /// No description provided for @formBtnBack.
  ///
  /// In pt, this message translates to:
  /// **'VOLTAR'**
  String get formBtnBack;

  /// No description provided for @formBtnAnalyze.
  ///
  /// In pt, this message translates to:
  /// **'ANALISAR AGORA'**
  String get formBtnAnalyze;

  /// No description provided for @formBtnCapture.
  ///
  /// In pt, this message translates to:
  /// **'Capturar Lesão'**
  String get formBtnCapture;

  /// No description provided for @formOptYes.
  ///
  /// In pt, this message translates to:
  /// **'Sim'**
  String get formOptYes;

  /// No description provided for @formOptNo.
  ///
  /// In pt, this message translates to:
  /// **'Não'**
  String get formOptNo;

  /// No description provided for @formOptNotSure.
  ///
  /// In pt, this message translates to:
  /// **'Não Sei'**
  String get formOptNotSure;

  /// No description provided for @regionFace.
  ///
  /// In pt, this message translates to:
  /// **'Face'**
  String get regionFace;

  /// No description provided for @regionNose.
  ///
  /// In pt, this message translates to:
  /// **'Nariz'**
  String get regionNose;

  /// No description provided for @regionEar.
  ///
  /// In pt, this message translates to:
  /// **'Orelha'**
  String get regionEar;

  /// No description provided for @regionLips.
  ///
  /// In pt, this message translates to:
  /// **'Lábios'**
  String get regionLips;

  /// No description provided for @regionScalp.
  ///
  /// In pt, this message translates to:
  /// **'Couro Cabeludo'**
  String get regionScalp;

  /// No description provided for @regionNeck.
  ///
  /// In pt, this message translates to:
  /// **'Pescoço'**
  String get regionNeck;

  /// No description provided for @regionChest.
  ///
  /// In pt, this message translates to:
  /// **'Peitoral'**
  String get regionChest;

  /// No description provided for @regionAbdomen.
  ///
  /// In pt, this message translates to:
  /// **'Abdome'**
  String get regionAbdomen;

  /// No description provided for @regionDorsum.
  ///
  /// In pt, this message translates to:
  /// **'Dorso'**
  String get regionDorsum;

  /// No description provided for @regionShoulder.
  ///
  /// In pt, this message translates to:
  /// **'Ombro'**
  String get regionShoulder;

  /// No description provided for @regionArm.
  ///
  /// In pt, this message translates to:
  /// **'Braço'**
  String get regionArm;

  /// No description provided for @regionForearm.
  ///
  /// In pt, this message translates to:
  /// **'Antebraço'**
  String get regionForearm;

  /// No description provided for @regionHand.
  ///
  /// In pt, this message translates to:
  /// **'Mão'**
  String get regionHand;

  /// No description provided for @regionThigh.
  ///
  /// In pt, this message translates to:
  /// **'Coxa'**
  String get regionThigh;

  /// No description provided for @regionLeg.
  ///
  /// In pt, this message translates to:
  /// **'Perna'**
  String get regionLeg;

  /// No description provided for @regionFoot.
  ///
  /// In pt, this message translates to:
  /// **'Pé'**
  String get regionFoot;

  /// No description provided for @regionGenitals.
  ///
  /// In pt, this message translates to:
  /// **'Genitais'**
  String get regionGenitals;

  /// No description provided for @regionGluteus.
  ///
  /// In pt, this message translates to:
  /// **'Glúteo'**
  String get regionGluteus;

  /// No description provided for @regionGroin.
  ///
  /// In pt, this message translates to:
  /// **'Inguinal (Virilha)'**
  String get regionGroin;

  /// No description provided for @valImageCheckTitle.
  ///
  /// In pt, this message translates to:
  /// **'Verificando Imagem'**
  String get valImageCheckTitle;

  /// No description provided for @valImageErrorTitle.
  ///
  /// In pt, this message translates to:
  /// **'Imagem Inválida'**
  String get valImageErrorTitle;

  /// No description provided for @valImageErrorDesc.
  ///
  /// In pt, this message translates to:
  /// **'O nosso sistema detectou que a imagem capturada não apresenta características claras de uma lesão de pele. Por favor, tente novamente com melhor iluminação e foco.'**
  String get valImageErrorDesc;

  /// No description provided for @triageP1Label.
  ///
  /// In pt, this message translates to:
  /// **'P1'**
  String get triageP1Label;

  /// No description provided for @triageP1Title.
  ///
  /// In pt, this message translates to:
  /// **'Prioridade Máxima'**
  String get triageP1Title;

  /// No description provided for @triageP1Desc.
  ///
  /// In pt, this message translates to:
  /// **'A lesão possui características suspeitas com alto indício de malignidade. Necessita da maior prioridade no atendimento.'**
  String get triageP1Desc;

  /// No description provided for @triageP1Conduta.
  ///
  /// In pt, this message translates to:
  /// **'Encaminhamento imediato para dermatologista ou oncologista. Requer biópsia incisional ou excisional com urgência.'**
  String get triageP1Conduta;

  /// No description provided for @triageP2Label.
  ///
  /// In pt, this message translates to:
  /// **'P2'**
  String get triageP2Label;

  /// No description provided for @triageP2Title.
  ///
  /// In pt, this message translates to:
  /// **'Alta Prioridade'**
  String get triageP2Title;

  /// No description provided for @triageP2Desc.
  ///
  /// In pt, this message translates to:
  /// **'A lesão possui sinais de tumor de pele ou pode se transformar em um no futuro. O paciente requer alto nível de atenção.'**
  String get triageP2Desc;

  /// No description provided for @triageP2Conduta.
  ///
  /// In pt, this message translates to:
  /// **'Agendar avaliação dermatológica em caráter prioritário (idealmente em até 15 dias). Considerar dermatoscopia especializada.'**
  String get triageP2Conduta;

  /// No description provided for @triageP3Label.
  ///
  /// In pt, this message translates to:
  /// **'P3'**
  String get triageP3Label;

  /// No description provided for @triageP3Title.
  ///
  /// In pt, this message translates to:
  /// **'Prioridade Média'**
  String get triageP3Title;

  /// No description provided for @triageP3Desc.
  ///
  /// In pt, this message translates to:
  /// **'A lesão apresenta sinais de doença de pele que requer tratamento clínico, mas sem características imediatas de alto risco oncológico.'**
  String get triageP3Desc;

  /// No description provided for @triageP3Conduta.
  ///
  /// In pt, this message translates to:
  /// **'Encaminhamento para avaliação ambulatorial de rotina. Orientar fotoproteção e observação de mudanças (regra ABCDE).'**
  String get triageP3Conduta;

  /// No description provided for @triageP4Label.
  ///
  /// In pt, this message translates to:
  /// **'P4'**
  String get triageP4Label;

  /// No description provided for @triageP4Title.
  ///
  /// In pt, this message translates to:
  /// **'Baixa Prioridade'**
  String get triageP4Title;

  /// No description provided for @triageP4Desc.
  ///
  /// In pt, this message translates to:
  /// **'A lesão aparenta ser um problema dermatológico benigno e simples. Requer baixo nível de atenção especializada.'**
  String get triageP4Desc;

  /// No description provided for @triageP4Conduta.
  ///
  /// In pt, this message translates to:
  /// **'Manejo clínico na Atenção Primária. Acompanhamento clínico de rotina, sem necessidade de encaminhamento especializado imediato.'**
  String get triageP4Conduta;

  /// No description provided for @triageP5Label.
  ///
  /// In pt, this message translates to:
  /// **'P5'**
  String get triageP5Label;

  /// No description provided for @triageP5Title.
  ///
  /// In pt, this message translates to:
  /// **'Prioridade Mínima'**
  String get triageP5Title;

  /// No description provided for @triageP5Desc.
  ///
  /// In pt, this message translates to:
  /// **'Condição dermatológica ausente, fisiológica ou muito simples. Ausência de necessidade de atenção prioritária.'**
  String get triageP5Desc;

  /// No description provided for @triageP5Conduta.
  ///
  /// In pt, this message translates to:
  /// **'Nenhuma intervenção cirúrgica necessária. Orientar sobre cuidados gerais com a pele e prevenção solar.'**
  String get triageP5Conduta;

  /// No description provided for @diagMelanomaName.
  ///
  /// In pt, this message translates to:
  /// **'Melanoma'**
  String get diagMelanomaName;

  /// No description provided for @diagMelanomaDesc.
  ///
  /// In pt, this message translates to:
  /// **'Neoplasia maligna originada nos melanócitos. Apresenta alto potencial de metástase se não tratada precocemente. Caracteriza-se por assimetria, bordas irregulares e variação de cores.'**
  String get diagMelanomaDesc;

  /// No description provided for @diagMelanomaConduta.
  ///
  /// In pt, this message translates to:
  /// **'Excisão cirúrgica de urgência com margens amplas de segurança. Necessário exame histopatológico completo, estadiamento oncológico e possível pesquisa de linfonodo sentinela (conforme índice de Breslow).'**
  String get diagMelanomaConduta;

  /// No description provided for @diagBCCName.
  ///
  /// In pt, this message translates to:
  /// **'Carcinoma Basocelular'**
  String get diagBCCName;

  /// No description provided for @diagBCCDesc.
  ///
  /// In pt, this message translates to:
  /// **'Câncer de pele mais comum. Crescimento lento, localmente invasivo, mas com baixíssimo potencial de metástase. Frequentemente apresenta aspecto perláceo e telangiectasias.'**
  String get diagBCCDesc;

  /// No description provided for @diagBCCConduta.
  ///
  /// In pt, this message translates to:
  /// **'Excisão cirúrgica padrão (margem de 4 a 5 mm). Em áreas nobres (face) ou subtipos agressivos, considerar Cirurgia Micrográfica de Mohs. Alternativas: crioterapia ou terapias tópicas para subtipos superficiais.'**
  String get diagBCCConduta;

  /// No description provided for @diagSCCName.
  ///
  /// In pt, this message translates to:
  /// **'Carcinoma Espinocelular'**
  String get diagSCCName;

  /// No description provided for @diagSCCDesc.
  ///
  /// In pt, this message translates to:
  /// **'Segundo tipo mais comum. Origina-se nas células escamosas da epiderme. Pode apresentar crescimento rápido e possui potencial de metástase maior que o CBC.'**
  String get diagSCCDesc;

  /// No description provided for @diagSCCConduta.
  ///
  /// In pt, this message translates to:
  /// **'Excisão cirúrgica com margens adequadas (geralmente 4 a 6 mm). Requer palpação de linfonodos regionais para descartar disseminação. Monitoramento rigoroso pós-operatório.'**
  String get diagSCCConduta;

  /// No description provided for @diagAKName.
  ///
  /// In pt, this message translates to:
  /// **'Ceratose actínica'**
  String get diagAKName;

  /// No description provided for @diagAKDesc.
  ///
  /// In pt, this message translates to:
  /// **'Lesão pré-cancerosa causada pela exposição solar crônica. Caracteriza-se por superfície áspera e descamativa. Pode evoluir para carcinoma espinocelular.'**
  String get diagAKDesc;

  /// No description provided for @diagAKConduta.
  ///
  /// In pt, this message translates to:
  /// **'Tratamento preventivo e de campo de cancerização. Opções incluem crioterapia (lesões isoladas), 5-fluorouracil, imiquimode tópicos, ou terapia fotodinâmica. Aconselhamento rigoroso sobre fotoproteção.'**
  String get diagAKConduta;

  /// No description provided for @diagSKName.
  ///
  /// In pt, this message translates to:
  /// **'Ceratose Seborreica'**
  String get diagSKName;

  /// No description provided for @diagSKDesc.
  ///
  /// In pt, this message translates to:
  /// **'Tumor benigno epidérmico muito comum. Aspecto verrucoso ou \'colado\' na pele, com cores variando de bronze a preto. Sem potencial maligno.'**
  String get diagSKDesc;

  /// No description provided for @diagSKConduta.
  ///
  /// In pt, this message translates to:
  /// **'Conduta expectante (nenhum tratamento estritamente médico é necessário). Remoção apenas por motivos estéticos ou se a lesão estiver sujeita a trauma constante (crioterapia, curetagem ou eletrocoagulação).'**
  String get diagSKConduta;

  /// No description provided for @diagNevusName.
  ///
  /// In pt, this message translates to:
  /// **'Nevo Melanocítico'**
  String get diagNevusName;

  /// No description provided for @diagNevusDesc.
  ///
  /// In pt, this message translates to:
  /// **'Lesão pigmentada benigna e estável (pinta comum). Composta por aglomerados de melanócitos com arquitetura regular, bordas bem definidas e coloração homogênea.'**
  String get diagNevusDesc;

  /// No description provided for @diagNevusConduta.
  ///
  /// In pt, this message translates to:
  /// **'Acompanhamento clínico de rotina. Avaliação dermatoscópica anual. Biópsia excisional apenas recomendada se a lesão apresentar mudanças súbitas (Regra ABCDE) ou irritação constante.'**
  String get diagNevusConduta;

  /// No description provided for @clinicalDiagnosis.
  ///
  /// In pt, this message translates to:
  /// **'Diagnóstico Clínico'**
  String get clinicalDiagnosis;

  /// No description provided for @diagnosisSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Análise detalhada para identificação de patologias específicas.'**
  String get diagnosisSubtitle;

  /// No description provided for @diagnosisSuggested.
  ///
  /// In pt, this message translates to:
  /// **'Diagnóstico Sugerido:'**
  String get diagnosisSuggested;

  /// No description provided for @diagnosisNew.
  ///
  /// In pt, this message translates to:
  /// **'NOVO DIAGNÓSTICO'**
  String get diagnosisNew;

  /// No description provided for @analysisTryAgain.
  ///
  /// In pt, this message translates to:
  /// **'TENTAR NOVAMENTE'**
  String get analysisTryAgain;

  /// No description provided for @analysisLabelConfidence.
  ///
  /// In pt, this message translates to:
  /// **'Confiança'**
  String get analysisLabelConfidence;

  /// No description provided for @analysisResultsTitle.
  ///
  /// In pt, this message translates to:
  /// **'Resultados da Análise'**
  String get analysisResultsTitle;

  /// No description provided for @analysisClinicalFeatures.
  ///
  /// In pt, this message translates to:
  /// **'Características Clínicas'**
  String get analysisClinicalFeatures;

  /// No description provided for @analysisManagementTitle.
  ///
  /// In pt, this message translates to:
  /// **'Manejo e Conduta'**
  String get analysisManagementTitle;

  /// No description provided for @triageNew.
  ///
  /// In pt, this message translates to:
  /// **'Nova Triagem'**
  String get triageNew;

  /// No description provided for @syncStatusUpdated.
  ///
  /// In pt, this message translates to:
  /// **'Base de dados atualizada'**
  String get syncStatusUpdated;

  /// No description provided for @syncStatusPending.
  ///
  /// In pt, this message translates to:
  /// **'Aguardando conexão para enviar {count} dados...'**
  String syncStatusPending(int count);

  /// No description provided for @libTitle.
  ///
  /// In pt, this message translates to:
  /// **'Biblioteca Técnica'**
  String get libTitle;

  /// No description provided for @libHeroTitle.
  ///
  /// In pt, this message translates to:
  /// **'Conhecimento'**
  String get libHeroTitle;

  /// No description provided for @libHeroSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Central de Apoio PAD-UFES'**
  String get libHeroSubtitle;

  /// No description provided for @libMenuAbcdeTitle.
  ///
  /// In pt, this message translates to:
  /// **'ABCDE do Câncer'**
  String get libMenuAbcdeTitle;

  /// No description provided for @libMenuAbcdeDesc.
  ///
  /// In pt, this message translates to:
  /// **'Manual Visual de Risco'**
  String get libMenuAbcdeDesc;

  /// No description provided for @libMenuDiseasesTitle.
  ///
  /// In pt, this message translates to:
  /// **'Principais Doenças'**
  String get libMenuDiseasesTitle;

  /// No description provided for @libMenuDiseasesDesc.
  ///
  /// In pt, this message translates to:
  /// **'Enciclopédia Dermatológica'**
  String get libMenuDiseasesDesc;

  /// No description provided for @libMenuTriageTitle.
  ///
  /// In pt, this message translates to:
  /// **'Metodologia e Triagem'**
  String get libMenuTriageTitle;

  /// No description provided for @libMenuTriageDesc.
  ///
  /// In pt, this message translates to:
  /// **'Como os casos são agrupados'**
  String get libMenuTriageDesc;

  /// No description provided for @libAbcdeHeroTitle.
  ///
  /// In pt, this message translates to:
  /// **'O que é a regra do ABCDE?'**
  String get libAbcdeHeroTitle;

  /// No description provided for @libAbcdeHeroDesc1.
  ///
  /// In pt, this message translates to:
  /// **'A regra do ABCDE é uma metodologia clínica padronizada mundialmente para auxiliar na detecção precoce do câncer de pele, especificamente o Melanoma.'**
  String get libAbcdeHeroDesc1;

  /// No description provided for @libAbcdeHeroDesc2.
  ///
  /// In pt, this message translates to:
  /// **'Ela serve como um guia prático para profissionais da saúde e pacientes avaliarem características morfológicas de lesões pigmentadas.'**
  String get libAbcdeHeroDesc2;

  /// No description provided for @libAbcdeCriteria.
  ///
  /// In pt, this message translates to:
  /// **'Critérios de Avaliação'**
  String get libAbcdeCriteria;

  /// No description provided for @libAbcdeBenign.
  ///
  /// In pt, this message translates to:
  /// **'Benigno'**
  String get libAbcdeBenign;

  /// No description provided for @libAbcdeMalign.
  ///
  /// In pt, this message translates to:
  /// **'Suspeito'**
  String get libAbcdeMalign;

  /// No description provided for @libDiseasesHeroTitle.
  ///
  /// In pt, this message translates to:
  /// **'Patologias Analisadas'**
  String get libDiseasesHeroTitle;

  /// No description provided for @libDiseasesHeroDesc1.
  ///
  /// In pt, this message translates to:
  /// **'Nesta seção, apresentamos as principais doenças dermatológicas que são retratadas e classificadas pelo sistema.'**
  String get libDiseasesHeroDesc1;

  /// No description provided for @libDiseasesHeroDesc2.
  ///
  /// In pt, this message translates to:
  /// **'O Nível de Prioridade indica o grau de urgência clínica associado àquela condição.'**
  String get libDiseasesHeroDesc2;

  /// No description provided for @libDiseasesEncyclopedia.
  ///
  /// In pt, this message translates to:
  /// **'Enciclopédia Clínica'**
  String get libDiseasesEncyclopedia;

  /// No description provided for @libTriageHeroTitle.
  ///
  /// In pt, this message translates to:
  /// **'Metodologia P1-P5'**
  String get libTriageHeroTitle;

  /// No description provided for @libTriageHeroSubtitle.
  ///
  /// In pt, this message translates to:
  /// **'Lógica de agrupamento e gravidade'**
  String get libTriageHeroSubtitle;

  /// No description provided for @libTriageHeroDesc.
  ///
  /// In pt, this message translates to:
  /// **'Nosso sistema utiliza uma hierarquia de gravidade dividida em 5 níveis.'**
  String get libTriageHeroDesc;

  /// No description provided for @libAbcdeLetterA.
  ///
  /// In pt, this message translates to:
  /// **'A'**
  String get libAbcdeLetterA;

  /// No description provided for @libAbcdeTitleA.
  ///
  /// In pt, this message translates to:
  /// **'Assimetria'**
  String get libAbcdeTitleA;

  /// No description provided for @libAbcdeDescA.
  ///
  /// In pt, this message translates to:
  /// **'Metades desiguais.'**
  String get libAbcdeDescA;

  /// No description provided for @libAbcdeBenignA.
  ///
  /// In pt, this message translates to:
  /// **'Simétrico'**
  String get libAbcdeBenignA;

  /// No description provided for @libAbcdeMalignA.
  ///
  /// In pt, this message translates to:
  /// **'Assimétrico'**
  String get libAbcdeMalignA;

  /// No description provided for @libAbcdeLetterB.
  ///
  /// In pt, this message translates to:
  /// **'B'**
  String get libAbcdeLetterB;

  /// No description provided for @libAbcdeTitleB.
  ///
  /// In pt, this message translates to:
  /// **'Bordas'**
  String get libAbcdeTitleB;

  /// No description provided for @libAbcdeDescB.
  ///
  /// In pt, this message translates to:
  /// **'Irregulares ou serrilhadas.'**
  String get libAbcdeDescB;

  /// No description provided for @libAbcdeBenignB.
  ///
  /// In pt, this message translates to:
  /// **'Regulares'**
  String get libAbcdeBenignB;

  /// No description provided for @libAbcdeMalignB.
  ///
  /// In pt, this message translates to:
  /// **'Irregulares'**
  String get libAbcdeMalignB;

  /// No description provided for @libAbcdeLetterC.
  ///
  /// In pt, this message translates to:
  /// **'C'**
  String get libAbcdeLetterC;

  /// No description provided for @libAbcdeTitleC.
  ///
  /// In pt, this message translates to:
  /// **'Cores'**
  String get libAbcdeTitleC;

  /// No description provided for @libAbcdeDescC.
  ///
  /// In pt, this message translates to:
  /// **'Múltiplos tons presentes.'**
  String get libAbcdeDescC;

  /// No description provided for @libAbcdeBenignC.
  ///
  /// In pt, this message translates to:
  /// **'Cor Única'**
  String get libAbcdeBenignC;

  /// No description provided for @libAbcdeMalignC.
  ///
  /// In pt, this message translates to:
  /// **'Várias Cores'**
  String get libAbcdeMalignC;

  /// No description provided for @libAbcdeLetterD.
  ///
  /// In pt, this message translates to:
  /// **'D'**
  String get libAbcdeLetterD;

  /// No description provided for @libAbcdeTitleD.
  ///
  /// In pt, this message translates to:
  /// **'Diâmetro'**
  String get libAbcdeTitleD;

  /// No description provided for @libAbcdeDescD.
  ///
  /// In pt, this message translates to:
  /// **'Extensão maior que 6mm.'**
  String get libAbcdeDescD;

  /// No description provided for @libAbcdeBenignD.
  ///
  /// In pt, this message translates to:
  /// **'< 6mm'**
  String get libAbcdeBenignD;

  /// No description provided for @libAbcdeMalignD.
  ///
  /// In pt, this message translates to:
  /// **'> 6mm'**
  String get libAbcdeMalignD;

  /// No description provided for @libAbcdeLetterE.
  ///
  /// In pt, this message translates to:
  /// **'E'**
  String get libAbcdeLetterE;

  /// No description provided for @libAbcdeTitleE.
  ///
  /// In pt, this message translates to:
  /// **'Evolução'**
  String get libAbcdeTitleE;

  /// No description provided for @libAbcdeDescE.
  ///
  /// In pt, this message translates to:
  /// **'Mudança de forma ou cor.'**
  String get libAbcdeDescE;

  /// No description provided for @libAbcdeBenignE.
  ///
  /// In pt, this message translates to:
  /// **'Estável'**
  String get libAbcdeBenignE;

  /// No description provided for @libAbcdeMalignE.
  ///
  /// In pt, this message translates to:
  /// **'Mudando'**
  String get libAbcdeMalignE;

  /// No description provided for @diagLentigoName.
  ///
  /// In pt, this message translates to:
  /// **'Lentigo maligno'**
  String get diagLentigoName;

  /// No description provided for @diagLentigoDesc.
  ///
  /// In pt, this message translates to:
  /// **'Forma de melanoma in situ que ocorre em pele cronicamente exposta ao sol, geralmente em idosos. Evolução lenta com pigmentação irregular.'**
  String get diagLentigoDesc;

  /// No description provided for @diagNevoD22Name.
  ///
  /// In pt, this message translates to:
  /// **'Nevo melanocítico (D22)'**
  String get diagNevoD22Name;

  /// No description provided for @diagNevoD22Desc.
  ///
  /// In pt, this message translates to:
  /// **'Nevo com características atípicas ou suspeitas que requerem monitoramento rigoroso devido ao potencial de transformação ou confusão diagnóstica com melanoma.'**
  String get diagNevoD22Desc;

  /// No description provided for @diagBowenName.
  ///
  /// In pt, this message translates to:
  /// **'Doença de Bowen'**
  String get diagBowenName;

  /// No description provided for @diagBowenDesc.
  ///
  /// In pt, this message translates to:
  /// **'Carcinoma espinocelular in situ. Apresenta-se como placa eritemato-escamosa persistente e bem delimitada.'**
  String get diagBowenDesc;

  /// No description provided for @diagKeratoacanthomaName.
  ///
  /// In pt, this message translates to:
  /// **'Ceratoacantoma'**
  String get diagKeratoacanthomaName;

  /// No description provided for @diagKeratoacanthomaDesc.
  ///
  /// In pt, this message translates to:
  /// **'Nódulo de crescimento rápido com cratera central de queratina. Frequentemente involui, mas é clinicamente difícil de distinguir do CEC.'**
  String get diagKeratoacanthomaDesc;

  /// No description provided for @diagCutaneousHornName.
  ///
  /// In pt, this message translates to:
  /// **'Corno Cutâneo'**
  String get diagCutaneousHornName;

  /// No description provided for @diagCutaneousHornDesc.
  ///
  /// In pt, this message translates to:
  /// **'Projeção queratótica cônica. É um diagnóstico morfológico que pode ocultar desde lesões benignas até carcinomas na base.'**
  String get diagCutaneousHornDesc;

  /// No description provided for @diagEczemaName.
  ///
  /// In pt, this message translates to:
  /// **'Eczema'**
  String get diagEczemaName;

  /// No description provided for @diagEczemaDesc.
  ///
  /// In pt, this message translates to:
  /// **'Condição inflamatória da pele que causa vermelhidão, coceira e descamação. Requer manejo clínico para controle de sintomas e barreira cutânea.'**
  String get diagEczemaDesc;

  /// No description provided for @diagDermatitisName.
  ///
  /// In pt, this message translates to:
  /// **'Dermatite'**
  String get diagDermatitisName;

  /// No description provided for @diagDermatitisDesc.
  ///
  /// In pt, this message translates to:
  /// **'Termo amplo para inflamações cutâneas que podem ser causadas por contato, alergia ou fatores genéticos. Requer diagnóstico etiológico.'**
  String get diagDermatitisDesc;

  /// No description provided for @diagNevusL78Name.
  ///
  /// In pt, this message translates to:
  /// **'Nevo (L78)'**
  String get diagNevusL78Name;

  /// No description provided for @diagNevusL78Desc.
  ///
  /// In pt, this message translates to:
  /// **'Lesão pigmentada benigna e estável (pinta comum). Composta por aglomerados de melanócitos com arquitetura regular e coloração homogênea.'**
  String get diagNevusL78Desc;

  /// No description provided for @diagAcneName.
  ///
  /// In pt, this message translates to:
  /// **'Acne'**
  String get diagAcneName;

  /// No description provided for @diagAcneDesc.
  ///
  /// In pt, this message translates to:
  /// **'Condição inflamatória das glândulas pilossebáceas. Apresenta-se como comedões, pápulas ou pústulas. Sem relevância oncológica.'**
  String get diagAcneDesc;

  /// No description provided for @diagNoLesionName.
  ///
  /// In pt, this message translates to:
  /// **'Ausência de lesão'**
  String get diagNoLesionName;

  /// No description provided for @diagNoLesionDesc.
  ///
  /// In pt, this message translates to:
  /// **'Pele com características de normalidade, sem evidência de patologias dermatológicas no local analisado.'**
  String get diagNoLesionDesc;

  /// No description provided for @guideTitle.
  ///
  /// In pt, this message translates to:
  /// **'Guia de Uso'**
  String get guideTitle;

  /// No description provided for @guideRespTitle.
  ///
  /// In pt, this message translates to:
  /// **'Responsabilidade Profissional'**
  String get guideRespTitle;

  /// No description provided for @guideRespBody.
  ///
  /// In pt, this message translates to:
  /// **'Este aplicativo é uma ferramenta de suporte à decisão clínica (CAD). A análise realizada pela Inteligência Artificial tem caráter consultivo.'**
  String get guideRespBody;

  /// No description provided for @guideRespFooter.
  ///
  /// In pt, this message translates to:
  /// **'A decisão final sobre o diagnóstico, encaminhamento e tratamento permanece, em todos os casos, sob responsabilidade exclusiva do profissional de saúde assistente.'**
  String get guideRespFooter;

  /// No description provided for @guideFlowTitleAgent.
  ///
  /// In pt, this message translates to:
  /// **'Fluxo Triagem'**
  String get guideFlowTitleAgent;

  /// No description provided for @guideFlowTitleDoctor.
  ///
  /// In pt, this message translates to:
  /// **'Fluxo Triagem/Diagnóstico'**
  String get guideFlowTitleDoctor;

  /// No description provided for @guideStep1Title.
  ///
  /// In pt, this message translates to:
  /// **'Dados do Paciente'**
  String get guideStep1Title;

  /// No description provided for @guideStep1Desc.
  ///
  /// In pt, this message translates to:
  /// **'Insira a idade e o histórico clínico de câncer de pele para contextualizar a análise.'**
  String get guideStep1Desc;

  /// No description provided for @guideStep2Title.
  ///
  /// In pt, this message translates to:
  /// **'Sintomatologia'**
  String get guideStep2Title;

  /// No description provided for @guideStep2Desc.
  ///
  /// In pt, this message translates to:
  /// **'Assinale a presença de coceira, dor, sangramento ou crescimento rápido da lesão.'**
  String get guideStep2Desc;

  /// No description provided for @guideStep3Title.
  ///
  /// In pt, this message translates to:
  /// **'Captura de Imagem'**
  String get guideStep3Title;

  /// No description provided for @guideStep3Desc.
  ///
  /// In pt, this message translates to:
  /// **'Tire uma foto macroscópica nítida da lesão. Evite sombras ou reflexos excessivos.'**
  String get guideStep3Desc;

  /// No description provided for @guideStep4Title.
  ///
  /// In pt, this message translates to:
  /// **'Score e Conduta'**
  String get guideStep4Title;

  /// No description provided for @guideStep4Desc.
  ///
  /// In pt, this message translates to:
  /// **'O sistema gerará um nível de prioridade ou laudo diagnóstico. Avalie a conduta recomendada conforme o resultado obtido.'**
  String get guideStep4Desc;
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
