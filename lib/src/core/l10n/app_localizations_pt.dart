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
      'O nosso sistema detectou que a imagem capturada não apresenta características claras de uma lesão de pele. Por favor, tente novamente com melhor iluminação e foco.';

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
      'Neoplasia maligna originada nos melanócitos. Apresenta alto potencial de metástase se não tratada precocemente. Caracteriza-se por assimetria, bordas irregulares e variação de cores.';

  @override
  String get diagMelanomaConduta =>
      'Excisão cirúrgica de urgência com margens amplas de segurança. Necessário exame histopatológico completo, estadiamento oncológico e possível pesquisa de linfonodo sentinela (conforme índice de Breslow).';

  @override
  String get diagBCCName => 'Carcinoma Basocelular';

  @override
  String get diagBCCDesc =>
      'Câncer de pele mais comum. Crescimento lento, localmente invasivo, mas com baixíssimo potencial de metástase. Frequentemente apresenta aspecto perláceo e telangiectasias.';

  @override
  String get diagBCCConduta =>
      'Excisão cirúrgica padrão (margem de 4 a 5 mm). Em áreas nobres (face) ou subtipos agressivos, considerar Cirurgia Micrográfica de Mohs. Alternativas: crioterapia ou terapias tópicas para subtipos superficiais.';

  @override
  String get diagSCCName => 'Carcinoma Espinocelular';

  @override
  String get diagSCCDesc =>
      'Segundo tipo mais comum. Origina-se nas células escamosas da epiderme. Pode apresentar crescimento rápido e possui potencial de metástase maior que o CBC.';

  @override
  String get diagSCCConduta =>
      'Excisão cirúrgica com margens adequadas (geralmente 4 a 6 mm). Requer palpação de linfonodos regionais para descartar disseminação. Monitoramento rigoroso pós-operatório.';

  @override
  String get diagAKName => 'Ceratose actínica';

  @override
  String get diagAKDesc =>
      'Lesão pré-cancerosa causada pela exposição solar crônica. Caracteriza-se por superfície áspera e descamativa. Pode evoluir para carcinoma espinocelular.';

  @override
  String get diagAKConduta =>
      'Tratamento preventivo e de campo de cancerização. Opções incluem crioterapia (lesões isoladas), 5-fluorouracil, imiquimode tópicos, ou terapia fotodinâmica. Aconselhamento rigoroso sobre fotoproteção.';

  @override
  String get diagSKName => 'Ceratose Seborreica';

  @override
  String get diagSKDesc =>
      'Tumor benigno epidérmico muito comum. Aspecto verrucoso ou \'colado\' na pele, com cores variando de bronze a preto. Sem potencial maligno.';

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

  @override
  String get syncStatusUpdated => 'Base de dados atualizada';

  @override
  String syncStatusPending(int count) {
    return 'Aguardando conexão para enviar $count dados...';
  }

  @override
  String get libTitle => 'Biblioteca Técnica';

  @override
  String get libHeroTitle => 'Conhecimento';

  @override
  String get libHeroSubtitle => 'Central de Apoio PAD-UFES';

  @override
  String get libMenuAbcdeTitle => 'ABCDE do Câncer';

  @override
  String get libMenuAbcdeDesc => 'Manual Visual de Risco';

  @override
  String get libMenuDiseasesTitle => 'Principais Doenças';

  @override
  String get libMenuDiseasesDesc => 'Enciclopédia Dermatológica';

  @override
  String get libMenuTriageTitle => 'Metodologia e Triagem';

  @override
  String get libMenuTriageDesc => 'Como os casos são agrupados';

  @override
  String get libAbcdeHeroTitle => 'O que é a regra do ABCDE?';

  @override
  String get libAbcdeHeroDesc1 =>
      'A regra do ABCDE é uma metodologia clínica padronizada mundialmente para auxiliar na detecção precoce do câncer de pele, especificamente o Melanoma.';

  @override
  String get libAbcdeHeroDesc2 =>
      'Ela serve como um guia prático para profissionais da saúde e pacientes avaliarem características morfológicas de lesões pigmentadas.';

  @override
  String get libAbcdeCriteria => 'Critérios de Avaliação';

  @override
  String get libAbcdeBenign => 'Benigno';

  @override
  String get libAbcdeMalign => 'Suspeito';

  @override
  String get libDiseasesHeroTitle => 'Patologias Analisadas';

  @override
  String get libDiseasesHeroDesc1 =>
      'Nesta seção, apresentamos as principais doenças dermatológicas que são retratadas e classificadas pelo sistema.';

  @override
  String get libDiseasesHeroDesc2 =>
      'O Nível de Prioridade indica o grau de urgência clínica associado àquela condição.';

  @override
  String get libDiseasesEncyclopedia => 'Enciclopédia Clínica';

  @override
  String get libTriageHeroTitle => 'Metodologia P1-P5';

  @override
  String get libTriageHeroSubtitle => 'Lógica de agrupamento e gravidade';

  @override
  String get libTriageHeroDesc =>
      'Nosso sistema utiliza uma hierarquia de gravidade dividida em 5 níveis.';

  @override
  String get libAbcdeLetterA => 'A';

  @override
  String get libAbcdeTitleA => 'Assimetria';

  @override
  String get libAbcdeDescA => 'Metades desiguais.';

  @override
  String get libAbcdeBenignA => 'Simétrico';

  @override
  String get libAbcdeMalignA => 'Assimétrico';

  @override
  String get libAbcdeLetterB => 'B';

  @override
  String get libAbcdeTitleB => 'Bordas';

  @override
  String get libAbcdeDescB => 'Irregulares ou serrilhadas.';

  @override
  String get libAbcdeBenignB => 'Regulares';

  @override
  String get libAbcdeMalignB => 'Irregulares';

  @override
  String get libAbcdeLetterC => 'C';

  @override
  String get libAbcdeTitleC => 'Cores';

  @override
  String get libAbcdeDescC => 'Múltiplos tons presentes.';

  @override
  String get libAbcdeBenignC => 'Cor Única';

  @override
  String get libAbcdeMalignC => 'Várias Cores';

  @override
  String get libAbcdeLetterD => 'D';

  @override
  String get libAbcdeTitleD => 'Diâmetro';

  @override
  String get libAbcdeDescD => 'Extensão maior que 6mm.';

  @override
  String get libAbcdeBenignD => '< 6mm';

  @override
  String get libAbcdeMalignD => '> 6mm';

  @override
  String get libAbcdeLetterE => 'E';

  @override
  String get libAbcdeTitleE => 'Evolução';

  @override
  String get libAbcdeDescE => 'Mudança de forma ou cor.';

  @override
  String get libAbcdeBenignE => 'Estável';

  @override
  String get libAbcdeMalignE => 'Mudando';

  @override
  String get diagLentigoName => 'Lentigo maligno';

  @override
  String get diagLentigoDesc =>
      'Forma de melanoma in situ que ocorre em pele cronicamente exposta ao sol, geralmente em idosos. Evolução lenta com pigmentação irregular.';

  @override
  String get diagNevoD22Name => 'Nevo melanocítico (D22)';

  @override
  String get diagNevoD22Desc =>
      'Nevo com características atípicas ou suspeitas que requerem monitoramento rigoroso devido ao potencial de transformação ou confusão diagnóstica com melanoma.';

  @override
  String get diagBowenName => 'Doença de Bowen';

  @override
  String get diagBowenDesc =>
      'Carcinoma espinocelular in situ. Apresenta-se como placa eritemato-escamosa persistente e bem delimitada.';

  @override
  String get diagKeratoacanthomaName => 'Ceratoacantoma';

  @override
  String get diagKeratoacanthomaDesc =>
      'Nódulo de crescimento rápido com cratera central de queratina. Frequentemente involui, mas é clinicamente difícil de distinguir do CEC.';

  @override
  String get diagCutaneousHornName => 'Corno Cutâneo';

  @override
  String get diagCutaneousHornDesc =>
      'Projeção queratótica cônica. É um diagnóstico morfológico que pode ocultar desde lesões benignas até carcinomas na base.';

  @override
  String get diagEczemaName => 'Eczema';

  @override
  String get diagEczemaDesc =>
      'Condição inflamatória da pele que causa vermelhidão, coceira e descamação. Requer manejo clínico para controle de sintomas e barreira cutânea.';

  @override
  String get diagDermatitisName => 'Dermatite';

  @override
  String get diagDermatitisDesc =>
      'Termo amplo para inflamações cutâneas que podem ser causadas por contato, alergia ou fatores genéticos. Requer diagnóstico etiológico.';

  @override
  String get diagNevusL78Name => 'Nevo (L78)';

  @override
  String get diagNevusL78Desc =>
      'Lesão pigmentada benigna e estável (pinta comum). Composta por aglomerados de melanócitos com arquitetura regular e coloração homogênea.';

  @override
  String get diagAcneName => 'Acne';

  @override
  String get diagAcneDesc =>
      'Condição inflamatória das glândulas pilossebáceas. Apresenta-se como comedões, pápulas ou pústulas. Sem relevância oncológica.';

  @override
  String get diagNoLesionName => 'Ausência de lesão';

  @override
  String get diagNoLesionDesc =>
      'Pele com características de normalidade, sem evidência de patologias dermatológicas no local analisado.';

  @override
  String get guideTitle => 'Guia de Uso';

  @override
  String get guideRespTitle => 'Responsabilidade Profissional';

  @override
  String get guideRespBody =>
      'Este aplicativo é uma ferramenta de suporte à decisão clínica (CAD). A análise realizada pela Inteligência Artificial tem caráter consultivo.';

  @override
  String get guideRespFooter =>
      'A decisão final sobre o diagnóstico, encaminhamento e tratamento permanece, em todos os casos, sob responsabilidade exclusiva do profissional de saúde assistente.';

  @override
  String get guideFlowTitleAgent => 'Fluxo Triagem';

  @override
  String get guideFlowTitleDoctor => 'Fluxo Triagem/Diagnóstico';

  @override
  String get guideStep1Title => 'Dados do Paciente';

  @override
  String get guideStep1Desc =>
      'Insira a idade e o histórico clínico de câncer de pele para contextualizar a análise.';

  @override
  String get guideStep2Title => 'Sintomatologia';

  @override
  String get guideStep2Desc =>
      'Assinale a presença de coceira, dor, sangramento ou crescimento rápido da lesão.';

  @override
  String get guideStep3Title => 'Captura de Imagem';

  @override
  String get guideStep3Desc =>
      'Tire uma foto macroscópica nítida da lesão. Evite sombras ou reflexos excessivos.';

  @override
  String get guideStep4Title => 'Score e Conduta';

  @override
  String get guideStep4Desc =>
      'O sistema gerará um nível de prioridade ou laudo diagnóstico. Avalie a conduta recomendada conforme o resultado obtido.';
}
