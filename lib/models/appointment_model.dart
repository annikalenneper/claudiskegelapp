import 'package:uuid/uuid.dart';



class Appointment {
  late final String id;
  String title; 
  DateTime start;
  String? locationId;
  List<String> attendees; // List of user IDs

  Appointment({
    String? id,
    required this.start,
    String? locationId,
    List<String>? attendees,
    String? title, 
  })  : id = id ?? Uuid().v4().toString(),
        attendees = attendees ?? [],
        title = title ?? 'Kegeltermin';

  Map<String, dynamic> toMap() => {
    'id': id,
    'startTime': start,
    'location': locationId,
    'attendees': attendees,
  };

  factory Appointment.fromMap(Map<String, dynamic> map) => Appointment(
    id: map['id'],
    start: map['startTime'],
    locationId: map['location'],
    attendees: List<String>.from(map['attendees'] ?? []),
  );
}
