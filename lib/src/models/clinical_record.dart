enum TripleOption { yes, no, dontKnow }

class ClinicalRecord {
  final int? age;
  final TripleOption? history;
  final String? region;
  final Map<String, TripleOption> symptoms;
  final String? imagePath;

  ClinicalRecord({
    this.age,
    this.history,
    this.region,
    required this.symptoms,
    this.imagePath,
  });
}