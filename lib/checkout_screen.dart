import 'package:flutter/material.dart';
import 'package:tspch/profile_screen.dart';


class User {
  String name;
  String email;
  List<Map<String, String>> purchasedItems;

  User({required this.name, required this.email}) : purchasedItems = [];
}

class CheckoutScreen extends StatefulWidget {
  final User currentUser;

  CheckoutScreen({required this.currentUser});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int selectedPayment = 1;
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Shipping Address"),
          TextField(
            controller: addressController,
            decoration: InputDecoration(hintText: "Enter address"),
          ),
          SizedBox(height: 20),
          Text("Payment Method"),
          RadioListTile(
            value: 1,
            groupValue: selectedPayment,
            onChanged: (value) {
              setState(() {
                selectedPayment = 1;
              });
            },
            title: Text("Card"),
          ),
          RadioListTile(
            value: 2,
            groupValue: selectedPayment,
            onChanged: (value) {
              setState(() {
                selectedPayment = 2;
              });
            },
            title: Text("Cash on Delivery"),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Order Confirmed!")));
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Text("Confirm Order"),
          )
        ]),
      ),
    );
  }
}