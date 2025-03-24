import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

enum AuthError { invalidCredentials, network, unknown }

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String get displayName => _authService.currentUser?.displayName ?? 'Claudi';
  bool get isAuthenticated => _authService.currentUser != null;

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
  VoidCallback? onLogout;

  StreamSubscription<User?>? _authSubscription;

  Future<void> signIn() async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      final result = await _authService.signInWithEmailAndPassword(email, password);
      if (result != null) {
        onLoginSuccess?.call();
        Future.microtask(_logAuthSuccess);
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        _error = _mapFirebaseError(e);
      } else {
        _error = AuthError.unknown;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  AuthError _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-email':
      case 'invalid-credential':
        return AuthError.invalidCredentials;
      case 'network-request-failed':
        return AuthError.network;
      default:
        return AuthError.unknown;
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      onLogout?.call();
    } catch (_) {
      _error = AuthError.unknown;
      notifyListeners();
    }
  }

  void initializeAuth() {
    _authService.initAuthStateListener();
    _authSubscription?.cancel();
    _authSubscription = _authService.authStateChanges.listen((User? user) {
      notifyListeners();
    });
  }

  void _logAuthSuccess() {
    // TODO: Logging / Analytics
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _authSubscription?.cancel();
    super.dispose();
  }
}
