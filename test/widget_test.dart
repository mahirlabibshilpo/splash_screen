import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qampus/main.dart';
import 'package:qampus/login.dart';
import 'package:qampus/home.dart';

void main() {
  testWidgets('App smoke test - verifies MyApp launches and transitions through Splash to LoginPage', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('QAMPUS'), findsOneWidget);

    // Fast-forward past the splash screen timer
    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'LOGIN'), findsOneWidget);
  });

  testWidgets('LoginPage - validates empty input and authenticates successfully with correct credentials', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    // Tap LOGIN button with empty fields
    await tester.tap(find.widgetWithText(ElevatedButton, 'LOGIN'));
    await tester.pumpAndSettle();

    // Verify error snackbar appears
    expect(find.text('Please enter both Email and Password!'), findsOneWidget);

    // Enter valid credentials
    await tester.enterText(find.byType(TextField).at(0), 'student@qampus.com');
    await tester.enterText(find.byType(TextField).at(1), '123456');
    await tester.pumpAndSettle();

    // Tap LOGIN
    await tester.tap(find.widgetWithText(ElevatedButton, 'LOGIN'));
    await tester.pumpAndSettle();

    // Verify HomePage is displayed
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Campus Services'), findsOneWidget);
  });
}
