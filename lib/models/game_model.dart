
class GameTemplate {
  final String id;
  final String title;
  final String goal;
  final String imageUrl;
  final List<String> scoringInstructions;
  final List<String> example;
  final bool teamGame;

  const GameTemplate({
    required this.id,
    required this.title,
    required this.goal,
    this.imageUrl = '',
    required this.scoringInstructions,
    required this.example,
    required this.teamGame,
  });
}
