import 'package:flutter/material.dart';
import 'package:tspch/user_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, String> product;
  final List<Map<String, String>> cartItems;
  final User currentUser;

  ProductDetailScreen(
      {required this.product, required this.cartItems, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Details")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: Icon(Icons.memory, size: 100, color: Colors.green),
          ),
          SizedBox(height: 20),
          Text(product["name"]!,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text(product["price"]!,
              style: TextStyle(fontSize: 18, color: Colors.green[800])),
          SizedBox(height: 20),
          Text("Specifications:", style: TextStyle(fontWeight: FontWeight.bold)),
          Text("- High Performance"),
          Text("- Latest Generation"),
          Text("- Compatible with modern systems"),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              cartItems.add(product);
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Added to cart")));
              currentUser.purchasedItems.add(product);
              Navigator.pop(context);
            },
            child: Text("Add to Cart"),
          )
        ]),
      ),
    );
  }
}