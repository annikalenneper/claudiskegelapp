import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

enum AuthError { invalidCredentials, network, unknown }

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final User? _currentUser = FirebaseAuth.instance.currentUser;
  User? get currentUser => _currentUser;
  String get displayName => currentUser?.displayName ?? 'Claudi';
  
  bool get isAuthenticated => currentUser != null;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AuthError? _error;
  AuthError? get error => _error;

  String? get errorMessage {
    switch (_error) {
      case AuthError.invalidCredentials:
        return 'E-Mail oder Passwort ist ungültig';
      case AuthError.network:
        return 'Bitte überprüfe deine Internetverbindung';
      case AuthError.unknown:
      default:
        return 'Ein unbekannter Fehler ist aufgetreten';
    }
  }

  VoidCallback? onLoginSuccess;

  Future<void> signIn() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _authService.signInWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      onLoginSuccess?.call(); // Signal an View
    } catch (e) {
      if (e.toString().contains('wrong-password') || e.toString().contains('user-not-found')) {
        _error = AuthError.invalidCredentials;
      } else if (e.toString().contains('network')) {
        _error = AuthError.network;
      } else {
        _error = AuthError.unknown;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  VoidCallback? onLogout;

  Future<void> signOut() async {
    await _authService.signOut();
    onLogout?.call();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
