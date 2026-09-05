import 'package:flutter/material.dart';
import 'dashboard.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DashboardPage();
  }
}

// Alias for backwards compatibility if referenced elsewhere
class MyHomePage extends StatelessWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}