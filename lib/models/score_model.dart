import 'package:uuid/uuid.dart';

class Score {
  final String id;
  final String playedGameId;
  final String? participantId;
  int score;
  final String? teamId;

  Score({
    String? id,
    required this.playedGameId,
    this.participantId,
    this.score = 0,
    this.teamId,
  }) : id = id ?? Uuid().v4().toString();  
}