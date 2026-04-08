import 'package:flutter/material.dart';
import 'package:tspch/user_model.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Map<String, String>> cartItems;
  final User currentUser;

  CheckoutScreen({required this.cartItems, required this.currentUser});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  /// Calculate total price dynamically
  int get totalPrice {
    int total = 0;
    for (var item in widget.cartItems) {
      // Remove non-numeric characters like $ and parse to int
      String priceStr = item['price']!.replaceAll(RegExp(r'[^\d]'), '');
      total += int.tryParse(priceStr) ?? 0;
    }
    return total;
  }

  /// Confirm purchase, add items to user's purchasedItems, clear cart
  void confirmPurchase() {
    if (widget.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cart is empty!")),
      );
      return;
    }

    // Add cart items to user's purchasedItems
    widget.currentUser.purchasedItems.addAll(widget.cartItems);

    // Clear the cart
    setState(() {
      widget.cartItems.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Purchase successful!")),
    );

    Navigator.pop(context); // Go back to HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB8E6B8), // Splash screen background
      appBar: AppBar(
        title: Text("Checkout"),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body: widget.cartItems.isEmpty
          ? Center(
        child: Text(
          "Your cart is empty",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green[800],
          ),
        ),
      )
          : Column(
        children: [
          // List of cart items
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Card(
                  margin:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.memory, color: Colors.green[700]),
                    title: Text(item['name']!),
                    subtitle: Text(item['price']!),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          widget.cartItems.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),

          // Total and confirm button
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "\$$totalPrice",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: confirmPurchase,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Confirm Purchase",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}