import 'package:flutter/material.dart';
import 'package:tspch/cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB8E6B8),
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text("Product Detail"),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              height: 200,
              color: Colors.grey[300],
              child: Center(
                child: Icon(Icons.computer, size: 80, color: Colors.green[700]),
              ),
            ),
            SizedBox(height: 10),
            Text("Intel Core i9-13900K",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(height: 5),
            Text("\$589",
                style: TextStyle(color: Colors.black, fontSize: 18)),
            SizedBox(height: 10),
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(12),
              child: Text(
                "Specifications:\n- 24 cores\n- 32 threads\n- 3.0 GHz base clock",
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.grey[300],
              padding: EdgeInsets.all(12),
              child: Text(
                "Compatibility:\n- Socket LGA1700\n- DDR5 RAM supported",
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFDAF0DA),
                      foregroundColor: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Previous"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFDAF0DA),
                      foregroundColor: Colors.black),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => CartScreen()));
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