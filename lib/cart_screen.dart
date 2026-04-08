import 'package:flutter/material.dart';
import 'package:tspch/checkout_screen.dart';



class CartScreen extends StatelessWidget {
  final List<Map<String, String>> cartItems;
  final User currentUser;

  CartScreen({required this.cartItems, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    double total = cartItems.fold(
        0, (sum, item) => sum + double.parse(item["price"]!.substring(1)));
    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Expanded(
            child: cartItems.isEmpty
                ? Center(child: Text("Cart is empty"))
                : ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return ListTile(
                    leading: Icon(Icons.memory),
                    title: Text(item["name"]!),
                    subtitle: Text(item["price"]!),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        cartItems.removeAt(index);
                        (context as Element).markNeedsBuild();
                      },
                    ),
                  );
                }),
          ),
          Text("Total: \$${total.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) =>
                          CheckoutScreen(currentUser: currentUser)));
            },
            child: Text("Checkout"),
          )
        ]),
      ),
    );
  }
}
