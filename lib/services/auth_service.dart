import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add caching
  User? _cachedUser;

  // Stream for authentication status
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Use cached user when possible
  User? get currentUser {
    _cachedUser ??= _auth.currentUser;
    return _cachedUser;
  }

  // Update cache when auth state changes
  void initAuthStateListener() {
    _auth.authStateChanges().listen((User? user) {
      _cachedUser = user;
    });
  }

  /// Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  /// Logout
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Error signing out: $e');
    }
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  /// Handle Firebase Auth exceptions and convert to user-friendly messages
  Exception _handleFirebaseAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return Exception('User not found. Please check your email.');
      case 'wrong-password':
        return Exception('Wrong password. Please try again.');
      case 'email-already-in-use':
        return Exception('This email address is already in use.');
      case 'weak-password':
        return Exception('The password is too weak. Please choose a stronger password.');
      case 'invalid-email':
        return Exception('The email address is invalid.');
      case 'operation-not-allowed':
        return Exception('Sign-in operation is not allowed. Please contact support.');
      case 'too-many-requests':
        return Exception('Too many requests. Please try again later.');
      default:
        return Exception('An unknown error occurred: ${e.code} - ${e.message}');
    }
  }
}
