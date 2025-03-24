// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:claudiskegelapp/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:claudiskegelapp/main.dart';

void main() {
  testWidgets('App initialization test', (WidgetTester tester) async {
    
    // App mit required services erstellen
    final authViewModel = AuthViewModel(); // Create an instance of AuthViewModel
    await tester.pumpWidget(KegelApp(authViewModel: authViewModel,
    ));

    // Verify that the app loads without crashing
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
