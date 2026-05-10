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
  /// **'Neoplasia maligna originada nos melanócitos. Caracteriza-se por assimetria, bordas irregulares, variação de cores e potencial agressivo de metástase se não tratada precocemente.'**
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
  /// **'Câncer de pele mais comum. Apresenta crescimento lento e é localmente invasivo, porém com baixíssimo potencial de metástase. Frequentemente apresenta aspecto perláceo, bordas elevadas e telangiectasias.'**
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
  /// **'Segunda neoplasia maligna cutânea mais comum. Origina-se nas células escamosas. Pode apresentar crescimento rápido, aspecto úlcero-vegetante e possui maior potencial de metástase que o Carcinoma Basocelular.'**
  String get diagSCCDesc;

  /// No description provided for @diagSCCConduta.
  ///
  /// In pt, this message translates to:
  /// **'Excisão cirúrgica com margens adequadas (geralmente 4 a 6 mm). Requer palpação de linfonodos regionais para descartar disseminação. Monitoramento rigoroso pós-operatório.'**
  String get diagSCCConduta;

  /// No description provided for @diagAKName.
  ///
  /// In pt, this message translates to:
  /// **'Ceratose Actínica'**
  String get diagAKName;

  /// No description provided for @diagAKDesc.
  ///
  /// In pt, this message translates to:
  /// **'Lesão pré-cancerosa causada por exposição solar crônica. Caracteriza-se por placas ou pápulas eritematosas, com superfície áspera e descamativa (aspecto de lixa). Pode evoluir para Carcinoma Espinocelular.'**
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
  /// **'Tumor benigno epidérmico muito frequente em adultos. Apresenta aspecto verrucoso ou \'colado\' na pele, com cores variando de castanho claro a preto. Sem potencial de malignização.'**
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
