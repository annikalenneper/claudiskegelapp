import 'dart:developer';
import 'package:claudiskegelapp/models/playedgame_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PlayedGameRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<PlayedGame>> fetchPlayedGames() async {
    try {
      final snapshot = await _firestore.collection('played_games').get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return PlayedGame.fromMap(_normalizeData(data, doc.id));
      }).toList();
    } catch (e) {
      log('Fehler beim Laden der gespielten Spiele: $e');
      rethrow;
    }
  }

  Future<void> createPlayedGame(PlayedGame game) async {
    try {
      await _firestore.collection('played_games').doc(game.id).set(game.toMap());
    } catch (e) {
      log('Fehler beim Erstellen des Spiels: $e');
      rethrow;
    }
  }

  Future<PlayedGame?> getPlayedGame(String id) async {
    try {
      final doc = await _firestore.collection('played_games').doc(id).get();
      if (!doc.exists) return null;

      final data = doc.data()!;
      return PlayedGame.fromMap(_normalizeData(data, doc.id));
    } catch (e) {
      log('Fehler beim Abrufen des Spiels: $e');
      rethrow;
    }
  }

  Future<void> deletePlayedGame(String id) async {
    try {
      await _firestore.collection('played_games').doc(id).delete();
    } catch (e) {
      log('Fehler beim Löschen des Spiels: $e');
      rethrow;
    }
  }

  /// Hilfsfunktion zur Umwandlung des Firestore-Timestamps
  Map<String, dynamic> _normalizeData(Map<String, dynamic> data, String id) {
    return {
      ...data,
      'id': id,
      'date': (data['date'] as Timestamp).toDate(),
    };
  }
}
