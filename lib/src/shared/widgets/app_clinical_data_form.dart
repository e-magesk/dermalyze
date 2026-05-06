import 'dart:io';

import 'package:dermalyze/src/core/l10n/app_localizations.dart';
import 'package:dermalyze/src/models/clinical_record.dart';
import 'package:dermalyze/src/shared/widgets/app_bento_card.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ClinicalDataForm extends StatefulWidget {
  final Function(ClinicalRecord) onSubmit;

  const ClinicalDataForm({super.key, required this.onSubmit});

  @override
  State<ClinicalDataForm> createState() => _ClinicalDataFormState();
}

class _ClinicalDataFormState extends State<ClinicalDataForm> {
  int _currentStep = 0;
  String? _imagePath;

  // Estado do formulário
  int? _age;
  TripleOption? _history;
  String? _selectedRegion;
  final Map<String, TripleOption?> _symptoms = {
    'itch': null,
    'bleed': null,
    'grow': null,
    'hurt': null,
    'change': null,
    'elevate': null,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        if (_currentStep == 0) _buildStep1(l10n),
        if (_currentStep == 1) _buildStep2(l10n),
        if (_currentStep == 2) _buildStep3(l10n),
        
        const SizedBox(height: 24),
        _buildNavigationButtons(l10n),
      ],
    );
  }

  // --- PASSO 1: DADOS BÁSICOS ---
  Widget _buildStep1(AppLocalizations l10n) {
    return BentoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepHeader(l10n.formStep1Title, Icons.person_outline),
          const SizedBox(height: 20),
          
          // Idade
          _buildLabel(l10n.formPatientAge),
          TextField(
            keyboardType: TextInputType.number,
            onChanged: (v) => _age = int.tryParse(v),
            decoration: _inputDecoration("Ex: 45"),
          ),
          
          const SizedBox(height: 20),
          
          // Histórico de Câncer
          _buildLabel(l10n.formCancerHistory),
          _buildTripleToggle(
            current: _history,
            onChanged: (v) => setState(() => _history = v),
            l10n: l10n,
          ),
          
          const SizedBox(height: 20),
          
          // Região (Dropdown)
          _buildLabel(l10n.formBodyRegion),
          DropdownButtonFormField<String>(
            decoration: _inputDecoration("Selecione..."),
            items: _getRegionItems(l10n),
            onChanged: (v) => setState(() => _selectedRegion = v),
          ),
        ],
      ),
    );
  }

  // --- PASSO 2: SINTOMAS (Com as 3 opções) ---
  Widget _buildStep2(AppLocalizations l10n) {
    final symptomKeys = {
      'itch': l10n.formSympItch,
      'bleed': l10n.formSympBleed,
      'grow': l10n.formSympGrow,
      'hurt': l10n.formSympHurt,
      'change': l10n.formSympChange,
      'elevate': l10n.formSympElevate,
    };

    return BentoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepHeader(l10n.formStep2Title, Icons.analytics_outlined),
          const SizedBox(height: 16),
          ...symptomKeys.entries.map((entry) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                _buildTripleToggle(
                  current: _symptoms[entry.key],
                  onChanged: (v) => setState(() => _symptoms[entry.key] = v),
                  l10n: l10n,
                  compact: true,
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  // --- PASSO 3: IMAGEM (Com opção de tirar foto ou escolher da galeria) ---
  Widget _buildStep3(AppLocalizations l10n) {
    return BentoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepHeader(l10n.formStep3Title, Icons.camera_alt_outlined),
          const SizedBox(height: 20),
          
          // Área de Preview ou Placeholder
          GestureDetector(
            onTap: () => _showPickImageOptions(l10n),
            child: Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: _imagePath == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_a_photo_outlined, color: Color(0xFF2563EB), size: 40),
                        const SizedBox(height: 12),
                        Text(
                          l10n.formBtnCapture,
                          style: const TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.file(File(_imagePath!), fit: BoxFit.cover),
                    ),
            ),
          ),
          
          if (_imagePath != null)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: TextButton.icon(
                onPressed: () => _showPickImageOptions(l10n),
                icon: const Icon(Icons.refresh, size: 18),
                label: Text(l10n.formBtnCapture.toUpperCase()),
                style: TextButton.styleFrom(foregroundColor: const Color(0xFF2563EB)),
              ),
            ),
        ],
      ),
    );
  }

  // --- COMPONENTES AUXILIARES ---

  Widget _buildTripleToggle({
    required TripleOption? current,
    required Function(TripleOption) onChanged,
    required AppLocalizations l10n,
    bool compact = false,
  }) {
    return Row(
      children: [
        _toggleBtn(l10n.formOptYes, TripleOption.yes, current == TripleOption.yes, onChanged, compact),
        const SizedBox(width: 8),
        _toggleBtn(l10n.formOptNo, TripleOption.no, current == TripleOption.no, onChanged, compact),
        const SizedBox(width: 8),
        _toggleBtn(l10n.formOptNotSure, TripleOption.dontKnow, current == TripleOption.dontKnow, onChanged, compact),
      ],
    );
  }

  Widget _toggleBtn(String label, TripleOption value, bool isSelected, Function(TripleOption) onTap, bool compact) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(value),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: compact ? 8 : 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF2563EB) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFE2E8F0)),
          ),
          child: Text(
            label.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w900,
              color: isSelected ? Colors.white : const Color(0xFF94A3B8),
            ),
          ),
        ),
      ),
    );
  }

  // Estilização dos inputs para combinar com o monólito
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.all(16),
    );
  }

  Widget _buildStepHeader(String title, IconData icon) {
  return Row(
    children: [
      Icon(icon, color: Color(0xFF2563EB), size: 20),
      const SizedBox(width: 8),
      Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900, // font-black
          color: Color(0xFF1E293B),
        ),
      ),
    ],
  );
}

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 6),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w900,
          color: Color(0xFF94A3B8),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(AppLocalizations l10n) {
    // Validação: Passo 0 exige Idade, Histórico e Região
    bool isStep0Valid = _age != null && _history != null && _selectedRegion != null;
    
    // Validação: Passo 1 exige que todos os sintomas tenham uma resposta (Sim, Não ou Não Sei)
    bool isStep1Valid = !_symptoms.values.contains(null);

    return Row(
      children: [
        // Botão VOLTAR: Só aparece se não estivermos no primeiro passo[cite: 2]
        if (_currentStep > 0)
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _actionButton(
                label: l10n.formBtnBack,
                onPressed: () => setState(() => _currentStep--),
                color: const Color(0xFFF1F5F9), // Slate 100 para botões secundários[cite: 2]
                textColor: const Color(0xFF1E293B), // _slate800
              ),
            ),
          ),

        // Botão PRINCIPAL: Muda o rótulo de "PRÓXIMO" para "ANALISAR" no último passo
        Expanded(
          flex: 2,
          child: _actionButton(
            label: _currentStep < 2 ? l10n.formBtnNext : l10n.formBtnAnalyze,
            onPressed: (_currentStep == 0 && isStep0Valid) || (_currentStep == 1 && isStep1Valid)
                ? () {
                    if (_currentStep < 2) {
                      setState(() => _currentStep++);
                    } else {
                      // Executa o callback final enviando os dados coletados[cite: 1]
                      widget.onSubmit(ClinicalRecord(
                        age: _age,
                        history: _history,
                        region: _selectedRegion,
                        symptoms: Map<String, TripleOption>.from(_symptoms as Map),
                      ));
                    }
                  }
                : null, // Fica desabilitado se a validação falhar[cite: 1]
            color: const Color(0xFF2563EB), // _blue600[cite: 1]
            textColor: const Color(0xFFFFFFFF),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _getRegionItems(AppLocalizations l10n) {
    // Mapeamento das chaves técnicas para as strings traduzidas[cite: 1]
    final Map<String, String> regions = {
      'face': l10n.regionFace,
      'nose': l10n.regionNose,
      'ear': l10n.regionEar,
      'lips': l10n.regionLips,
      'scalp': l10n.regionScalp,
      'neck': l10n.regionNeck,
      'chest': l10n.regionChest,
      'abdomen': l10n.regionAbdomen,
      'back': l10n.regionDorsum,
      'dorsum': l10n.regionDorsum,
      'shoulder': l10n.regionShoulder,
      'arm': l10n.regionArm,
      'forearm': l10n.regionForearm,
      'hand': l10n.regionHand,
      'thigh': l10n.regionThigh,
      'leg': l10n.regionLeg,
      'foot': l10n.regionFoot,
    };

    return regions.entries.map((e) {
      return DropdownMenuItem<String>(
        value: e.key,
        child: Text(
          e.value,
          style: const TextStyle(
            color: Color(0xFF1E293B), // _slate800[cite: 1]
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }).toList();
  }

  Widget _actionButton({
    required String label,
    required VoidCallback? onPressed,
    required Color color,
    required Color textColor,
  }) {
    return SizedBox(
      height: 56, // Altura padrão para garantir uma boa área de toque
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 0, // Design flat seguindo o padrão Bento
          // Define a cor de fundo quando o botão está desabilitado
          disabledBackgroundColor: color.withValues(alpha: 0.2), 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Curvatura acentuada
          ),
        ),
        child: Text(
          label.toUpperCase(), // Texto sempre em caixa alta para botões de ação
          style: const TextStyle(
            fontWeight: FontWeight.w900, // font-black[cite: 1, 2]
            fontSize: 13,
            letterSpacing: 1.2, // Tracking mais espaçado para legibilidade
          ),
        ),
      ),
    );
  }

  // Exibe o seletor (Câmera ou Galeria)
  void _showPickImageOptions(AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Câmera'),
              onTap: () {
                Navigator.pop(context);
                _pickAndCropImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Galeria'),
              onTap: () {
                Navigator.pop(context);
                _pickAndCropImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Fluxo: Pick -> Crop -> Update State
  Future<void> _pickAndCropImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Ajustar Lesão',
            toolbarColor: const Color(0xFF2563EB),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: true,
            aspectRatioPresets: [CropAspectRatioPreset.square],
          ),
          IOSUiSettings(
            title: 'Ajustar Lesão',
            aspectRatioPresets: [CropAspectRatioPreset.square],
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() => _imagePath = croppedFile.path);
      }
    }
  }
}