import 'dart:developer';

import 'package:claudiskegelapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(AppUser user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toMap());
    } catch (e) {
      log('Fehler beim Speichern des Users: $e');
      rethrow;
    }
  }

  Future<AppUser?> getUser(String id) async {
    try {
      final doc = await _firestore.collection('users').doc(id).get();
      if (!doc.exists) return null;

      final data = doc.data()!;
      return AppUser.fromMap(data);
    } catch (e) {
      log('Fehler beim Laden des Users: $e');
      rethrow;
    }
  }

  Future<List<AppUser>> getAllUsers() async {
    try {
      final snapshot = await _firestore.collection('users').get();
      return snapshot.docs
          .map((doc) => AppUser.fromMap(doc.data()))
          .toList();
    } catch (e) {
      log('Fehler beim Laden aller Users: $e');
      rethrow;
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await _firestore.collection('users').doc(id).delete();
    } catch (e) {
      log('Fehler beim Löschen des Users: $e');
      rethrow;
    }
  }
}
