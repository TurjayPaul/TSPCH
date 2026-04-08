import 'package:flutter/material.dart';
import 'package:tspch/user_model.dart';

class ProfileScreen extends StatelessWidget {
  final User currentUser;

  ProfileScreen({required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade200, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person, size: 40),
                ),
              ),
              SizedBox(height: 10),

              Center(
                child: Text(
                  currentUser.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              Center(
                child: Text(
                  currentUser.email,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),

              Center(
                child: Text(
                  currentUser.address ?? "Address not provided",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),

              // ✅ ADDED PAYMENT METHOD DISPLAY
              Center(
                child: Text(
                  "Payment: ${currentUser.paymentMethod ?? "Not selected"}",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),

              SizedBox(height: 20),

              Text(
                "Purchased Items",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 10),

              Expanded(
                child: currentUser.purchasedItems.isEmpty
                    ? Center(child: Text("No items purchased yet"))
                    : ListView.builder(
                  itemCount: currentUser.purchasedItems.length,
                  itemBuilder: (context, index) {
                    final item = currentUser.purchasedItems[index];
                    return ListTile(
                      title: Text(item["name"] ?? ""),
                      subtitle: Text(item["price"] ?? ""),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}