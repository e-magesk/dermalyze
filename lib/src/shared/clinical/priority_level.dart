import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Níveis de prioridade de atendimento usados pela triagem, pela Análise
/// Assistida e pela Biblioteca. Fonte única de cores e textos de cada nível.
enum PriorityLevel {
  p1(AppColors.p1Malign, AppColors.p1Bg, AppColors.p1Fill),
  p2(AppColors.p2High, AppColors.p2Bg, AppColors.p2Fill),
  p3(AppColors.p3Medium, AppColors.p3Bg, AppColors.p3Fill),
  p4(AppColors.p4Low, AppColors.p4Bg, AppColors.p4Fill),
  p5(AppColors.p5Minimal, AppColors.p5Bg, AppColors.p5Fill);

  /// Cor do texto e dos detalhes sobre fundo claro.
  final Color color;

  /// Fundo claro (badges, chips).
  final Color background;

  /// Fundo de cards com texto branco por cima.
  final Color fill;

  const PriorityLevel(this.color, this.background, this.fill);

  /// Nível a partir do rótulo do modelo de triagem ("P1" a "P5").
  static PriorityLevel? fromCode(String code) {
    switch (code.toUpperCase()) {
      case 'P1':
        return PriorityLevel.p1;
      case 'P2':
        return PriorityLevel.p2;
      case 'P3':
        return PriorityLevel.p3;
      case 'P4':
        return PriorityLevel.p4;
      case 'P5':
        return PriorityLevel.p5;
      default:
        return null;
    }
  }

  /// "P1", "P2"...
  String code(AppLocalizations l10n) {
    switch (this) {
      case PriorityLevel.p1:
        return l10n.triageP1Label;
      case PriorityLevel.p2:
        return l10n.triageP2Label;
      case PriorityLevel.p3:
        return l10n.triageP3Label;
      case PriorityLevel.p4:
        return l10n.triageP4Label;
      case PriorityLevel.p5:
        return l10n.triageP5Label;
    }
  }

  /// "Prioridade Máxima", "Alta Prioridade"...
  String title(AppLocalizations l10n) {
    switch (this) {
      case PriorityLevel.p1:
        return l10n.triageP1Title;
      case PriorityLevel.p2:
        return l10n.triageP2Title;
      case PriorityLevel.p3:
        return l10n.triageP3Title;
      case PriorityLevel.p4:
        return l10n.triageP4Title;
      case PriorityLevel.p5:
        return l10n.triageP5Title;
    }
  }

  /// "P1 · Prioridade Máxima".
  String label(AppLocalizations l10n) => '${code(l10n)} · ${title(l10n)}';

  /// O que o nível significa clinicamente.
  String description(AppLocalizations l10n) {
    switch (this) {
      case PriorityLevel.p1:
        return l10n.triageP1Desc;
      case PriorityLevel.p2:
        return l10n.triageP2Desc;
      case PriorityLevel.p3:
        return l10n.triageP3Desc;
      case PriorityLevel.p4:
        return l10n.triageP4Desc;
      case PriorityLevel.p5:
        return l10n.triageP5Desc;
    }
  }

  /// Conduta recomendada para o nível.
  String conduct(AppLocalizations l10n) {
    switch (this) {
      case PriorityLevel.p1:
        return l10n.triageP1Conduta;
      case PriorityLevel.p2:
        return l10n.triageP2Conduta;
      case PriorityLevel.p3:
        return l10n.triageP3Conduta;
      case PriorityLevel.p4:
        return l10n.triageP4Conduta;
      case PriorityLevel.p5:
        return l10n.triageP5Conduta;
    }
  }
}

/// Prioridade associada a cada classe do modelo da Análise Assistida.
///
/// NEV é tratado como nevo melanocítico (P1), conforme definido pela equipe;
/// pendente de validação médica junto com os textos dessa classe.
PriorityLevel priorityForDiagnosisLabel(String label) {
  switch (label.toUpperCase()) {
    case 'MEL':
    case 'NEV':
      return PriorityLevel.p1;
    case 'BCC':
    case 'SCC':
      return PriorityLevel.p2;
    case 'ACK':
      return PriorityLevel.p3;
    case 'SEK':
      return PriorityLevel.p4;
    default:
      // Classe desconhecida: prioridade média, sem subestimar o risco.
      return PriorityLevel.p3;
  }
}
