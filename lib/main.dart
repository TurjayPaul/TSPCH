import 'package:flutter/material.dart';
import 'package:tspch/splash_screen.dart';

void main() {
  runApp(HardwareUIWalkthrough());
}

class HardwareUIWalkthrough extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


//Checking git
