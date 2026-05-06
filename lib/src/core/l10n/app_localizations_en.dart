// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Dermalyze';

  @override
  String get appSubtitle => 'PAD-UFES Screening and Diagnosis Software';

  @override
  String get doctorAccess => 'Doctor Access';

  @override
  String get agentAccess => 'AGENT ACCESS';

  @override
  String get doctorBtn => 'DOCTOR';

  @override
  String get agentBtn => 'AGENT';

  @override
  String get emailPlaceholder => 'E-mail';

  @override
  String get passwordPlaceholder => 'Password';

  @override
  String get authBtn => 'Login';

  @override
  String get triageTitle => 'Risk Triage';

  @override
  String get diagnosticTitle => 'Differential Diagnosis';

  @override
  String get msgSuccessLogin => 'Login successful!';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get registerLink => 'Sign up here';

  @override
  String get errorEmptyFields => 'Please fill in all fields.';

  @override
  String get errorInvalidEmail => 'The email format is invalid.';

  @override
  String get errorUserNotFound => 'User not found.';

  @override
  String get errorWrongPassword => 'Incorrect password. Please try again.';

  @override
  String get errorInvalidCredential => 'Invalid email or password.';

  @override
  String get errorTooManyRequests =>
      'Too many attempts. Please try again later.';

  @override
  String get errorUnknown => 'An unexpected error occurred.';

  @override
  String get registerTitle => 'Create Account';

  @override
  String get fullNameLabel => 'Full Name';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get healthAgent => 'Health Agent';

  @override
  String get doctor => 'Doctor';

  @override
  String get userTypeLabel => 'I am a:';

  @override
  String get registerBtn => 'Sign Up';

  @override
  String get alreadyHaveAccount => 'Already have an account? Log in';

  @override
  String get medicalAccess => 'MEDICAL ACCESS';

  @override
  String helloUser(Object userName) {
    return 'Hello, $userName';
  }

  @override
  String get connectedUFES => 'CONNECTED: LIFE-UFES';

  @override
  String get databaseUpdated => 'Database Updated';

  @override
  String get clinicalTriage => 'Clinical Triage';

  @override
  String get triageLevels => 'LEVELS P1 - P5';

  @override
  String get differentialAnalysis => 'Differential Analysis';

  @override
  String get aiDiagnosis => 'AI DIAGNOSIS';

  @override
  String get quickAccess => 'QUICK ACCESS';

  @override
  String get appGuide => 'App Guide';

  @override
  String get instructionsResp => 'Instructions and Responsibilities';

  @override
  String get navHome => 'HOME';

  @override
  String get navTriage => 'TRIAGE';

  @override
  String get navDiagnosis => 'DIAGNOSIS';

  @override
  String get navLibrary => 'LIBRARY';

  @override
  String get navGuide => 'GUIDE';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Languages';

  @override
  String get activeSession => 'Active Session';

  @override
  String get logout => 'LOGOUT';

  @override
  String get portuguese => 'Portuguese';

  @override
  String get english => 'English';

  @override
  String get formStep1Title => 'Basic Data';

  @override
  String get formPatientAge => 'Patient Age';

  @override
  String get formCancerHistory => 'Cancer History';

  @override
  String get formBodyRegion => 'Body Region';

  @override
  String get formStep2Title => 'Lesion Symptoms';

  @override
  String get formSympItch => 'Does it itch?';

  @override
  String get formSympBleed => 'Does it bleed?';

  @override
  String get formSympGrow => 'Has it grown?';

  @override
  String get formSympHurt => 'Does it hurt?';

  @override
  String get formSympChange => 'Has color/shape changed?';

  @override
  String get formSympElevate => 'Is it elevated?';

  @override
  String get formStep3Title => 'Image Capture';

  @override
  String get formBtnNext => 'NEXT';

  @override
  String get formBtnBack => 'BACK';

  @override
  String get formBtnAnalyze => 'ANALYZE NOW';

  @override
  String get formBtnCapture => 'Capture Lesion';

  @override
  String get formOptYes => 'Yes';

  @override
  String get formOptNo => 'No';

  @override
  String get formOptNotSure => 'Not Sure';

  @override
  String get regionFace => 'Face';

  @override
  String get regionNose => 'Nose';

  @override
  String get regionEar => 'Ear';

  @override
  String get regionLips => 'Lips';

  @override
  String get regionScalp => 'Scalp';

  @override
  String get regionNeck => 'Neck';

  @override
  String get regionChest => 'Chest';

  @override
  String get regionAbdomen => 'Abdomen';

  @override
  String get regionDorsum => 'Dorsum (Back)';

  @override
  String get regionShoulder => 'Shoulder';

  @override
  String get regionArm => 'Arm';

  @override
  String get regionForearm => 'Forearm';

  @override
  String get regionHand => 'Hand';

  @override
  String get regionThigh => 'Thigh';

  @override
  String get regionLeg => 'Leg';

  @override
  String get regionFoot => 'Foot';

  @override
  String get regionGenitals => 'Genitals';

  @override
  String get regionGluteus => 'Gluteus';

  @override
  String get regionGroin => 'Groin';

  @override
  String get valImageCheckTitle => 'Verifying Image';

  @override
  String get valImageErrorTitle => 'Invalid Image';

  @override
  String get valImageErrorDesc =>
      'The captured image does not have enough quality or was not recognized as a valid skin lesion. Please try again, ensuring good lighting and focus.';

  @override
  String get triageP1Label => 'P1';

  @override
  String get triageP1Title => 'Maximum Priority';

  @override
  String get triageP1Desc =>
      'The lesion has suspicious features with high indication of malignancy. Requires the highest level of priority.';

  @override
  String get triageP1Conduta =>
      'Immediate referral to a dermatologist or oncologist. Urgent incisional or excisional biopsy is required.';

  @override
  String get triageP2Label => 'P2';

  @override
  String get triageP2Title => 'High Priority';

  @override
  String get triageP2Desc =>
      'The lesion shows signs of a skin tumor or could transform into one. The patient requires a high level of attention.';

  @override
  String get triageP2Conduta =>
      'Schedule priority dermatological evaluation (ideally within 15 days). Consider specialized dermoscopy.';

  @override
  String get triageP3Label => 'P3';

  @override
  String get triageP3Title => 'Medium Priority';

  @override
  String get triageP3Desc =>
      'The lesion shows signs of a skin disease requiring clinical treatment, but lacks immediate high-risk oncological features.';

  @override
  String get triageP3Conduta =>
      'Referral for routine outpatient evaluation. Advise on photoprotection and monitoring for changes (ABCDE rule).';

  @override
  String get triageP4Label => 'P4';

  @override
  String get triageP4Title => 'Low Priority';

  @override
  String get triageP4Desc =>
      'The lesion appears to be a benign and simple dermatological issue. Requires low specialized attention.';

  @override
  String get triageP4Conduta =>
      'Clinical management in Primary Care. Routine clinical follow-up, no immediate specialized referral needed.';

  @override
  String get triageP5Label => 'P5';

  @override
  String get triageP5Title => 'Minimum Priority';

  @override
  String get triageP5Desc =>
      'Dermatological condition absent, physiological, or very simple. No priority attention needed.';

  @override
  String get triageP5Conduta =>
      'No surgical intervention required. Advise on general skincare and sun protection.';

  @override
  String get diagMelanomaName => 'Melanoma';

  @override
  String get diagMelanomaDesc =>
      'Malignant neoplasm originating from melanocytes. Characterized by asymmetry, irregular borders, color variation, and aggressive metastatic potential if not treated early.';

  @override
  String get diagMelanomaConduta =>
      'Urgent surgical excision with wide safety margins. Requires complete histopathological examination, oncological staging, and possible sentinel lymph node biopsy (based on Breslow thickness).';

  @override
  String get diagBCCName => 'Basal Cell Carcinoma';

  @override
  String get diagBCCDesc =>
      'The most common skin cancer. Presents slow growth and is locally invasive, but with very low metastatic potential. Often features a pearly appearance, elevated borders, and telangiectasias.';

  @override
  String get diagBCCConduta =>
      'Standard surgical excision (4 to 5 mm margin). In noble areas (face) or aggressive subtypes, consider Mohs Micrographic Surgery. Alternatives: cryotherapy or topical therapies for superficial subtypes.';

  @override
  String get diagSCCName => 'Squamous Cell Carcinoma';

  @override
  String get diagSCCDesc =>
      'The second most common malignant skin neoplasm. Originates in squamous cells. Can present rapid growth, ulcero-vegetative appearance, and has a higher metastatic potential than Basal Cell Carcinoma.';

  @override
  String get diagSCCConduta =>
      'Surgical excision with adequate margins (usually 4 to 6 mm). Requires palpation of regional lymph nodes to rule out dissemination. Rigorous postoperative monitoring.';

  @override
  String get diagAKName => 'Actinic Keratosis';

  @override
  String get diagAKDesc =>
      'Pre-cancerous lesion caused by chronic sun exposure. Characterized by erythematous plaques or papules with a rough, scaly surface (sandpaper feel). Can evolve into Squamous Cell Carcinoma.';

  @override
  String get diagAKConduta =>
      'Preventive and field cancerization treatment. Options include cryotherapy (isolated lesions), topical 5-fluorouracil, imiquimod, or photodynamic therapy. Strict advice on photoprotection.';

  @override
  String get diagSKName => 'Seborrheic Keratosis';

  @override
  String get diagSKDesc =>
      'Very common benign epidermal tumor in adults. Presents a warty or \'stuck on\' appearance, with colors ranging from light brown to black. No potential for malignancy.';

  @override
  String get diagSKConduta =>
      'Expectant management (no strictly medical treatment is necessary). Removal only for aesthetic reasons or if the lesion is subject to constant trauma (cryotherapy, curettage, or electrocoagulation).';

  @override
  String get diagNevusName => 'Melanocytic Nevus';

  @override
  String get diagNevusDesc =>
      'Benign and stable pigmented lesion (common mole). Composed of clusters of melanocytes with regular architecture, well-defined borders, and homogeneous coloration.';

  @override
  String get diagNevusConduta =>
      'Routine clinical follow-up. Annual dermoscopic evaluation. Excisional biopsy recommended only if the lesion shows sudden changes (ABCDE Rule) or constant irritation.';

  @override
  String get clinicalDiagnosis => 'Clinical Diagnosis';

  @override
  String get diagnosisSubtitle =>
      'Detailed analysis for the identification of specific pathologies.';

  @override
  String get diagnosisSuggested => 'Suggested Diagnosis:';

  @override
  String get diagnosisNew => 'NEW DIAGNOSIS';

  @override
  String get analysisTryAgain => 'TRY AGAIN';

  @override
  String get analysisLabelConfidence => 'Confidence';

  @override
  String get analysisResultsTitle => 'Analysis Results';

  @override
  String get analysisClinicalFeatures => 'Clinical Features';

  @override
  String get analysisManagementTitle => 'Management and Guidance';

  @override
  String get triageNew => 'New Triage';
}
