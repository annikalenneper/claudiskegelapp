enum GameMode { individual, team }

class GameTemplate {
  final String id;
  final String title;
  final String description;
  final int minPlayers;
  final int maxPlayers;
  final String scoringInstructions;
  final GameMode mode;

  const GameTemplate({
    required this.id,
    required this.title,
    required this.description,
    required this.minPlayers,
    required this.maxPlayers,
    required this.scoringInstructions,
    required this.mode,
  });
}
