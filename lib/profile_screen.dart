import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final List<String> orders = ["Intel i9 CPU", "Corsair RAM"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB8E6B8),
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text("Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, size: 50, color: Colors.green[700]),
            ),
            SizedBox(height: 10),
            Text("Shubhasish",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text("Shubhasish636@email.com",
                style: TextStyle(color: Colors.black)),
            SizedBox(height: 20),
            Text("Order History", style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(orders[index]),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFDAF0DA), foregroundColor: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Previous"),
            ),
          ],
        ),
      ),
    );
  }
}