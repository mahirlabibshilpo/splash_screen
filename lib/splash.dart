import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'home.dart';



class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigatetohome();
  }

  navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 3500), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(title: 'GFG'),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent.shade100,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/green_environment_logo.png',
                    width: 250,
                  )
                      .animate()
                      .fadeIn(duration: 800.ms)
                      .scale(duration: 800.ms),

                  SizedBox(height: 15),
                  Column(
                    children: [
                      Text(
                        'GO GREEN',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade800,
                        ),
                      ),
                      Text(
                        'Together for a Greener Future',
                        style: TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30),
          CircularProgressIndicator(
            color: Colors.green,
          ),
          SizedBox(height: 30),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}