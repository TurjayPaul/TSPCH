import 'package:flutter/material.dart';
import 'package:tspch/user_model.dart';

class ProfileScreen extends StatelessWidget {
final User currentUser;

ProfileScreen({required this.currentUser});

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("Profile")),
    body: Padding(
      padding: EdgeInsets.all(20),
      child: Column(children: [
        CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
        SizedBox(height: 10),
        Text(currentUser.name, style: TextStyle(fontSize: 18)),
        Text(currentUser.email),
        SizedBox(height: 20),
        Text("Purchased Items", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Expanded(
            child: currentUser.purchasedItems.isEmpty
                ? Text("No items purchased yet")
                : ListView.builder(
                itemCount: currentUser.purchasedItems.length,
                itemBuilder: (context, index) {
                  final item = currentUser.purchasedItems[index];
                  return ListTile(
                    title: Text(item["name"]!),
                    subtitle: Text(item["price"]!),
                  );
                }))
      ]),
    ),
  );
}
}
