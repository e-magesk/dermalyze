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
  String get appSubtitle => 'PAD-UFES Screening and Assisted Analysis Software';

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
  String get diagnosticTitle => 'Assisted Analysis';

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
  String get clinicalTriage => 'Triage';

  @override
  String get differentialAnalysis => 'Assisted Analysis';

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
  String get navDiagnosis => 'ASSISTED ANALYSIS';

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
  String get clinicalDiagnosis => 'Assisted Analysis';

  @override
  String get diagnosisNew => 'NEW ANALYSIS';

  @override
  String get analysisTryAgain => 'TRY AGAIN';

  @override
  String get analysisManagementTitle => 'Management and Guidance';

  @override
  String get triageNew => 'New Triage';

  @override
  String get libTitle => 'Library';

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

  @override
  String get guideTitle => 'User Guide';

  @override
  String get guideRespTitle => 'Professional Responsibility';

  @override
  String get guideRespBody =>
      'This app is a clinical decision support (CAD) tool. The analysis performed by Artificial Intelligence is advisory in nature.';

  @override
  String get guideRespFooter =>
      'The final decision on diagnosis, referral, and treatment remains, in all cases, the exclusive responsibility of the attending health professional.';

  @override
  String get cropTitle => 'Adjust Lesion';

  @override
  String get cropHint =>
      'Drag the image and pinch with two fingers to frame the lesion inside the square.';

  @override
  String get cropBtnConfirm => 'CONFIRM';

  @override
  String get cropBtnCancel => 'CANCEL';

  @override
  String get cropBtnRotate => 'ROTATE';

  @override
  String get cropProcessing => 'Processing image...';

  @override
  String get cropErrorLoad =>
      'Could not open the image. Please capture it again.';

  @override
  String get exitTitle => 'Exit Dermalyze?';

  @override
  String get exitMessage =>
      'You will leave the application. Data already collected remains saved on the device.';

  @override
  String get btnCancel => 'Cancel';

  @override
  String get btnExit => 'Exit';

  @override
  String get forgotPasswordLink => 'Forgot my password';

  @override
  String get forgotPasswordTitle => 'Reset Password';

  @override
  String get forgotPasswordSubtitle =>
      'Enter your registered e-mail and we will send you a link to create a new password.';

  @override
  String get forgotPasswordBtn => 'Send reset link';

  @override
  String get forgotPasswordBackToLogin => 'Back to login';

  @override
  String get forgotPasswordSentTitle => 'E-mail sent';

  @override
  String forgotPasswordSentMessage(Object email) {
    return 'If there is an account associated with $email, you will receive a link to reset your password in a few minutes. Please also check your spam folder.';
  }

  @override
  String get forgotPasswordEmptyEmail => 'Enter your e-mail to continue.';

  @override
  String get triageResultTitle => 'Triage Result';

  @override
  String get diagnosisResultTitle => 'Diagnostic Hypothesis';

  @override
  String get quickAccessLibraryDesc => 'ABCDE, diseases and P1–P5 method';

  @override
  String get accessNotGrantedTitle => 'Access not granted';

  @override
  String get accessNotGrantedMessage =>
      'Your access is not granted. Please contact the Padtech team to request access.';

  @override
  String get accessRegisteredTitle => 'Registration complete';

  @override
  String get accessRegisteredMessage =>
      'To use the app, please contact the Padtech team to request access to your account.';

  @override
  String get btnOk => 'Got it';

  @override
  String get errorNetwork =>
      'No internet connection. Check your network and try again.';

  @override
  String get completeProfileTitle => 'Complete your registration';

  @override
  String get completeProfileMessage =>
      'Your account does not have a Dermalyze profile yet. Enter your name and profile to send your registration to the Padtech team.';

  @override
  String get completeProfileConfirm => 'Send registration';

  @override
  String get restartSectionTitle => 'Back to start?';

  @override
  String get restartSectionMessage =>
      'The data entered and the result shown will be discarded.';

  @override
  String get restartSectionConfirm => 'Back to start';

  @override
  String get triageIntro =>
      'Take a photo of the patient\'s lesion for a quick classification of care priority.';

  @override
  String get diagnosisIntro =>
      'Enter the clinical data and photograph the lesion with the dermatoscope to get a diagnostic hypothesis that supports your assessment.';

  @override
  String get homeTriageDesc => 'Care priority from a photo';

  @override
  String get homeDiagnosisDesc =>
      'Diagnostic hypothesis with clinical data and dermoscopy';

  @override
  String get photoRequirementsTitle => 'For the photo to be accepted';

  @override
  String get photoReqMacro1 =>
      'Take the photo up close, with the lesion centered and filling most of the image.';

  @override
  String get photoReqMacro2 =>
      'Hold the device steady: the photo must be sharp.';

  @override
  String get photoReqMacro3 =>
      'Use good lighting, with no shadows or glare on the lesion.';

  @override
  String get photoReqMacro4 =>
      'Show only the skin, with no clothes, objects or background.';

  @override
  String get photoReqDermo1 =>
      'Use the dermatoscope attached to the tablet, in contact with the skin.';

  @override
  String get photoReqDermo2 =>
      'Center the lesion in the dermatoscope\'s field.';

  @override
  String get photoReqDermo3 =>
      'Adjust the focus until the borders and pigmentation are sharp.';

  @override
  String get photoReqDermo4 =>
      'Avoid air bubbles, glare and excess hair over the lesion.';

  @override
  String get photoRequirementsFooter =>
      'Photos that do not meet these requirements are rejected automatically.';

  @override
  String get confidenceTitle => 'Model confidence';

  @override
  String get confidenceTriageDesc =>
      'Shows how sure the model is about this priority, based on the photo. It does not indicate the chance that the lesion is malignant. The lower the value, the more important the clinical assessment.';

  @override
  String get confidenceDiagnosisDesc =>
      'Shows how sure the model is about this hypothesis, based on the photo and the clinical data. It is not a diagnostic confirmation. The lower the value, the more important the clinical assessment.';

  @override
  String get analyzedPhotoTitle => 'Analyzed photo';

  @override
  String get priorityShowAll => 'See all priority levels';

  @override
  String get priorityHideAll => 'Hide priority levels';

  @override
  String get libSubtitle =>
      'Reference material on the ABCDE rule, the main skin diseases and the triage methodology.';

  @override
  String get libDiseasesSearchHint => 'Search disease by name';

  @override
  String get libDiseasesFilterTitle => 'Filter by characteristics';

  @override
  String get libDiseasesClearFilters => 'Clear filters';

  @override
  String get libDiseasesNoResults => 'No disease found with these criteria.';

  @override
  String get libImageCredits => 'Image credits';

  @override
  String get libImageCreditsIntro =>
      'Temporary illustrative images, under open licenses.';

  @override
  String get tagAsymmetry => 'Asymmetry';

  @override
  String get tagIrregularBorders => 'Irregular borders';

  @override
  String get tagMultipleColors => 'Multiple colors';

  @override
  String get tagPigmented => 'Pigmented';

  @override
  String get tagGrowth => 'Growth or change';

  @override
  String get tagBleeding => 'Bleeding';

  @override
  String get tagItching => 'Itching';

  @override
  String get tagScaling => 'Scaling';

  @override
  String get tagRedness => 'Redness';

  @override
  String get tagRaised => 'Raised or nodule';

  @override
  String get tagNonHealing => 'Non-healing sore';

  @override
  String get tagSunExposed => 'Sun-exposed area';

  @override
  String get guideFaqTitle => 'Frequently asked questions';

  @override
  String get faqGeneralTitle => 'General';

  @override
  String get faqTriageTitle => 'Triage';

  @override
  String get faqDiagnosisTitle => 'Assisted Analysis';

  @override
  String get faqLibraryTitle => 'Library';

  @override
  String get faqAccountTitle => 'Access and account';

  @override
  String get faqWhatIsQ => 'What does Dermalyze do?';

  @override
  String get faqWhatIsA =>
      'Dermalyze supports the assessment of skin lesions. Triage classifies care priority from a photo, and Assisted Analysis, used by doctors, suggests a diagnostic hypothesis based on dermoscopy and clinical data. The final decision always belongs to the health professional.';

  @override
  String get faqOfflineQ => 'Does the app work offline?';

  @override
  String get faqOfflineA =>
      'Yes. Triage, Assisted Analysis and the Library work offline, because the analyses run on the device itself. Internet is only needed to sign in, create an account or reset your password.';

  @override
  String get faqDataQ => 'Is patient data saved?';

  @override
  String get faqDataA =>
      'No. Photos and clinical data stay on the device only during the analysis and are not sent to any server. The result is not kept: it is discarded when you start a new analysis or sign out.';

  @override
  String get faqConfidenceQ => 'What does model confidence mean?';

  @override
  String get faqConfidenceA =>
      'It is how sure the model is about the result, among the options it recognizes. It is not the chance that the lesion is malignant, nor a diagnostic confirmation. The lower the confidence, the more weight the clinical assessment should have.';

  @override
  String get faqTriageHowQ => 'How do I use Triage?';

  @override
  String get faqTriageHowA =>
      'In the Triage tab, tap the photo area, photograph the lesion without a dermatoscope and adjust the framing. If the photo is accepted, tap Analyze now. The result shows the priority level and the recommended management.';

  @override
  String get faqPriorityLevelsQ => 'What do levels P1 to P5 mean?';

  @override
  String get faqPriorityLevelsA =>
      'They are care priority levels, from the most urgent (P1, maximum priority) to the least urgent (P5, minimum priority). Each level is explained in the Library, under Methodology and Triage, and can also be opened on the result screen.';

  @override
  String get faqPhotoRejectedQ => 'Why was my photo rejected?';

  @override
  String get faqPhotoRejectedA =>
      'Before the analysis, the app checks whether the photo is sharp and shows a skin lesion. Blurry or dark photos, photos with glare or photos that do not show the skin are rejected. Follow the requirements shown on the capture screen and try again.';

  @override
  String get faqDiagnosisHowQ => 'How do I use Assisted Analysis?';

  @override
  String get faqDiagnosisHowA =>
      'In the Assisted Analysis tab, enter the age, skin cancer history, lesion region and symptoms. Then photograph the lesion with the attached dermatoscope. The result shows a diagnostic hypothesis, the priority level and the suggested management.';

  @override
  String get faqReplacesDiagnosisQ =>
      'Does the diagnostic hypothesis replace the doctor\'s diagnosis?';

  @override
  String get faqReplacesDiagnosisA =>
      'No. The hypothesis is decision support and does not replace the medical history, the clinical examination or the biopsy. Diagnosis and management are always the responsibility of the doctor.';

  @override
  String get faqLibraryQ => 'What is in the Library?';

  @override
  String get faqLibraryA =>
      'Reference material: the ABCDE rule for assessing pigmented lesions, the main skin diseases with search and filtering by characteristics, and the explanation of priority levels P1 to P5.';

  @override
  String get faqPasswordQ => 'I forgot my password. What do I do?';

  @override
  String get faqPasswordA =>
      'On the login screen, tap Forgot my password and enter your e-mail. You will receive a link to create a new password.';

  @override
  String get faqAccessQ => 'My access has not been granted. What do I do?';

  @override
  String get faqAccessA =>
      'Every registration must be approved by the Padtech team. Contact the team to request access; after that, just sign in again.';

  @override
  String get faqLanguageQ => 'How do I change the app language?';

  @override
  String get faqLanguageA =>
      'On the home screen, tap the gear icon and choose the language in Settings.';
}
