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
  String get agentAccess => 'Acesso Agente';

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
}
