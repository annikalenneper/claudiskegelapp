import 'package:uuid/uuid.dart';

class Team {
  final String id;
  final String name;
  final List<String> memberIds;

  Team({
    String? id,
    required this.name,
    required this.memberIds,
  }) : id = id ?? Uuid().v4().toString();

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'memberIds': memberIds,
  };

  factory Team.fromMap(Map<String, dynamic> map) => Team(
    id: map['id'],
    name: map['name'],
    memberIds: List<String>.from(map['memberIds']),
  );
}
