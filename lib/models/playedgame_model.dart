import 'package:uuid/uuid.dart';

class PlayedGame {
  final String id; 

  final String appointmentId;
  final String gameId;

  final List<String> participantIds;
  final Map<String, int> singleScores;

  final Map<String, int> teamScores;
  final Map<String, List<String>> teams;

  PlayedGame({
    String? id,
    required this.appointmentId,
    required this.gameId,
    required this.participantIds,
    required this.singleScores,
    this.teams = const {},
    this.teamScores = const {},
  }) : id = id ?? Uuid().v4().toString(); 

  Map<String, dynamic> toMap() => {
    'id': id,
    'appointmentId': appointmentId,
    'gameId': gameId,
    'participantIds': participantIds,
    'singleScores': singleScores,
    'teamScores': teamScores,
    'teams': teams,
  };

  factory PlayedGame.fromMap(Map<String, dynamic> map) {
    return PlayedGame(
      id: map['id'] as String?,
      appointmentId: map['appointmentId'] as String? ?? '',
      gameId: map['gameId'] as String? ?? '',
      participantIds: List<String>.from(map['participantIds'] as List<dynamic>? ?? []),
      singleScores: Map<String, int>.from(map['singleScores'] as Map<dynamic, dynamic>? ?? {}),
      teamScores: Map<String, int>.from(map['teamScores'] as Map<dynamic, dynamic>? ?? {}),
      teams: (map['teams'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          key,
          List<String>.from(value as List<dynamic>? ?? []),
        ),
      ) ?? const {},
    );
  }
}
