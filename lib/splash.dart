import 'package:flutter/material.dart';

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
   // navigatetohome();
  }

  navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 3000), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage(title: 'GFG')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 120,width: 120,color: Colors.lightGreen,),
            Container(
            child: Text(
              'Splash Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
