import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qampus/home.dart';
import 'package:qampus/login.dart';
import 'package:qampus/main.dart';

void main() {
  testWidgets('App smoke test - verifies MyApp launches and transitions through Splash to LoginPage', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('QAMPUS'), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 4));
    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'LOGIN'), findsOneWidget);
  });

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
}
  });
}
