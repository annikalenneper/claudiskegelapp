import 'package:uuid/uuid.dart';

enum AttendanceStatus { accepted, declined, pending }

class Appointment {
  final String id;
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final List<String> attendees;

  Appointment({
    String? id,
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.attendees,
  }) : id = id ?? Uuid().v4().toString();

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'startTime': startTime,
    'endTime': endTime,
    'location': location,
    'attendees': attendees,
  };

  factory Appointment.fromMap(Map<String, dynamic> map) => Appointment(
    id: map['id'],
    title: map['title'],
    startTime: map['startTime'],
    endTime: map['endTime'],
    location: map['location'],
    attendees: List<String>.from(map['attendees'] ?? []),
  );
}
