
enum AttendanceStatus { accepted, declined, pending }

class Attendance {
  final String appointmentId;
  final String userId;
  final AttendanceStatus status;

  Attendance({
    required this.appointmentId,
    required this.userId,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'appointmentId': appointmentId,
      'userId': userId,
      'status': status.name,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      appointmentId: map['appointmentId'],
      userId: map['userId'],
      status: AttendanceStatus.values.firstWhere((e) => e.name == map['status']),
    );
  }
}