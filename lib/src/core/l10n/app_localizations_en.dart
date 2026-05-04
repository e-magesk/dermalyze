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
  String get dashboard => 'Dashboard';

  @override
  String get medicalAccess => 'MEDICAL ACCESS';

  @override
  String helloUser(Object userName) {
    return 'Hello, $userName';
  }

  @override
  String get connectedHospital => 'CONNECTED: CENTRAL HOSPITAL';

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
}
