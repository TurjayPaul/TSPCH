import 'package:flutter/material.dart';
import 'package:tspch/profile_screen.dart';


class CheckoutScreen extends StatefulWidget {
  final User currentUser;
  final List<Map<String, String>> cartItems;

  CheckoutScreen({required this.currentUser, required this.cartItems});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedPayment = 1; // 1 = Card, 2 = Cash
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double total = widget.cartItems.fold(
        0, (sum, item) => sum + double.tryParse(item['price']!.replaceAll('\$', ''))!);

    return Scaffold(
      appBar: AppBar(title: Text("Checkout"), backgroundColor: Colors.green[400]),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ADDRESS
            Text("Shipping Address", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                hintText: "Enter your address",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            /// PAYMENT METHOD
            Text("Payment Method", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),

            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: selectedPayment,
                  onChanged: (int? value) {
                    setState(() {
                      selectedPayment = value!;
                    });
                  },
                ),
                Text("Card Payment"),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 2,
                  groupValue: selectedPayment,
                  onChanged: (int? value) {
                    setState(() {
                      selectedPayment = value!;
                    });
                  },
                ),
                Text("Cash on Delivery"),
              ],
            ),

            SizedBox(height: 20),

            Text("Total: \$${total.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            Spacer(),

            /// CONFIRM BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green[600]),
                onPressed: () {
                  if (addressController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please enter your address")),
                    );
                    return;
                  }

                  String paymentText =
                  selectedPayment == 1 ? "Card" : "Cash on Delivery";

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Order Confirmed!\nPayment: $paymentText"),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text("Confirm Order"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
