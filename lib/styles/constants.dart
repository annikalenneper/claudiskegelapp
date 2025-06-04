import 'package:flutter/material.dart';

/// App-weite Konstanten für Farben, Textstile und andere Designelemente
class AppColors {
  // Hauptfarben basierend auf dem Logo
  static const Color primaryColor = Color(0xFF5D2E5B); // Dunkles Lila/Aubergine (Hintergrundfarbe)
  static const Color accentPink = Color(0xFFFF3E96);  // Kräftiges Pink
  static const Color creamBackground = Color(0xFFF7EED6); // Cremefarbener Hintergrund
  static const Color darkPurple = Color(0xFF2C0E2A); // Sehr dunkles Lila für Kontraste
  
  // UI-Hilfsfarben
  static const Color backgroundLight = Color(0xFFFAF3E0); // Hellere Version der Cremefarbene
  static const Color textPrimary = creamBackground; // Hell für Text
  static const Color textSecondary = backgroundLight; // Heller Text
  static const Color accentBlue = Color(0xFF32A9D6); // Türkis/Cyan für Akzente
  static const Color lightPink = Color(0xFFFF6EC7); // Helles Rosa
  static const Color accentYellow = Color(0xFFFFD54F); // Goldgelb
  static const Color lightGrey = Color(0xFFF5F5F5); // Helles Grau
  
  AppColors._();
}


class AppTextStyles {
  static const TextStyle purpleHeading = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24.0,
    color: AppColors.darkPurple,
    letterSpacing: 1.2,
  );
  

  
  // Allgemeine Textstile
  static const TextStyle heading = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24.0,
  );
  
  static const TextStyle subheading = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18.0,
  );
  
  static const TextStyle body = TextStyle(
    fontSize: 16.0,
  );
  
  static const TextStyle buttonText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.2,
    color: Colors.white,
  );
  
  static const TextStyle caption = TextStyle(
    fontSize: 14.0,
  );
}

/// App-weite Dekorationen für Widgets
class AppDecorations {
  static BoxDecoration roundedContainer({
    Color color = Colors.white,
    double opacity = 0.1,
    double borderRadius = 25.0,
    Color? borderColor,
    double borderWidth = 2.0,
  }) {
    return BoxDecoration(
      color: color.withAlpha((opacity * 255).toInt()),
      borderRadius: BorderRadius.circular(borderRadius),
      border: borderColor != null
        ? Border.all(
          color: borderColor.withAlpha((0.5 * 255).toInt()),
          width: borderWidth,
        )
        : null,
    );
  }
  
  static BoxDecoration elevatedContainer({
    Color color = AppColors.primaryColor,
    double borderRadius = 15.0,
    double elevation = 5.0,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha((0.3 * 255).toInt()),
          spreadRadius: 1,
          blurRadius: elevation,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
  
  // Die Klasse sollte nicht instanziiert werden
  AppDecorations._();
}

/// Konstanten für Animationsdauern
class AppAnimations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 350);
  static const Duration slow = Duration(milliseconds: 500);
  
  // Die Klasse sollte nicht instanziiert werden
  AppAnimations._();
}

/// App-weite String-Konstanten
class AppStrings {
  // Login und Registrierung
  static const String appName = "Claudia hat nen Kegelclub";
  static const String login = "LOGIN";
  static const String register = "REGISTRIEREN";
  static const String email = "Email";
  static const String password = "Passwort";
  static const String confirmPassword = "Passwort bestätigen";
  static const String name = "Name";
  static const String forgotPassword = "Passwort vergessen?";
  static const String loginButton = "EINLOGGEN";
  static const String registerButton = "REGISTRIEREN";
  static const String welcome = 'Willkommen';
  static const String loggedIn = 'Du bist jetzt eingeloggt.';
  static const String logout = 'Abmelden';
  
  // Fehlermeldungen
  static const String passwordMismatch = "Passwörter stimmen nicht überein!";
  static const String loginSuccess = "Login erfolgreich!";
  static const String registerSuccess = "Registrierung erfolgreich! Bitte logge dich ein.";
  static const String loginError = "Fehler beim Login: ";
  static const String registerError = "Fehler bei der Registrierung: ";

  // Termine
  static const String events = "Termine";
  static const String addEvent = "Termin hinzufügen";
  
  // Die Klasse sollte nicht instanziiert werden
  AppStrings._();
}