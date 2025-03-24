/// Zentrale Verwaltung der Routen innerhalb der App
class Routes {
  // Auth-Routen
  static const String root = '/';
  static const String login = '/login';
  
  // Hauptrouten
  static const String main = '/main';
  static const String calendar = '/calendar';
  static const String results = '/results';
  static const String profile = '/profile';
  static const String statistics = '/statistics';
  
  // Funktionsrouten
  static const String addEvent = '/add-event';
  static const String addResult = '/add-result';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';
  
  // User related routes
  static const String userProfile = '/user-profile';
  
  // Die Klasse sollte nicht instanziiert werden
  Routes._();
}