import 'dart:developer';
import 'package:claudiskegelapp/models/appointment_model.dart';
import 'package:claudiskegelapp/models/attendance_model.dart';
import 'package:claudiskegelapp/repositories/appointment_repository.dart';
import 'package:claudiskegelapp/repositories/attendance_repository.dart';
import 'package:flutter/material.dart';

class AppointmentViewModel extends ChangeNotifier {
  final AppointmentRepository _appointmentRepository = AppointmentRepository();
  final AttendanceRepository _attendanceRepository = AttendanceRepository();

  List<Appointment> _appointments = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Status für eingeloggten User pro Termin
  final Map<String, AttendanceStatus> _userAttendancePerAppointment = {};

  List<Appointment> get appointments => _appointments;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AttendanceStatus? getUserAttendance(String appointmentId) {
    return _userAttendancePerAppointment[appointmentId];
  }

  Future<void> initialize(String userId) async {
    await loadAppointments();
    await loadUserAttendanceStatus(userId);
  }

  Future<void> loadAppointments() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _appointments = await _appointmentRepository.fetchAppointments();
    } catch (e) {
      _errorMessage = 'Fehler beim Laden der Termine: $e';
      log(_errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addAppointment(Appointment appointment) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _appointmentRepository.createAppointment(appointment);
      _appointments.add(appointment);
    } catch (e) {
      _errorMessage = 'Fehler beim Hinzufügen des Termins: $e';
      log(_errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteAppointment(String id) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _appointmentRepository.deleteAppointment(id);
      _appointments.removeWhere((element) => element.id == id);
      _userAttendancePerAppointment.remove(id);
    } catch (e) {
      _errorMessage = 'Fehler beim Löschen des Termins: $e';
      log(_errorMessage!);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadUserAttendanceStatus(String userId) async {
    for (final appointment in _appointments) {
      try {
        final status = await _attendanceRepository.getUserAttendanceStatus(appointment.id, userId);
        _userAttendancePerAppointment[appointment.id] = status;
      } catch (e) {
        log('Fehler beim Laden des Status für Termin ${appointment.id}: $e');
        _userAttendancePerAppointment[appointment.id] = AttendanceStatus.pending;
      }
    }
    notifyListeners();
  }

  Future<void> updateUserAttendance(String appointmentId, String userId, AttendanceStatus status) async {
    try {
      await _attendanceRepository.setUserAttendance(appointmentId, userId, status);
      _userAttendancePerAppointment[appointmentId] = status;
      notifyListeners();
    } catch (e) {
      log('Fehler beim Aktualisieren der Teilnahme: $e');
      _errorMessage = 'Fehler beim Aktualisieren der Teilnahme';
      notifyListeners();
    }
  }
}
