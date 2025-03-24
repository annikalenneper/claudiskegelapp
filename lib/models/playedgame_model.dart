import 'package:claudiskegelapp/models/team_model.dart';
import 'package:uuid/uuid.dart';

class PlayedGame {
  final String id;
  final String templateId;
  final DateTime date;
  final List<String> participantIds;
  final List<Team>? teams; // optional, nur bei Teamspielen
  final Map<String, int> scores; // key = userId ODER teamId → Score
  final String? location;

  PlayedGame({
    String? id,
    required this.templateId,
    required this.date,
    required this.participantIds,
    required this.scores,
    this.teams,
    this.location,
  }) : id = id ?? Uuid().v4().toString();

  Map<String, dynamic> toMap() => {
    'id': id,
    'templateId': templateId,
    'date': date,
    'participantIds': participantIds,
    'scores': scores,
    'location': location,
    'teams': teams?.map((t) => t.toMap()).toList(),
  };

  factory PlayedGame.fromMap(Map<String, dynamic> map) => PlayedGame(
    id: map['id'],
    templateId: map['templateId'],
    date: map['date'],
    participantIds: List<String>.from(map['participantIds'] ?? []),
    scores: Map<String, int>.from(map['scores'] ?? {}),
    location: map['location'],
    teams: map['teams'] != null
        ? List<Map<String, dynamic>>.from(map['teams'])
            .map((t) => Team.fromMap(t))
            .toList()
        : null,
  );
}
