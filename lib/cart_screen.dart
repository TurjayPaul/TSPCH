import 'package:flutter/material.dart';
import 'package:tspch/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, String>> cartItems = [
    {"name": "Intel Core i9-13900K", "price": "\$589"},
    {"name": "Corsair 16GB DDR5 RAM", "price": "\$159"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFA8D5BA),
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text("Cart"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(cartItems[index]["name"]!),
                        Text(cartItems[index]["price"]!,
                            style: TextStyle(color: Colors.green[900])),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFDAF0DA), foregroundColor: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Previous"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFDAF0DA), foregroundColor: Colors.black),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CheckoutScreen()));
                  },
                  child: Text("Next"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}