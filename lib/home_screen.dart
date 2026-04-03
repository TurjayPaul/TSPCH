import 'package:flutter/material.dart';
import 'package:tspch/product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  final List<String> categories = [
    "CPU",
    "GPU",
    "RAM",
    "Motherboard",
    "Storage",
    "Power Supply",
    "Cooling",
    "Case"
  ];

  final List<Map<String, String>> products = [
    {"name": "Intel Core i9-13900K", "price": "\$589"},
    {"name": "AMD Ryzen 9 7950X", "price": "\$699"},
    {"name": "NVIDIA RTX 4090", "price": "\$1999"},
    {"name": "AMD RX 7900 XT", "price": "\$999"},
    {"name": "Corsair 16GB DDR5 RAM", "price": "\$159"},
    {"name": "G.Skill 32GB DDR5 RAM", "price": "\$299"},
    {"name": "ASUS ROG Z790 Motherboard", "price": "\$499"},
    {"name": "MSI B650 Motherboard", "price": "\$349"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB8E6B8),
      appBar: AppBar(
        backgroundColor: Colors.green[600],
        title: Text("TSPCH Catalog"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search hardware...",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[300],
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Container(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 6),
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  child: Text(
                    categories[index],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(12),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.memory, size: 45, color: Colors.green[700]),
                      SizedBox(height: 8),
                      Text(
                        products[index]["name"]!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        products[index]["price"]!,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
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
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductDetailScreen()));
                  },
                  child: Text("Next"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
