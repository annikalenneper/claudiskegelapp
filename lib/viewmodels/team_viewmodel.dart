import 'dart:math';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:claudiskegelapp/models/team_model.dart';
import 'package:claudiskegelapp/repositories/team_repository.dart';

class TeamViewModel extends ChangeNotifier {
  final TeamRepository _repository = TeamRepository();

  List<Team> _teams = [];
  bool _isLoading = false;
  String? _error;

  List<Team> get teams => _teams;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadTeams(String gameId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _teams = await _repository.fetchTeams(gameId);
      _error = null;
    } catch (e) {
      _error = 'Fehler beim Laden der Teams: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveTeam(String gameId, Team team) async {
    await _repository.createTeam(gameId, team);
    _teams.add(team);
    notifyListeners();
  }

  Future<void> deleteTeam(String gameId, String teamId) async {
    await _repository.deleteTeam(gameId, teamId);
    _teams.removeWhere((t) => t.id == teamId);
    notifyListeners();
  }

  /// 🔀 Spieler zufällig aufteilen
  List<Team> splitIntoRandomTeams(List<String> participantIds, int numberOfTeams) {
    final random = Random();
    final shuffled = [...participantIds]..shuffle(random);
    final teams = List.generate(numberOfTeams, (i) => <String>[]);

    for (var i = 0; i < shuffled.length; i++) {
      teams[i % numberOfTeams].add(shuffled[i]);
    }

    final uuid = const Uuid();
    return List.generate(numberOfTeams, (i) {
      return Team(
        id: uuid.v4(),
        name: 'Team ${i + 1}',
        memberIds: teams[i],
      );
    });
  }
}
