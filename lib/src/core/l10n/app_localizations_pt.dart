// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Dermalyze';

  @override
  String get appSubtitle => 'Software de Triagem e Diagnóstico PAD-UFES';

  @override
  String get doctorAccess => 'Acesso Médico';

  @override
  String get agentAccess => 'ACESSO AGENTE';

  @override
  String get doctorBtn => 'MÉDICO';

  @override
  String get agentBtn => 'AGENTE';

  @override
  String get emailPlaceholder => 'E-mail';

  @override
  String get passwordPlaceholder => 'Senha';

  @override
  String get authBtn => 'Login';

  @override
  String get triageTitle => 'Triagem de Risco';

  @override
  String get diagnosticTitle => 'Diagnóstico Diferencial';

  @override
  String get msgSuccessLogin => 'Login realizado com sucesso!';

  @override
  String get noAccount => 'Não possui uma conta?';

  @override
  String get registerLink => 'Cadastre-se aqui';

  @override
  String get errorEmptyFields => 'Por favor, preencha todos os campos.';

  @override
  String get errorInvalidEmail => 'O formato do e-mail é inválido.';

  @override
  String get errorUserNotFound => 'Usuário não cadastrado.';

  @override
  String get errorWrongPassword => 'Senha incorreta. Tente novamente.';

  @override
  String get errorInvalidCredential => 'E-mail ou senha inválidos.';

  @override
  String get errorTooManyRequests => 'Muitas tentativas. Tente mais tarde.';

  @override
  String get errorUnknown => 'Ocorreu um erro inesperado.';

  @override
  String get registerTitle => 'Criar Conta';

  @override
  String get fullNameLabel => 'Nome Completo';

  @override
  String get confirmPasswordLabel => 'Confirmar Senha';

  @override
  String get healthAgent => 'Agente de Saúde';

  @override
  String get doctor => 'Médico(a)';

  @override
  String get userTypeLabel => 'Eu sou:';

  @override
  String get registerBtn => 'Finalizar Cadastro';

  @override
  String get alreadyHaveAccount => 'Já possui uma conta? Faça login';

  @override
  String get medicalAccess => 'ACESSO MÉDICO';

  @override
  String helloUser(Object userName) {
    return 'Olá, $userName';
  }

  @override
  String get connectedUFES => 'CONECTADO: LIFE-UFES';

  @override
  String get databaseUpdated => 'Base de Dados Atualizada';

  @override
  String get clinicalTriage => 'Triagem Clínica';

  @override
  String get triageLevels => 'NÍVEIS P1 - P5';

  @override
  String get differentialAnalysis => 'Análise Diferencial';

  @override
  String get aiDiagnosis => 'DIAGNÓSTICO IA';

  @override
  String get quickAccess => 'ACESSO RÁPIDO';

  @override
  String get appGuide => 'Guia do Aplicativo';

  @override
  String get instructionsResp => 'Instruções e Responsabilidades';

  @override
  String get navHome => 'HOME';

  @override
  String get navTriage => 'TRIAGEM';

  @override
  String get navDiagnosis => 'DIAGNÓSTICO';

  @override
  String get navLibrary => 'BIBLIOTECA';

  @override
  String get navGuide => 'GUIA';

  @override
  String get settings => 'Configurações';

  @override
  String get language => 'Idiomas';

  @override
  String get activeSession => 'Sessão Ativa';

  @override
  String get logout => 'ENCERRAR SESSÃO';

  @override
  String get portuguese => 'Português';

  @override
  String get english => 'Inglês';

  @override
  String get formStep1Title => 'Dados Básicos';

  @override
  String get formPatientAge => 'Idade do Paciente';

  @override
  String get formCancerHistory => 'Histórico de Câncer';

  @override
  String get formBodyRegion => 'Região da Lesão';

  @override
  String get formStep2Title => 'Sintomas da Lesão';

  @override
  String get formSympItch => 'A lesão coça?';

  @override
  String get formSympBleed => 'A lesão sangra?';

  @override
  String get formSympGrow => 'A lesão cresceu?';

  @override
  String get formSympHurt => 'A lesão dói?';

  @override
  String get formSympChange => 'A lesão mudou de cor/forma?';

  @override
  String get formSympElevate => 'A lesão tem elevação?';

  @override
  String get formStep3Title => 'Captura de Imagem';

  @override
  String get formBtnNext => 'PRÓXIMO';

  @override
  String get formBtnBack => 'VOLTAR';

  @override
  String get formBtnAnalyze => 'ANALISAR AGORA';

  @override
  String get formBtnCapture => 'Capturar Lesão';

  @override
  String get formOptYes => 'Sim';

  @override
  String get formOptNo => 'Não';

  @override
  String get formOptNotSure => 'Não Sei';

  @override
  String get regionFace => 'Face';

  @override
  String get regionNose => 'Nariz';

  @override
  String get regionEar => 'Orelha';

  @override
  String get regionLips => 'Lábios';

  @override
  String get regionScalp => 'Couro Cabeludo';

  @override
  String get regionNeck => 'Pescoço';

  @override
  String get regionChest => 'Peitoral';

  @override
  String get regionAbdomen => 'Abdome';

  @override
  String get regionDorsum => 'Dorso';

  @override
  String get regionShoulder => 'Ombro';

  @override
  String get regionArm => 'Braço';

  @override
  String get regionForearm => 'Antebraço';

  @override
  String get regionHand => 'Mão';

  @override
  String get regionThigh => 'Coxa';

  @override
  String get regionLeg => 'Perna';

  @override
  String get regionFoot => 'Pé';

  @override
  String get regionGenitals => 'Genitais';

  @override
  String get regionGluteus => 'Glúteo';

  @override
  String get regionGroin => 'Inguinal (Virilha)';

  @override
  String get valImageCheckTitle => 'Verificando Imagem';

  @override
  String get valImageErrorTitle => 'Imagem Inválida';

  @override
  String get valImageErrorDesc =>
      'A imagem capturada não apresenta qualidade suficiente ou não foi reconhecida como uma lesão de pele válida. Por favor, tente novamente garantindo boa iluminação e foco na lesão.';

  @override
  String get triageP1Label => 'P1';

  @override
  String get triageP1Title => 'Prioridade Máxima';

  @override
  String get triageP1Desc =>
      'A lesão possui características suspeitas com alto indício de malignidade. Necessita da maior prioridade no atendimento.';

  @override
  String get triageP1Conduta =>
      'Encaminhamento imediato para dermatologista ou oncologista. Requer biópsia incisional ou excisional com urgência.';

  @override
  String get triageP2Label => 'P2';

  @override
  String get triageP2Title => 'Alta Prioridade';

  @override
  String get triageP2Desc =>
      'A lesão possui sinais de tumor de pele ou pode se transformar em um no futuro. O paciente requer alto nível de atenção.';

  @override
  String get triageP2Conduta =>
      'Agendar avaliação dermatológica em caráter prioritário (idealmente em até 15 dias). Considerar dermatoscopia especializada.';

  @override
  String get triageP3Label => 'P3';

  @override
  String get triageP3Title => 'Prioridade Média';

  @override
  String get triageP3Desc =>
      'A lesão apresenta sinais de doença de pele que requer tratamento clínico, mas sem características imediatas de alto risco oncológico.';

  @override
  String get triageP3Conduta =>
      'Encaminhamento para avaliação ambulatorial de rotina. Orientar fotoproteção e observação de mudanças (regra ABCDE).';

  @override
  String get triageP4Label => 'P4';

  @override
  String get triageP4Title => 'Baixa Prioridade';

  @override
  String get triageP4Desc =>
      'A lesão aparenta ser um problema dermatológico benigno e simples. Requer baixo nível de atenção especializada.';

  @override
  String get triageP4Conduta =>
      'Manejo clínico na Atenção Primária. Acompanhamento clínico de rotina, sem necessidade de encaminhamento especializado imediato.';

  @override
  String get triageP5Label => 'P5';

  @override
  String get triageP5Title => 'Prioridade Mínima';

  @override
  String get triageP5Desc =>
      'Condição dermatológica ausente, fisiológica ou muito simples. Ausência de necessidade de atenção prioritária.';

  @override
  String get triageP5Conduta =>
      'Nenhuma intervenção cirúrgica necessária. Orientar sobre cuidados gerais com a pele e prevenção solar.';

  @override
  String get diagMelanomaName => 'Melanoma';

  @override
  String get diagMelanomaDesc =>
      'Neoplasia maligna originada nos melanócitos. Caracteriza-se por assimetria, bordas irregulares, variação de cores e potencial agressivo de metástase se não tratada precocemente.';

  @override
  String get diagMelanomaConduta =>
      'Excisão cirúrgica de urgência com margens amplas de segurança. Necessário exame histopatológico completo, estadiamento oncológico e possível pesquisa de linfonodo sentinela (conforme índice de Breslow).';

  @override
  String get diagBCCName => 'Carcinoma Basocelular';

  @override
  String get diagBCCDesc =>
      'Câncer de pele mais comum. Apresenta crescimento lento e é localmente invasivo, porém com baixíssimo potencial de metástase. Frequentemente apresenta aspecto perláceo, bordas elevadas e telangiectasias.';

  @override
  String get diagBCCConduta =>
      'Excisão cirúrgica padrão (margem de 4 a 5 mm). Em áreas nobres (face) ou subtipos agressivos, considerar Cirurgia Micrográfica de Mohs. Alternativas: crioterapia ou terapias tópicas para subtipos superficiais.';

  @override
  String get diagSCCName => 'Carcinoma Espinocelular';

  @override
  String get diagSCCDesc =>
      'Segunda neoplasia maligna cutânea mais comum. Origina-se nas células escamosas. Pode apresentar crescimento rápido, aspecto úlcero-vegetante e possui maior potencial de metástase que o Carcinoma Basocelular.';

  @override
  String get diagSCCConduta =>
      'Excisão cirúrgica com margens adequadas (geralmente 4 a 6 mm). Requer palpação de linfonodos regionais para descartar disseminação. Monitoramento rigoroso pós-operatório.';

  @override
  String get diagAKName => 'Ceratose Actínica';

  @override
  String get diagAKDesc =>
      'Lesão pré-cancerosa causada por exposição solar crônica. Caracteriza-se por placas ou pápulas eritematosas, com superfície áspera e descamativa (aspecto de lixa). Pode evoluir para Carcinoma Espinocelular.';

  @override
  String get diagAKConduta =>
      'Tratamento preventivo e de campo de cancerização. Opções incluem crioterapia (lesões isoladas), 5-fluorouracil, imiquimode tópicos, ou terapia fotodinâmica. Aconselhamento rigoroso sobre fotoproteção.';

  @override
  String get diagSKName => 'Ceratose Seborreica';

  @override
  String get diagSKDesc =>
      'Tumor benigno epidérmico muito frequente em adultos. Apresenta aspecto verrucoso ou \'colado\' na pele, com cores variando de castanho claro a preto. Sem potencial de malignização.';

  @override
  String get diagSKConduta =>
      'Conduta expectante (nenhum tratamento estritamente médico é necessário). Remoção apenas por motivos estéticos ou se a lesão estiver sujeita a trauma constante (crioterapia, curetagem ou eletrocoagulação).';

  @override
  String get diagNevusName => 'Nevo Melanocítico';

  @override
  String get diagNevusDesc =>
      'Lesão pigmentada benigna e estável (pinta comum). Composta por aglomerados de melanócitos com arquitetura regular, bordas bem definidas e coloração homogênea.';

  @override
  String get diagNevusConduta =>
      'Acompanhamento clínico de rotina. Avaliação dermatoscópica anual. Biópsia excisional apenas recomendada se a lesão apresentar mudanças súbitas (Regra ABCDE) ou irritação constante.';

  @override
  String get clinicalDiagnosis => 'Diagnóstico Clínico';

  @override
  String get diagnosisSubtitle =>
      'Análise detalhada para identificação de patologias específicas.';

  @override
  String get diagnosisSuggested => 'Diagnóstico Sugerido:';

  @override
  String get diagnosisNew => 'NOVO DIAGNÓSTICO';

  @override
  String get analysisTryAgain => 'TENTAR NOVAMENTE';

  @override
  String get analysisLabelConfidence => 'Confiança';

  @override
  String get analysisResultsTitle => 'Resultados da Análise';

  @override
  String get analysisClinicalFeatures => 'Características Clínicas';

  @override
  String get analysisManagementTitle => 'Manejo e Conduta';

  @override
  String get triageNew => 'Nova Triagem';
}
