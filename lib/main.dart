import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tspch/splash_screen.dart';
import 'package:tspch/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(TSPCH());
}

class TSPCH extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}