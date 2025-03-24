import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:claudiskegelapp/models/team_model.dart';

class TeamRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createTeam(String gameId, Team team) async {
    try {
      await _firestore
          .collection('played_games')
          .doc(gameId)
          .collection('teams')
          .doc(team.id)
          .set(team.toMap());
    } catch (e) {
      log('Fehler beim Erstellen des Teams: $e');
      rethrow;
    }
  }

  Future<List<Team>> fetchTeams(String gameId) async {
    try {
      final snapshot = await _firestore
          .collection('played_games')
          .doc(gameId)
          .collection('teams')
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Team.fromMap({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      log('Fehler beim Laden der Teams: $e');
      rethrow;
    }
  }

  Future<void> deleteTeam(String gameId, String teamId) async {
    try {
      await _firestore
          .collection('played_games')
          .doc(gameId)
          .collection('teams')
          .doc(teamId)
          .delete();
    } catch (e) {
      log('Fehler beim Löschen des Teams: $e');
      rethrow;
    }
  }
}
