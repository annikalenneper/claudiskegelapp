/// Klasse für gemeinsame Formularvalidierungen
class Validators {
  /// Name-Validierung
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bitte gib deinen Namen ein';
    }
    return null;
  }

  /// Email-Validierung
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bitte gib deine Email-Adresse ein';
    }
    
    // Einfache Email-Validierung
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Bitte gib eine gültige Email-Adresse ein';
    }
    
    return null;
  }

  /// Passwort-Validierung
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Bitte gib ein Passwort ein';
    }
    
    if (value.length < 6) {
      return 'Das Passwort muss mindestens 6 Zeichen lang sein';
    }
    
    return null;
  }

  /// Passwort-Bestätigung-Validierung
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Bitte bestätige dein Passwort';
    }
    
    if (value != password) {
      return 'Die Passwörter stimmen nicht überein';
    }
    
    return null;
  }
  
  // Die Klasse sollte nicht instanziiert werden
  Validators._();
}