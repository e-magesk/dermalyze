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
      'Our system detected that the captured image does not show clear characteristics of a skin lesion. Please try again with better lighting and focus.';

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
      'Malignant neoplasm originating from melanocytes. High metastatic potential if not treated early. Characterized by asymmetry, irregular borders, and color variation.';

  @override
  String get diagMelanomaConduta =>
      'Urgent surgical excision with wide safety margins. Requires complete histopathological examination, oncological staging, and possible sentinel lymph node biopsy (based on Breslow thickness).';

  @override
  String get diagBCCName => 'Basal Cell Carcinoma';

  @override
  String get diagBCCDesc =>
      'Most common skin cancer. Slow-growing, locally invasive, with very low metastatic potential. Often presents a pearly appearance and telangiectasia.';

  @override
  String get diagBCCConduta =>
      'Standard surgical excision (4 to 5 mm margin). In noble areas (face) or aggressive subtypes, consider Mohs Micrographic Surgery. Alternatives: cryotherapy or topical therapies for superficial subtypes.';

  @override
  String get diagSCCName => 'Squamous Cell Carcinoma';

  @override
  String get diagSCCDesc =>
      'Second most common type. Originates in the squamous cells of the epidermis. Can grow rapidly and has a higher metastatic potential than BCC.';

  @override
  String get diagSCCConduta =>
      'Surgical excision with adequate margins (usually 4 to 6 mm). Requires palpation of regional lymph nodes to rule out dissemination. Rigorous postoperative monitoring.';

  @override
  String get diagAKName => 'Actinic Keratosis';

  @override
  String get diagAKDesc =>
      'Precancerous lesion caused by chronic sun exposure. Characterized by a rough, scaly surface. May progress to squamous cell carcinoma.';

  @override
  String get diagAKConduta =>
      'Preventive and field cancerization treatment. Options include cryotherapy (isolated lesions), topical 5-fluorouracil, imiquimod, or photodynamic therapy. Strict advice on photoprotection.';

  @override
  String get diagSKName => 'Seborrheic Keratosis';

  @override
  String get diagSKDesc =>
      'Very common benign epidermal tumor. Warty or \'stuck-on\' appearance, with colors ranging from tan to black. No malignant potential.';

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

  @override
  String get syncStatusUpdated => 'Database up to date';

  @override
  String syncStatusPending(int count) {
    return 'Waiting for connection to send $count records...';
  }

  @override
  String get libTitle => 'Technical Library';

  @override
  String get libHeroTitle => 'Knowledge';

  @override
  String get libHeroSubtitle => 'PAD-UFES Support Center';

  @override
  String get libMenuAbcdeTitle => 'ABCDE Rule';

  @override
  String get libMenuAbcdeDesc => 'Visual Risk Manual';

  @override
  String get libMenuDiseasesTitle => 'Main Diseases';

  @override
  String get libMenuDiseasesDesc => 'Dermatological Encyclopedia';

  @override
  String get libMenuTriageTitle => 'Methodology & Triage';

  @override
  String get libMenuTriageDesc => 'How cases are grouped';

  @override
  String get libAbcdeHeroTitle => 'What is the ABCDE rule?';

  @override
  String get libAbcdeHeroDesc1 =>
      'The ABCDE rule is a globally standardized clinical methodology to assist in the early detection of skin cancer, specifically Melanoma.';

  @override
  String get libAbcdeHeroDesc2 =>
      'It serves as a practical guide for healthcare professionals and patients to evaluate the morphological characteristics of pigmented lesions.';

  @override
  String get libAbcdeCriteria => 'Evaluation Criteria';

  @override
  String get libAbcdeBenign => 'Benign';

  @override
  String get libAbcdeMalign => 'Suspicious';

  @override
  String get libDiseasesHeroTitle => 'Analyzed Pathologies';

  @override
  String get libDiseasesHeroDesc1 =>
      'In this section, we present the main dermatological diseases that are depicted and classified by the system.';

  @override
  String get libDiseasesHeroDesc2 =>
      'The Priority Level indicates the degree of clinical urgency associated with that condition.';

  @override
  String get libDiseasesEncyclopedia => 'Clinical Encyclopedia';

  @override
  String get libTriageHeroTitle => 'P1-P5 Methodology';

  @override
  String get libTriageHeroSubtitle => 'Grouping and severity logic';

  @override
  String get libTriageHeroDesc =>
      'Our system utilizes a severity hierarchy divided into 5 levels.';

  @override
  String get libAbcdeLetterA => 'A';

  @override
  String get libAbcdeTitleA => 'Asymmetry';

  @override
  String get libAbcdeDescA => 'Unequal halves.';

  @override
  String get libAbcdeBenignA => 'Symmetrical';

  @override
  String get libAbcdeMalignA => 'Asymmetrical';

  @override
  String get libAbcdeLetterB => 'B';

  @override
  String get libAbcdeTitleB => 'Border';

  @override
  String get libAbcdeDescB => 'Irregular or scalloped.';

  @override
  String get libAbcdeBenignB => 'Regular';

  @override
  String get libAbcdeMalignB => 'Irregular';

  @override
  String get libAbcdeLetterC => 'C';

  @override
  String get libAbcdeTitleC => 'Color';

  @override
  String get libAbcdeDescC => 'Multiple shades present.';

  @override
  String get libAbcdeBenignC => 'Single Color';

  @override
  String get libAbcdeMalignC => 'Multiple Colors';

  @override
  String get libAbcdeLetterD => 'D';

  @override
  String get libAbcdeTitleD => 'Diameter';

  @override
  String get libAbcdeDescD => 'Larger than 6mm.';

  @override
  String get libAbcdeBenignD => '< 6mm';

  @override
  String get libAbcdeMalignD => '> 6mm';

  @override
  String get libAbcdeLetterE => 'E';

  @override
  String get libAbcdeTitleE => 'Evolving';

  @override
  String get libAbcdeDescE => 'Change in shape or color.';

  @override
  String get libAbcdeBenignE => 'Stable';

  @override
  String get libAbcdeMalignE => 'Changing';

  @override
  String get diagLentigoName => 'Lentigo maligna';

  @override
  String get diagLentigoDesc =>
      'A form of melanoma in situ occurring on chronically sun-exposed skin, usually in the elderly. Slow evolution with irregular pigmentation.';

  @override
  String get diagNevoD22Name => 'Melanocytic Nevus (D22)';

  @override
  String get diagNevoD22Desc =>
      'Nevus with atypical or suspicious features requiring close monitoring due to potential for transformation or diagnostic confusion with melanoma.';

  @override
  String get diagBowenName => 'Bowen\'s Disease';

  @override
  String get diagBowenDesc =>
      'Squamous cell carcinoma in situ. Presents as a persistent, well-defined erythematous-squamous plaque.';

  @override
  String get diagKeratoacanthomaName => 'Keratoacanthoma';

  @override
  String get diagKeratoacanthomaDesc =>
      'Fast-growing nodule with a central keratin crater. Often involutes, but is clinically difficult to distinguish from SCC.';

  @override
  String get diagCutaneousHornName => 'Cutaneous Horn';

  @override
  String get diagCutaneousHornDesc =>
      'Conical keratotic projection. A morphological diagnosis that can hide anything from benign lesions to carcinomas at the base.';

  @override
  String get diagEczemaName => 'Eczema';

  @override
  String get diagEczemaDesc =>
      'Inflammatory skin condition causing redness, itching, and scaling. Requires clinical management for symptom control and skin barrier repair.';

  @override
  String get diagDermatitisName => 'Dermatitis';

  @override
  String get diagDermatitisDesc =>
      'Broad term for skin inflammations caused by contact, allergy, or genetic factors. Requires etiological diagnosis.';

  @override
  String get diagNevusL78Name => 'Nevus (L78)';

  @override
  String get diagNevusL78Desc =>
      'Stable and benign pigmented lesion (common mole). Composed of melanocyte clusters with regular architecture and homogeneous coloring.';

  @override
  String get diagAcneName => 'Acne';

  @override
  String get diagAcneDesc =>
      'Inflammatory condition of the pilosebaceous glands. Presents as comedones, papules, or pustules. No oncological relevance.';

  @override
  String get diagNoLesionName => 'Absence of lesion';

  @override
  String get diagNoLesionDesc =>
      'Skin with normal characteristics, with no evidence of dermatological pathologies at the analyzed site.';
}
