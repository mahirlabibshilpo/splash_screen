import 'package:flutter/material.dart';
import 'package:splash_screen/home.dart';
import 'package:splash_screen/splash.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AnimatedSplashScreen(

        backgroundColor: Colors.lightGreen.shade700,
        splash: Container(
          color: Colors.green.shade700,
          child: Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [

                Container(
                  height: 150,
                  width: 150,
                  color: Colors.lightGreen,
                  child: Center(child: Icon(Icons.energy_savings_leaf_sharp, size: 150,color: Colors.green.shade900,)),
                ),

              ],
            ),
          ),
          ),
        ),

        splashTransition: SplashTransition.fadeTransition,
        nextScreen: MyHomePage(title: 'GFG'),
        centered: true,
      ),
    );
  }
}
