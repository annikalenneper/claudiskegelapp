import 'package:flutter/material.dart';
import 'package:claudiskegelapp/models/user_model.dart';
import 'package:claudiskegelapp/repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _repository = UserRepository();
  final Map<String, AppUser> _users = {};
  final Set<String> _activeUserIds = {};

  bool _isLoading = false;
  String? _error;

  List<String> get userIds => _users.keys.toList();
  bool isUserActive(String userId) => _activeUserIds.contains(userId);
  AppUser? getUser(String userId) => _users[userId];
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      final users = await _repository.getAllUsers();
      _users.clear();
      for (var user in users) {
        _users[user.id] = user;
      }
      _error = null;
    } catch (e) {
      _error = 'Fehler beim Laden der Nutzer: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addUser(AppUser user) async {
    await _repository.createUser(user);
    _users[user.id] = user;
    notifyListeners();
  }

  AppUser? getUserById(String id) {
    return _users[id];
  }

  Future<void> deleteUser(String id) async {
    await _repository.deleteUser(id);
    _users.remove(id);
    notifyListeners();
  }
}
