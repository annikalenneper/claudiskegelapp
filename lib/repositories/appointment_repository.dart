import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:claudiskegelapp/models/appointment_model.dart';

class AppointmentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Appointment>> fetchAppointments() async {
    try {
      final snapshot = await _firestore.collection('appointments').get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Appointment.fromMap(_normalizeAppointmentData(data, doc.id));
      }).toList();
    } catch (e) {
      log('Fehler beim Abrufen der Termine: $e');
      rethrow;
    }
  }

  Future<Appointment?> getAppointment(String id) async {
    try {
      final docSnapshot = await _firestore.collection('appointments').doc(id).get();
      if (!docSnapshot.exists) return null;

      final data = docSnapshot.data()!;
      return Appointment.fromMap(_normalizeAppointmentData(data, docSnapshot.id));
    } catch (e) {
      log('Fehler beim Abrufen des Termins: $e');
      rethrow;
    }
  }

  Future<void> createAppointment(Appointment appointment) async {
    try {
      await _firestore.collection('appointments').doc(appointment.id).set(appointment.toMap());
    } catch (e) {
      log('Fehler beim Erstellen des Termins: $e');
      rethrow;
    }
  }

  Future<void> deleteAppointment(String id) async {
    try {
      await _firestore.collection('appointments').doc(id).delete();
    } catch (e) {
      log('Fehler beim Löschen des Termins: $e');
      rethrow;
    }
  }

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

  Map<String, dynamic> _normalizeAppointmentData(Map<String, dynamic> data, String id) {
    return {
      ...data,
      'id': id,
      'startTime': (data['startTime'] as Timestamp).toDate(),
      'endTime': (data['endTime'] as Timestamp).toDate(),
    };
  }
}
