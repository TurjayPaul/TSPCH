import 'package:flutter/material.dart';
import 'package:tspch/checkout_screen.dart';
import 'package:tspch/user_model.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, String>> cartItems;
  final User currentUser;

  CartScreen({required this.cartItems, required this.currentUser});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    double total = widget.cartItems.fold(
      0,
          (sum, item) => sum + double.parse(item["price"]!.substring(1)),
    );

    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: widget.cartItems.isEmpty
                  ? Center(child: Text("Cart is empty"))
                  : ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  final item = widget.cartItems[index];
                  return ListTile(
                    leading: Icon(Icons.memory),
                    title: Text(item["name"]!),
                    subtitle: Text(item["price"]!),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          widget.cartItems.removeAt(index);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Text(
              "Total: \$${total.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutScreen(
                      cartItems: widget.cartItems,
                      currentUser: widget.currentUser,
                    ),
                  ),
                );
              },
              child: Text("Checkout"),
            )
          ],
        ),
      ),
    );
  }
}