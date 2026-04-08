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

  String paymentMethod = "COD"; // ✅ added

  /// Calculate total price dynamically
  int get totalPrice {
    int total = 0;
    for (var item in widget.cartItems) {
      String priceStr = item['price']!.replaceAll(RegExp(r'[^\d]'), '');
      total += int.tryParse(priceStr) ?? 0;
    }
    return total;
  }

  /// Confirm purchase
  void confirmPurchase() {
    if (widget.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cart is empty!")),
      );
      return;
    }

    widget.currentUser.purchasedItems.addAll(widget.cartItems);

    setState(() {
      widget.cartItems.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Purchase successful via $paymentMethod!")), // ✅ updated
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB8E6B8),
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
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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

                // ✅ Payment Method UI (only addition)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Method",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RadioListTile(
                      title: Text("Cash on Delivery"),
                      value: "COD",
                      groupValue: paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          paymentMethod = value.toString();
                        });
                      },
                    ),
                    RadioListTile(
                      title: Text("Card Payment"),
                      value: "Card",
                      groupValue: paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          paymentMethod = value.toString();
                        });
                      },
                    ),
                  ],
                ),

                SizedBox(height: 10),

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