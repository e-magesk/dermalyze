/// Escopos de navegação interna do app.
///
/// A navegação dentro das abas é feita por estado (passo do formulário,
/// subpágina da Biblioteca), não pelo [Navigator]. Como todas as abas ficam
/// montadas ao mesmo tempo dentro do `IndexedStack`, cada tela declara a qual
/// escopo pertence para que o botão de voltar do sistema atinja apenas a aba
/// que está visível.
enum BackScope { triage, diagnosis, library }

/// Retorna `true` quando o handler consumiu o "voltar".
typedef BackHandler = bool Function();

/// Registro dos handlers de "voltar" das telas com navegação por estado.
///
/// Usado pela `MainPage` para descobrir se a aba visível tem um passo anterior
/// antes de trocar de aba ou encerrar o app.
class BackHandlerRegistry {
  final Map<BackScope, List<BackHandler>> _handlers = {};

  void register(BackScope scope, BackHandler handler) {
    _handlers.putIfAbsent(scope, () => <BackHandler>[]).add(handler);
  }

  void unregister(BackScope scope, BackHandler handler) {
    _handlers[scope]?.remove(handler);
  }

  /// Percorre os handlers do escopo do mais recente para o mais antigo e para
  /// no primeiro que consumir o evento.
  bool handleBack(BackScope scope) {
    final handlers = _handlers[scope];
    if (handlers == null || handlers.isEmpty) return false;

    for (final handler in handlers.reversed.toList()) {
      if (handler()) return true;
    }
    return false;
  }
}
