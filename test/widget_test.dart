// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:claudiskegelapp/main.dart';
import 'package:claudiskegelapp/services/auth_service.dart';

void main() {
  testWidgets('App initialization test', (WidgetTester tester) async {
    // Services initialisieren
    final authService = AuthService();
    
    // App mit required services erstellen
    await tester.pumpWidget(KegelApp(
      authService: authService,
    ));

    // Verify that the app loads without crashing
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
