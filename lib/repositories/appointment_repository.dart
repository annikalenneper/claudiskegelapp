import 'dart:developer';
import 'package:claudiskegelapp/utils/firestore_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:claudiskegelapp/models/appointment_model.dart';

class AppointmentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Appointment>> fetchAppointments() async {
    try {
      final snapshot = await _firestore.collection('appointments').get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Appointment.fromMap(FirestoreUtils.normalizeData(data, doc.id));
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
      return Appointment.fromMap(FirestoreUtils.normalizeData(data, docSnapshot.id));
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

}
