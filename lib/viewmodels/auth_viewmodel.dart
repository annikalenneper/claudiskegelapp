import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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
      // Prepare data off-thread
      final authData = await compute(_prepareAuthData, 
        {'email': emailController.text, 'password': passwordController.text});
      
      // Firebase call must happen on main thread
      final result = await _authService.signInWithEmailAndPassword(
        authData['email'] ?? '',
        authData['password'] ?? ''
      );
      
      // Process result off-thread if needed
      await compute<UserCredential?, void>(_processAuthResult, result);
      
      onLoginSuccess?.call();
      
      // Move non-critical operations off main thread
      Future.microtask(() {
        // Analytics, logging, etc.
        _logAuthSuccess();
      });
    } catch (e) {
      // Error handling
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Static methods to run in isolate
  static Map<String, String> _prepareAuthData(Map<String, String> data) {
    // Any CPU-intensive validation or transformation
    return {'email': data['email']!.trim(), 'password': data['password']!.trim()};
  }

  // Change this function to accept nullable UserCredential
  static void _processAuthResult(UserCredential? result) {
    if (result == null) return;
    // Process result data if needed
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

  Stream<User?> get authStateChanges => _authService.authStateChanges;

  void initAuthListener() {
    _authService.authStateChanges.listen((User? user) {
      // Update internal state
      notifyListeners();
    });
  }
  
  void _logAuthSuccess() {
    // Implement logging logic here
  }
}
