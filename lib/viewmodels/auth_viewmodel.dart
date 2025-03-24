import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

enum AuthError { invalidCredentials, network, unknown }

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  User? _currentUser;
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
    if (_isLoading) return; // Prevent multiple calls
    
    _isLoading = true;
    _error = null;
    notifyListeners(); // Single notification for state changes
    
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
      if (e is FirebaseAuthException) {
        // Map to your error enum
        _error = _mapFirebaseError(e);
      } else {
        _error = AuthError.unknown;
      }
    } finally {
      _isLoading = false;
      notifyListeners(); // Single notification at the end
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
        if (kDebugMode) {
          print('Unmapped Firebase error: ${e.code} - ${e.message}');
        }
        return AuthError.unknown;
    }
  }

  VoidCallback? onLogout;

  Future<void> signOut() async {
    final wasAuthenticated = isAuthenticated;
    
    try {
      await _authService.signOut();
      // No need to set _currentUser = null as the auth listener will handle this
      onLogout?.call();
    } catch (e) {
      // Handle sign out errors
      _error = AuthError.unknown;
      // Only notify if the error matters to UI
      notifyListeners();
    }
    
    // No need for notifyListeners here - the auth listener will handle it
  }

  StreamSubscription<User?>? _authSubscription;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _authSubscription?.cancel();
    super.dispose();
  }

  Stream<User?> get authStateChanges => _authService.authStateChanges;

  void initAuthListener() {
    // Cancel existing subscription if any
    _authSubscription?.cancel();
    
    _authSubscription = _authService.authStateChanges.listen((User? user) {
      // Only notify if user state actually changed
      final userChanged = (_currentUser?.uid != user?.uid);
      _currentUser = user;
      if (userChanged) {
        notifyListeners();
      }
    });
  }
  
  void _logAuthSuccess() {
    // Implement logging logic here
  }

  // Call this in your app initialization
  void initializeAuth() {
    _currentUser = _authService.currentUser;
    initAuthListener();
  }
}
