/// ============================================================================
/// OFFLINE_PROFILE_FALLBACK — SOLUÇÃO TEMPORÁRIA, MARCADA PARA REMOÇÃO
/// ============================================================================
///
/// ## O problema que isto contorna
///
/// No login, o app precisa descobrir se o usuário é agente ou médico. Ele
/// procura a role no armazenamento local e, não achando, consulta o backend.
/// Hoje essa consulta nunca funciona para contas criadas pelo app, porque:
///
///   1. o cadastro não grava o usuário no backend (`registerInBackend` está
///      comentado em `AuthController.register`); e
///   2. o `baseUrl` do `UserApiRepository` aponta para um IP de rede local,
///      inalcançável fora da LIFE-UFES.
///
/// Resultado: qualquer perda do armazenamento local (reinstalação do app, troca
/// de tablet, limpeza de dados) deixava o usuário travado no login com a
/// mensagem "Usuário não encontrado no banco de dados do Dermalyze", mesmo com
/// a senha correta.
///
/// ## O que este fallback faz
///
/// Quando o perfil não é encontrado nem local nem no servidor, o app pergunta
/// ao próprio usuário o nome e o perfil, e salva localmente.
///
/// ## QUANDO REMOVER
///
/// Assim que o backend estiver em produção, fora de ambiente local — ou seja,
/// quando as duas condições abaixo forem verdadeiras:
///
///   - `UserApiRepository.baseUrl` apontar para um host público/estável
///     (não um IP de LAN); e
///   - o cadastro gravar o usuário no backend, de modo que `getUserByToken`
///     responda para todas as contas.
///
/// ## COMO REMOVER
///
/// Troque [kOfflineProfileFallbackEnabled] para `false` para desligar sem
/// apagar nada, ou faça um grep por `OFFLINE_PROFILE_FALLBACK` e remova os
/// trechos marcados. Os pontos tocados são:
///
///   - `lib/src/features/auth/controller/auth_controller.dart`
///       (lança [MissingUserProfileException] e expõe `completeProfileOffline`)
///   - `lib/src/modules/login/controller/login_controller.dart`
///       (repassa a exceção para a página)
///   - `lib/src/modules/login/pages/login_page.dart`
///       (exibe o diálogo de confirmação de perfil)
///   - chaves `profileFallback*` em `app_pt.arb` / `app_en.arb`
///   - este arquivo
///
/// ## Risco conhecido
///
/// Deixar o usuário escolher o próprio perfil contraria o achado P0 do QA
/// "Cadastro não possui controle de quem pode usar o app". Enquanto este
/// fallback existir, quem tem credencial válida no Firebase pode se declarar
/// médico e abrir o Diagnóstico. É aceitável só porque o acesso ainda depende
/// de uma conta previamente criada, e deve sair antes do uso real em campo.
library;

/// Liga/desliga o fallback offline de perfil.
///
/// Com `false`, o login volta a falhar com a mensagem de usuário não
/// encontrado quando o perfil não está local nem no servidor.
const bool kOfflineProfileFallbackEnabled = true;

/// Sinaliza que o login autenticou no Firebase, mas o app não descobriu o
/// perfil do usuário — nem localmente, nem no backend.
///
/// A sessão do Firebase segue aberta de propósito: a tela de login usa o [uid]
/// para gravar o perfil escolhido. Se o usuário desistir, cabe a ela chamar
/// `AuthController.logout`.
class MissingUserProfileException implements Exception {
  /// UID do Firebase do usuário já autenticado.
  final String uid;

  /// E-mail usado no login, oferecido como sugestão de nome no diálogo.
  final String email;

  const MissingUserProfileException({required this.uid, required this.email});

  @override
  String toString() => 'MissingUserProfileException(uid: $uid)';
}
