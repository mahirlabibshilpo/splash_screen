import 'package:flutter/material.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  Future<void> _navigateToLogin() async {
    // 2 second wait, tarpor Login Page e jabe
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon (image er bodole simple icon diyechi, emulator e frame skip hobe na)
            const Icon(
              Icons.school_rounded,
              size: 80,
              color: Colors.white,
            ),

            const SizedBox(height: 20),

            // App Name
            const Text(
              'QAMPUS',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 3,
              ),
            ),

            const SizedBox(height: 8),

            // Tagline
            Text(
              'Smart Access, Better Campus',
              style: TextStyle(
                fontSize: 15,
                color: Colors.green.shade200,
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 50),

            // Loading
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}