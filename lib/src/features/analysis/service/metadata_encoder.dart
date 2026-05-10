import 'dart:typed_data';
import 'package:dermalyze/src/models/clinical_record.dart'; 

class MetadataEncoder {
  // A lista exata do seu arquivo Python (96 colunas)
  static const List<String> columns = [
    "age", "gender_F", "gender_UNK", "gender_M", "motherDescendancy_AFRICA",
    "motherDescendancy_GERMANY", "motherDescendancy_BELGIUM", "motherDescendancy_BRAZIL",
    "motherDescendancy_SPAIN", "motherDescendancy_FRANCE", "motherDescendancy_NETHERLANDS",
    "motherDescendancy_UNK", "motherDescendancy_INDIGENOUS", "motherDescendancy_ITALY",
    "motherDescendancy_NORWAY", "motherDescendancy_POLAND", "motherDescendancy_POMERANIA",
    "motherDescendancy_PORTUGAL", "motherDescendancy_SWITZERLAND", "motherDescendancy_TURKEY",
    "fatherDescendancy_AFRICA", "fatherDescendancy_GERMANY", "fatherDescendancy_BELGIUM",
    "fatherDescendancy_BRAZIL", "fatherDescendancy_DENMARK", "fatherDescendancy_SPAIN",
    "fatherDescendancy_FRANCE", "fatherDescendancy_NETHERLANDS", "fatherDescendancy_UNK",
    "fatherDescendancy_INDIGENOUS", "fatherDescendancy_ISRAEL", "fatherDescendancy_ITALY",
    "fatherDescendancy_POLAND", "fatherDescendancy_POMERANIA", "fatherDescendancy_PORTUGAL",
    "fatherDescendancy_CZECH REPUBLIC", "fatherDescendancy_SWITZERLAND", "fatherDescendancy_TURKEY",
    "hasPipedWater_False", "hasPipedWater_UNK", "hasPipedWater_True", "hasSewer_False",
    "hasSewer_UNK", "hasSewer_True", "useCigarette_False", "useCigarette_UNK",
    "useCigarette_True", "useAlcohol_False", "useAlcohol_UNK", "useAlcohol_True",
    "usePesticide_False", "usePesticide_UNK", "usePesticide_True", "fitzpatrickSkinType_1.0",
    "fitzpatrickSkinType_2.0", "fitzpatrickSkinType_3.0", "fitzpatrickSkinType_4.0",
    "fitzpatrickSkinType_5.0", "fitzpatrickSkinType_6.0", "fitzpatrickSkinType_UNK",
    "familySkinCancerHistory_False", "familySkinCancerHistory_UNK", "familySkinCancerHistory_True",
    "familyCancerHistory_False", "familyCancerHistory_UNK", "familyCancerHistory_True",
    "macroBodyRegion_ABDOMEN", "macroBodyRegion_FOREARM", "macroBodyRegion_ARM",
    "macroBodyRegion_SCALP", "macroBodyRegion_THIGH", "macroBodyRegion_BACK",
    "macroBodyRegion_FACE", "macroBodyRegion_UNK", "macroBodyRegion_LIPS",
    "macroBodyRegion_HAND", "macroBodyRegion_NOSE", "macroBodyRegion_EAR",
    "macroBodyRegion_FOOT", "macroBodyRegion_CHEST", "macroBodyRegion_LEG",
    "macroBodyRegion_NECK", "hasGrown_False", "hasGrown_UNK", "hasGrown_True",
    "hasItched_False", "hasItched_UNK", "hasItched_True", "hasBled_False",
    "hasBled_UNK", "hasBled_True", "hasHurt_False", "hasHurt_UNK", "hasHurt_True",
    "hasChanged_False", "hasChanged_UNK", "hasChanged_True", "hasElevation_False",
    "hasElevation_UNK", "hasElevation_True"
  ];

  static Float32List encode(ClinicalRecord record) {
    // Inicializa o vetor com zeros
    var vec = Float32List(columns.length);

    void setColumn(String colName, double value) {
      int index = columns.indexOf(colName);
      if (index != -1) vec[index] = value;
    }

    String getSuffix(TripleOption? opt) {
      if (opt == TripleOption.yes) return "True";
      if (opt == TripleOption.no) return "False";
      return "UNK"; // Considera UNK se for "não sei" ou nulo
    }

    // 1. Idade
    if (record.age != null) {
      setColumn("age", record.age!.toDouble());
    }

    // 2. Histórico de Câncer Familiar
    setColumn("familyCancerHistory_${getSuffix(record.history)}", 1.0);

    // 3. Região (ex: record.region = "FACE" -> "macroBodyRegion_FACE")
    if (record.region != null) {
      setColumn("macroBodyRegion_${record.region!.toUpperCase()}", 1.0);
    } else {
      setColumn("macroBodyRegion_UNK", 1.0);
    }

    // 4. Sintomas
    // Nosso Map de sintomas do form: itch, bleed, grow, hurt, change, elevate
    setColumn("hasItched_${getSuffix(record.symptoms['itch'])}", 1.0);
    setColumn("hasBled_${getSuffix(record.symptoms['bleed'])}", 1.0);
    setColumn("hasGrown_${getSuffix(record.symptoms['grow'])}", 1.0);
    setColumn("hasHurt_${getSuffix(record.symptoms['hurt'])}", 1.0);
    setColumn("hasChanged_${getSuffix(record.symptoms['change'])}", 1.0);
    setColumn("hasElevation_${getSuffix(record.symptoms['elevate'])}", 1.0);

    return vec;
  }
}