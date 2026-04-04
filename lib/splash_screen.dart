import 'package:flutter/material.dart';
import 'dart:async';
import 'package:tspch/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    // Delay for 3 seconds then navigate
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB8E6B8),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.computer, size: 80, color: Colors.green[700]),
                SizedBox(height: 20),
                Text(
                  "TSPCH",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                SizedBox(height: 30),

                // 🔄 Circular Loading Indicator
                CircularProgressIndicator(
                  color: Colors.green[700],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}