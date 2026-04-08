import 'package:flutter/material.dart';
import 'package:tspch/user_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Map<String, String> product;
  final List<Map<String, String>> cartItems;
  final User currentUser;

  ProductDetailScreen({
    required this.product,
    required this.cartItems,
    required this.currentUser,
  });


  IconData getCategoryIcon(String category) {
    switch (category) {
      case "CPU":
        return Icons.memory;
      case "GPU":
        return Icons.videogame_asset;
      case "RAM":
        return Icons.storage;
      case "Motherboard":
        return Icons.developer_board;
      case "Storage":
        return Icons.sd_storage;
      case "Power Supply":
        return Icons.power;
      case "Cooling":
        return Icons.ac_unit;
      case "Case":
        return Icons.desktop_windows;
      case "Monitor":
        return Icons.monitor;
      default:
        return Icons.devices;
    }
  }


  List<String> getSpecifications(String category) {
    switch (category) {
      case "CPU":
        return [
          "Cores: 8-24",
          "Threads: 16-32",
          "Base Clock: 3.0GHz+",
          "Boost Clock: Up to 5.8GHz"
        ];
      case "GPU":
        return [
          "VRAM: 8GB-24GB",
          "Architecture: Latest Gen",
          "Ray Tracing Support",
          "High FPS Gaming"
        ];
      case "RAM":
        return [
          "Capacity: 8GB-32GB",
          "Type: DDR4 / DDR5",
          "Speed: 3200MHz+",
          "Low Latency"
        ];
      case "Motherboard":
        return [
          "Chipset: Latest Gen",
          "Supports DDR4/DDR5",
          "PCIe 4.0/5.0",
          "Multiple USB Ports"
        ];
      case "Storage":
        return [
          "Type: SSD / HDD",
          "Capacity: 1TB+",
          "Fast Read/Write",
          "Reliable Performance"
        ];
      case "Power Supply":
        return [
          "Wattage: 500W-1000W",
          "80+ Certified",
          "Stable Output",
          "Silent Fan"
        ];
      case "Cooling":
        return [
          "Air / Liquid Cooling",
          "RGB Support",
          "Low Noise",
          "Efficient Heat Dissipation"
        ];
      case "Case":
        return [
          "ATX / Micro-ATX",
          "RGB Lighting",
          "Good Airflow",
          "Tempered Glass"
        ];
      case "Monitor":
        return [
          "Size: 24\"-32\"",
          "Resolution: Full HD / 2K / 4K",
          "Refresh Rate: 75Hz-165Hz",
          "Panel: IPS / VA"
        ];
      default:
        return ["No specifications available"];
    }
  }

  @override
  Widget build(BuildContext context) {
    final specs = getSpecifications(product["category"]!);

    return Scaffold(
      appBar: AppBar(title: Text("Product Details")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: Icon(
                getCategoryIcon(product["category"]!),
                size: 100,
                color: Colors.green,
              ),
            ),

            SizedBox(height: 20),

            Text(
              product["name"]!,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 5),


            Text(
              product["price"]!,
              style: TextStyle(fontSize: 18, color: Colors.green[800]),
            ),

            SizedBox(height: 20),


            Text(
              "Specifications:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),

            SizedBox(height: 10),


            ...specs.map((spec) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text("• $spec"),
            )),

            SizedBox(height: 30),


            Center(
              child: ElevatedButton(
                onPressed: () {
                  cartItems.add(product);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Added to cart")),
                  );

                  currentUser.purchasedItems.add(product);

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding:
                  EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: Text("Add to Cart"),
              ),
            )
          ],
        ),
      ),
    );
  }
}