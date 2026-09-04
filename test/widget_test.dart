import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qampus/home.dart';
import 'package:qampus/login.dart';

void main() {
  testWidgets('Login page smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginPage(),
      ),
    );

    expect(find.text('LOGIN'), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });

  testWidgets('LoginPage - validates empty input and authenticates successfully with correct credentials', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginPage()));

    await tester.tap(find.widgetWithText(ElevatedButton, 'LOGIN'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter both Email and Password!'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'student@qampus.com');
    await tester.enterText(find.byType(TextField).at(1), '123456');
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'LOGIN'));
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Campus Services'), findsOneWidget);
  });

  testWidgets('LibraryPage - renders properly and shows seating, status, and books', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(),
      ),
    );

    // Tap Library service card
    await tester.tap(find.text('Library'));
    await tester.pumpAndSettle();

    // Verify Library Services page opens
    expect(find.text('Library Services'), findsOneWidget);
    expect(find.text('Available Seats'), findsOneWidget);
    expect(find.text('Check Book Availability'), findsOneWidget);
    expect(find.text('Introduction to Algorithms'), findsWidgets);
  });
}
