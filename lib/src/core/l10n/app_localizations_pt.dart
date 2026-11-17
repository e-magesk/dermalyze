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
  String get appSubtitle => 'Software de Triagem e Análise Assistida PAD-UFES';

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
  String get diagnosticTitle => 'Análise Assistida';

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
  String get clinicalTriage => 'Triagem';

  @override
  String get differentialAnalysis => 'Análise Assistida';

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
  String get navDiagnosis => 'ANÁLISE ASSISTIDA';

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
  String get clinicalDiagnosis => 'Análise Assistida';

  @override
  String get diagnosisNew => 'NOVA ANÁLISE';

  @override
  String get analysisTryAgain => 'TENTAR NOVAMENTE';

  @override
  String get analysisManagementTitle => 'Manejo e Conduta';

  @override
  String get triageNew => 'Nova Triagem';

  @override
  String get libTitle => 'Biblioteca';

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
  String get cropTitle => 'Ajustar Lesão';

  @override
  String get cropHint =>
      'Arraste a imagem e use dois dedos para enquadrar a lesão dentro do quadrado.';

  @override
  String get cropBtnConfirm => 'CONFIRMAR';

  @override
  String get cropBtnCancel => 'CANCELAR';

  @override
  String get cropBtnRotate => 'GIRAR';

  @override
  String get cropProcessing => 'Processando imagem...';

  @override
  String get cropErrorLoad =>
      'Não foi possível abrir a imagem. Tente capturar novamente.';

  @override
  String get exitTitle => 'Sair do Dermalyze?';

  @override
  String get exitMessage =>
      'Você sairá do aplicativo. Os dados já coletados permanecem salvos no dispositivo.';

  @override
  String get btnCancel => 'Cancelar';

  @override
  String get btnExit => 'Sair';

  @override
  String get forgotPasswordLink => 'Esqueci minha senha';

  @override
  String get forgotPasswordTitle => 'Recuperar Senha';

  @override
  String get forgotPasswordSubtitle =>
      'Informe o e-mail cadastrado e enviaremos um link para você criar uma nova senha.';

  @override
  String get forgotPasswordBtn => 'Enviar link de recuperação';

  @override
  String get forgotPasswordBackToLogin => 'Voltar para o login';

  @override
  String get forgotPasswordSentTitle => 'E-mail enviado';

  @override
  String forgotPasswordSentMessage(Object email) {
    return 'Se houver uma conta associada a $email, você receberá um link para redefinir sua senha em alguns minutos. Verifique também a caixa de spam.';
  }

  @override
  String get forgotPasswordEmptyEmail => 'Informe seu e-mail para continuar.';

  @override
  String get triageResultTitle => 'Resultado da Triagem';

  @override
  String get diagnosisResultTitle => 'Hipótese Diagnóstica';

  @override
  String get quickAccessLibraryDesc => 'ABCDE, doenças e metodologia P1–P5';

  @override
  String get accessNotGrantedTitle => 'Acesso não liberado';

  @override
  String get accessNotGrantedMessage =>
      'Seu acesso não está liberado. Entre em contato com a equipe do Padtech para solicitar a liberação.';

  @override
  String get accessRegisteredTitle => 'Cadastro realizado';

  @override
  String get accessRegisteredMessage =>
      'Para usar o app, entre em contato com a equipe do Padtech para solicitar a liberação do seu acesso.';

  @override
  String get btnOk => 'Entendi';

  @override
  String get errorNetwork =>
      'Sem conexão com a internet. Verifique a rede e tente novamente.';

  @override
  String get completeProfileTitle => 'Complete seu cadastro';

  @override
  String get completeProfileMessage =>
      'Sua conta ainda não tem um perfil no Dermalyze. Informe seu nome e perfil para enviar o cadastro à equipe do Padtech.';

  @override
  String get completeProfileConfirm => 'Enviar cadastro';

  @override
  String get restartSectionTitle => 'Voltar ao início?';

  @override
  String get restartSectionMessage =>
      'Os dados preenchidos e o resultado exibido serão descartados.';

  @override
  String get restartSectionConfirm => 'Voltar ao início';

  @override
  String get triageIntro =>
      'Tire uma foto da lesão do paciente para uma classificação rápida da prioridade de atendimento.';

  @override
  String get diagnosisIntro =>
      'Informe os dados clínicos e fotografe a lesão com o dermatoscópio para obter uma hipótese diagnóstica que apoia a sua avaliação.';

  @override
  String get homeTriageDesc => 'Prioridade de atendimento a partir de uma foto';

  @override
  String get homeDiagnosisDesc =>
      'Hipótese diagnóstica com dados clínicos e dermatoscopia';

  @override
  String get photoRequirementsTitle => 'Para a foto ser aceita';

  @override
  String get photoReqMacro1 =>
      'Fotografe de perto, com a lesão no centro ocupando boa parte da imagem.';

  @override
  String get photoReqMacro2 =>
      'Mantenha o aparelho firme: a foto precisa estar nítida.';

  @override
  String get photoReqMacro3 =>
      'Use boa iluminação, sem sombras nem reflexos sobre a lesão.';

  @override
  String get photoReqMacro4 =>
      'Mostre apenas a pele, sem roupas, objetos ou fundo.';

  @override
  String get photoReqDermo1 =>
      'Use o dermatoscópio acoplado ao tablet, em contato com a pele.';

  @override
  String get photoReqDermo2 => 'Centralize a lesão no campo do dermatoscópio.';

  @override
  String get photoReqDermo3 =>
      'Ajuste o foco até as bordas e a pigmentação ficarem nítidas.';

  @override
  String get photoReqDermo4 =>
      'Evite bolhas de ar, reflexos e excesso de pelos sobre a lesão.';

  @override
  String get photoRequirementsFooter =>
      'Fotos que não atendem a esses requisitos são recusadas automaticamente.';

  @override
  String get confidenceTitle => 'Confiança do modelo';

  @override
  String get confidenceTriageDesc =>
      'Mostra o quanto o modelo está seguro desta prioridade, com base na foto. Não indica a chance de a lesão ser maligna. Quanto menor o valor, mais importante é a avaliação clínica.';

  @override
  String get confidenceDiagnosisDesc =>
      'Mostra o quanto o modelo está seguro desta hipótese, com base na foto e nos dados clínicos. Não é uma confirmação diagnóstica. Quanto menor o valor, mais importante é a avaliação clínica.';

  @override
  String get analyzedPhotoTitle => 'Foto analisada';

  @override
  String get priorityShowAll => 'Ver todas as prioridades';

  @override
  String get priorityHideAll => 'Ocultar prioridades';

  @override
  String get libSubtitle =>
      'Material de consulta sobre a regra ABCDE, as principais doenças de pele e a metodologia de triagem.';

  @override
  String get libDiseasesSearchHint => 'Buscar doença pelo nome';

  @override
  String get libDiseasesFilterTitle => 'Filtrar por características';

  @override
  String get libDiseasesClearFilters => 'Limpar filtros';

  @override
  String get libDiseasesNoResults =>
      'Nenhuma doença encontrada com esses critérios.';

  @override
  String get libImageCredits => 'Créditos das imagens';

  @override
  String get libImageCreditsIntro =>
      'Imagens ilustrativas temporárias, com licença aberta.';

  @override
  String get tagAsymmetry => 'Assimetria';

  @override
  String get tagIrregularBorders => 'Bordas irregulares';

  @override
  String get tagMultipleColors => 'Várias cores';

  @override
  String get tagPigmented => 'Pigmentada';

  @override
  String get tagGrowth => 'Crescimento ou mudança';

  @override
  String get tagBleeding => 'Sangramento';

  @override
  String get tagItching => 'Coceira';

  @override
  String get tagScaling => 'Descamação';

  @override
  String get tagRedness => 'Vermelhidão';

  @override
  String get tagRaised => 'Elevação ou nódulo';

  @override
  String get tagNonHealing => 'Ferida que não cicatriza';

  @override
  String get tagSunExposed => 'Área exposta ao sol';

  @override
  String get guideFaqTitle => 'Dúvidas frequentes';

  @override
  String get faqGeneralTitle => 'Gerais';

  @override
  String get faqTriageTitle => 'Triagem';

  @override
  String get faqDiagnosisTitle => 'Análise Assistida';

  @override
  String get faqLibraryTitle => 'Biblioteca';

  @override
  String get faqAccountTitle => 'Acesso e conta';

  @override
  String get faqWhatIsQ => 'O que o Dermalyze faz?';

  @override
  String get faqWhatIsA =>
      'O Dermalyze apoia a avaliação de lesões de pele. A Triagem classifica a prioridade de atendimento a partir de uma foto, e a Análise Assistida, usada por médicos, sugere uma hipótese diagnóstica com base na dermatoscopia e nos dados clínicos. A decisão final é sempre do profissional de saúde.';

  @override
  String get faqOfflineQ => 'O app funciona sem internet?';

  @override
  String get faqOfflineA =>
      'Sim. A Triagem, a Análise Assistida e a Biblioteca funcionam sem internet, porque as análises são feitas no próprio aparelho. A internet só é necessária para entrar na conta, criar uma conta ou recuperar a senha.';

  @override
  String get faqDataQ => 'Os dados do paciente ficam salvos?';

  @override
  String get faqDataA =>
      'Não. As fotos e os dados clínicos ficam apenas no aparelho, durante a análise, e não são enviados para nenhum servidor. O resultado não fica guardado: ao iniciar uma nova análise ou sair da conta, ele é descartado.';

  @override
  String get faqConfidenceQ => 'O que significa a confiança do modelo?';

  @override
  String get faqConfidenceA =>
      'É o quanto o modelo está seguro do resultado, entre as opções que ele reconhece. Não é a chance de a lesão ser maligna nem uma confirmação diagnóstica. Quanto menor a confiança, mais peso deve ter a avaliação clínica.';

  @override
  String get faqTriageHowQ => 'Como usar a Triagem?';

  @override
  String get faqTriageHowA =>
      'Na aba Triagem, toque na área da foto, fotografe a lesão sem dermatoscópio e ajuste o enquadramento. Se a foto for aceita, toque em Analisar agora. O resultado mostra o nível de prioridade e a conduta recomendada.';

  @override
  String get faqPriorityLevelsQ => 'O que significam os níveis P1 a P5?';

  @override
  String get faqPriorityLevelsA =>
      'São níveis de prioridade de atendimento, do mais urgente (P1, prioridade máxima) ao menos urgente (P5, prioridade mínima). A explicação de cada nível está na Biblioteca, em Metodologia e Triagem, e também pode ser aberta na tela de resultado.';

  @override
  String get faqPhotoRejectedQ => 'Por que minha foto foi recusada?';

  @override
  String get faqPhotoRejectedA =>
      'Antes da análise, o app verifica se a foto está nítida e se mostra uma lesão de pele. Fotos desfocadas, escuras, com reflexos ou que não mostram a pele são recusadas. Siga os requisitos exibidos na tela de captura e tente novamente.';

  @override
  String get faqDiagnosisHowQ => 'Como usar a Análise Assistida?';

  @override
  String get faqDiagnosisHowA =>
      'Na aba Análise Assistida, informe a idade, o histórico de câncer de pele, a região da lesão e os sintomas. Em seguida, fotografe a lesão com o dermatoscópio acoplado. O resultado mostra uma hipótese diagnóstica, o nível de prioridade e a conduta sugerida.';

  @override
  String get faqReplacesDiagnosisQ =>
      'A hipótese diagnóstica substitui o diagnóstico médico?';

  @override
  String get faqReplacesDiagnosisA =>
      'Não. A hipótese é um apoio à decisão e não substitui a anamnese, o exame clínico nem a biópsia. O diagnóstico e a conduta são sempre responsabilidade do médico.';

  @override
  String get faqLibraryQ => 'O que encontro na Biblioteca?';

  @override
  String get faqLibraryA =>
      'Material de consulta: a regra ABCDE para avaliar lesões pigmentadas, as principais doenças de pele com busca e filtro por características, e a explicação dos níveis de prioridade P1 a P5.';

  @override
  String get faqPasswordQ => 'Esqueci minha senha. O que faço?';

  @override
  String get faqPasswordA =>
      'Na tela de login, toque em Esqueci minha senha e informe seu e-mail. Você receberá um link para criar uma nova senha.';

  @override
  String get faqAccessQ => 'Meu acesso não foi liberado. O que faço?';

  @override
  String get faqAccessA =>
      'Todo cadastro precisa ser liberado pela equipe do Padtech. Entre em contato com a equipe para solicitar a liberação; depois disso, basta entrar novamente.';

  @override
  String get faqLanguageQ => 'Como troco o idioma do app?';

  @override
  String get faqLanguageA =>
      'Na tela inicial, toque no ícone de engrenagem e escolha o idioma em Configurações.';
}
