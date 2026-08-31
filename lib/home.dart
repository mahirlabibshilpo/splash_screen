import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.all(30),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Logo
            Image.asset(
              'assets/green_environment_logo.png',
              height: 90,
            ),

            const SizedBox(height: 30),

            // Login Title
            const Text(
              'LOGIN',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 30),

            // Email
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),

            const SizedBox(height: 15),

            // Password
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),

            // Forgot Password
            TextButton(
              onPressed: () {},
              child: const Text('Forgot Password?'),
            ),

            const SizedBox(height: 15),

            // Login Button
            ElevatedButton(
              onPressed: () {},
              child: const Text('LOGIN'),
            ),

            const SizedBox(height: 15),

            // Sign Up
            const Text(
              "Don't have an account? Sign Up",
            ),
          ],
        ),
      ),
    );
  }
}