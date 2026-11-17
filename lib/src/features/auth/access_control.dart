/// Controle de acesso dos profissionais.
///
/// Quem pode usar o app é decidido pela equipe do Padtech no Firebase Console,
/// no documento `users/{uid}` do Firestore: `approved` libera o acesso e `role`
/// define se o profissional é agente ou médico. As regras em `firestore.rules`
/// impedem o próprio app de alterar esses dois campos.
library;

/// Valores aceitos no campo `role` do Firestore.
const String kRoleAgent = 'agent';
const String kRoleDoctor = 'doctor';

/// O login funcionou no Firebase Auth, mas o Padtech ainda não liberou (ou
/// revogou) o acesso desse usuário. A sessão já foi encerrada.
class AccessNotGrantedException implements Exception {
  const AccessNotGrantedException();

  @override
  String toString() => 'AccessNotGrantedException';
}

/// O login funcionou, mas a conta não tem perfil no Firestore — típico de
/// contas criadas antes do controle de acesso existir.
///
/// A sessão continua aberta de propósito: a tela de login precisa dela para
/// gravar o perfil. Se o usuário desistir, cabe à tela encerrar a sessão.
class ProfileIncompleteException implements Exception {
  const ProfileIncompleteException();

  @override
  String toString() => 'ProfileIncompleteException';
}

/// Aviso a ser exibido na tela de login depois que a sessão terminou.
enum AccessNotice {
  /// Acesso negado ou revogado pelo Padtech.
  notGranted,

  /// Cadastro enviado, aguardando liberação.
  registered,
}
