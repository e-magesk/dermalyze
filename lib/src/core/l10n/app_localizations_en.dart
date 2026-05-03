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
  String get agentAccess => 'Agent Access';

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
}
