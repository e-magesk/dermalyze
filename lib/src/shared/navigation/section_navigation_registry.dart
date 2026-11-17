/// Seções do app com navegação interna própria.
///
/// A navegação dentro das abas é feita por estado (passo do formulário,
/// subpágina da Biblioteca), não pelo [Navigator]. Como todas as abas ficam
/// montadas ao mesmo tempo dentro do `IndexedStack`, cada tela declara a qual
/// seção pertence, para que a `MainPage` atinja apenas a aba visível.
enum SectionScope { triage, diagnosis, library }

/// O que a `MainPage` precisa de uma tela com navegação interna.
abstract class SectionNavigation {
  /// Volta um passo. Retorna `true` se consumiu o evento; `false` quando já
  /// está no início, deixando o evento seguir para a `MainPage`.
  bool handleBack();

  /// Há algo que se perderia ao voltar ao início (dados preenchidos, foto)?
  bool get hasProgress;

  /// Volta à tela inicial da seção.
  void resetToStart();
}

/// Registro das telas com navegação interna, por seção.
///
/// Usado pela `MainPage` no botão de voltar do sistema (um passo atrás) e ao
/// tocar de novo no ícone da aba atual (volta ao início da seção).
class SectionNavigationRegistry {
  final Map<SectionScope, List<SectionNavigation>> _sections = {};

  void register(SectionScope scope, SectionNavigation section) {
    _sections.putIfAbsent(scope, () => <SectionNavigation>[]).add(section);
  }

  void unregister(SectionScope scope, SectionNavigation section) {
    _sections[scope]?.remove(section);
  }

  List<SectionNavigation> _of(SectionScope scope) =>
      List<SectionNavigation>.of(_sections[scope] ?? const []);

  /// Percorre as telas da seção da mais recente para a mais antiga e para na
  /// primeira que consumir o evento.
  bool handleBack(SectionScope scope) {
    for (final section in _of(scope).reversed) {
      if (section.handleBack()) return true;
    }
    return false;
  }

  bool hasProgress(SectionScope scope) => _of(scope).any((section) => section.hasProgress);

  void resetToStart(SectionScope scope) {
    for (final section in _of(scope)) {
      section.resetToStart();
    }
  }
}
