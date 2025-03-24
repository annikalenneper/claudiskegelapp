import 'package:claudiskegelapp/models/game_template_model.dart';

var predefinedGameTemplates = [
  const GameTemplate(
    id: 'classic',
    title: 'Klassisches Spiel',
    description: 'Jede*r spielt 10 Würfe, höchste Punktzahl gewinnt.',
    minPlayers: 2,
    maxPlayers: 8,
    scoringInstructions: 'Addiere die Anzahl der umgeworfenen Kegel.',
    mode: GameMode.individual,
  ),
  const GameTemplate(
    id: 'team_battle',
    title: 'Team Battle',
    description: 'Zwei Teams treten gegeneinander an.',
    minPlayers: 4,
    maxPlayers: 12,
    scoringInstructions: 'Team mit der höchsten Gesamtsumme gewinnt.',
    mode: GameMode.team,
  ),
];
