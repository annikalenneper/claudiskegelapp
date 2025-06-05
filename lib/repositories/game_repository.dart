import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/playedgame_model.dart';

class GameRepository {
  final FirebaseFirestore _firestore;

  GameRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // Collection reference
  CollectionReference get _gamesCollection =>
      _firestore.collection('games');

  // Create a new game
  Future<void> createGame(PlayedGame game) async {
    try {
      await _gamesCollection.doc(game.id).set(game.toMap());
    } catch (e) {
      throw Exception('Failed to create game: $e');
    }
  }

  // Read a game by ID
  Future<PlayedGame?> getGameById(String id) async {
    try {
      final doc = await _gamesCollection.doc(id).get();
      if (doc.exists) {
        return PlayedGame.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch game: $e');
    }
  }

  // Update an existing game
  Future<void> updateGame(PlayedGame game) async {
    try {
      await _gamesCollection.doc(game.id).update(game.toMap());
    } catch (e) {
      throw Exception('Failed to update game: $e');
    }
  }

  // Delete a game by ID
  Future<void> deleteGame(String id) async {
    try {
      await _gamesCollection.doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete game: $e');
    }
  }

  // Fetch all games
  Future<List<PlayedGame>> getAllGames() async {
    try {
      final querySnapshot = await _gamesCollection.get();
      return querySnapshot.docs
          .map((doc) => PlayedGame.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch games: $e');
    }
  }
}