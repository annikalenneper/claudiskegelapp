
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:claudiskegelapp/models/attendance_model.dart';

class AttendanceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> setUserAttendance(String appointmentId, String userId, AttendanceStatus status) async {
    try {
      final attendeeRef = _firestore
          .collection('appointments')
          .doc(appointmentId)
          .collection('attendees')
          .doc(userId);

      await attendeeRef.set({'status': status.name}); // "confirmed", "declined", etc.
    } catch (e) {
      log('Fehler beim Setzen der Teilnahme: $e');
      rethrow;
    }
  }

  Future<AttendanceStatus> getUserAttendanceStatus(String appointmentId, String userId) async {
    try {
      final doc = await _firestore
          .collection('appointments')
          .doc(appointmentId)
          .collection('attendees')
          .doc(userId)
          .get();

      if (!doc.exists) return AttendanceStatus.pending;

      final data = doc.data();
      final statusString = data?['status'] as String?;
      if (statusString == null) return AttendanceStatus.pending;

      return AttendanceStatus.values.firstWhere(
        (e) => e.name == statusString,
        orElse: () => AttendanceStatus.pending,
      );
    } catch (e) {
      log('Fehler beim Laden des Teilnahme-Status: $e');
      return AttendanceStatus.pending;
    }
  }
}