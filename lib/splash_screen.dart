import 'package:flutter/material.dart';
import 'package:tspch/login_screen.dart';   // ADD THIS

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB8E6B8), // light/medium green
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
                      color: Colors.green[800]),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFDAF0DA), // light green
                foregroundColor: Colors.black, // black text
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              child: Text("Next"),
            ),
          ),
        ],
      ),
    );
  }
}