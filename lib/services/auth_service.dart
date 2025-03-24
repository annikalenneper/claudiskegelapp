// -------------------- lib/services/auth_service.dart --------------------

import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _cachedUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser {
    _cachedUser ??= _auth.currentUser;
    return _cachedUser;
  }

  void initAuthStateListener() {
    _auth.authStateChanges().listen((User? user) {
      _cachedUser = user;
    });
  }

  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthException(e);
    } catch (e) {
      throw Exception('An unknown error occurred: $e');
    }
  }

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


