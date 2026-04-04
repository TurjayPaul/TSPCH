import 'package:flutter/material.dart';
import 'package:tspch/cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB8E6B8),
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text(product["name"]!),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            // 🖼️ Product Image (or fallback icon)
            Container(
              height: 200,
              color: Colors.grey[300],
              child: Center(
                child: product["image"] != null
                    ? Image.asset(
                  product["image"]!,
                  height: 120,
                  fit: BoxFit.contain,
                )
                    : Icon(Icons.computer,
                    size: 80, color: Colors.green[700]),
              ),
            ),

            SizedBox(height: 10),

            // 🏷️ Product Name
            Text(
              product["name"]!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 5),

            // 💰 Price
            Text(
              product["price"]!,
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 10),

            // 📋 Specifications (you can later make this dynamic)
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(12),
              child: Text(
                "Specifications:\n- High performance\n- Latest generation\n- Optimized for gaming & work",
              ),
            ),

            SizedBox(height: 10),

            // 🔌 Compatibility
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(12),
              child: Text(
                "Compatibility:\n- Modern systems\n- Supports latest hardware",
              ),
            ),

            Spacer(),

            // ⬅️➡️ Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDAF0DA),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Previous"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFDAF0DA),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CartScreen()),
                    );
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