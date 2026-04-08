import 'package:flutter/material.dart';
import 'package:tspch/user_model.dart';
import 'package:tspch/product_detail_screen.dart';
import 'package:tspch/profile_screen.dart';
import 'package:tspch/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  final User currentUser;

  HomeScreen({required this.currentUser});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All";
  String searchText = "";

  final List<String> categories = [
    "All",
    "Monitor",
    "CPU",
    "GPU",
    "RAM",
    "Motherboard",
    "Storage",
    "Power Supply",
    "Cooling",
    "Case"
  ];

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

  final List<Map<String, String>> products = [
    {"name": "LG UltraGear 27\"", "price": "\$350", "category": "Monitor"},
    {"name": "Samsung Odyssey G5", "price": "\$300", "category": "Monitor"},
    {"name": "ASUS TUF Gaming 24\"", "price": "\$220", "category": "Monitor"},
    {"name": "Intel Core i9-13900K", "price": "\$589", "category": "CPU"},
    {"name": "AMD Ryzen 9 7950X", "price": "\$699", "category": "CPU"},
    {"name": "Intel Core i5-13600K", "price": "\$320", "category": "CPU"},
    {"name": "NVIDIA RTX 4090", "price": "\$1999", "category": "GPU"},
    {"name": "AMD RX 7900 XT", "price": "\$999", "category": "GPU"},
    {"name": "RTX 4070 Ti", "price": "\$799", "category": "GPU"},
    {"name": "Corsair 16GB DDR5", "price": "\$159", "category": "RAM"},
    {"name": "G.Skill 32GB DDR5", "price": "\$299", "category": "RAM"},
    {"name": "Kingston 8GB DDR4", "price": "\$45", "category": "RAM"},
    {"name": "ASUS ROG Z790", "price": "\$499", "category": "Motherboard"},
    {"name": "MSI B650", "price": "\$349", "category": "Motherboard"},
    {"name": "Samsung 1TB SSD", "price": "\$120", "category": "Storage"},
    {"name": "WD 2TB HDD", "price": "\$80", "category": "Storage"},
    {"name": "Corsair 750W PSU", "price": "\$130", "category": "Power Supply"},
    {"name": "Cooler Master 650W", "price": "\$95", "category": "Power Supply"},
    {"name": "NZXT Liquid Cooler", "price": "\$180", "category": "Cooling"},
    {"name": "Air Cooler", "price": "\$60", "category": "Cooling"},
    {"name": "NZXT H510 Case", "price": "\$100", "category": "Case"},
    {"name": "Corsair RGB Case", "price": "\$150", "category": "Case"},
  ];

  List<Map<String, String>> get filteredProducts {
    return products.where((product) {
      final categoryMatch =
          selectedCategory == "All" || product["category"] == selectedCategory;
      final searchMatch =
      product["name"]!.toLowerCase().contains(searchText.toLowerCase());
      return categoryMatch && searchMatch;
    }).toList();
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void updateSearch(String value) {
    setState(() {
      searchText = value;
    });
  }

  List<Map<String, String>> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[700],
      appBar: AppBar(
        title: Text("TSPCH Catalog"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProfileScreen(
                            currentUser: widget.currentUser)));
              }),
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CartScreen(
                            cartItems: cartItems,
                            currentUser: widget.currentUser)));
              }),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              onChanged: updateSearch,
              decoration: InputDecoration(
                  hintText: "Search hardware...",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12))),
            ),
          ),
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = cat == selectedCategory;
                return GestureDetector(
                  onTap: () => selectCategory(cat),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 6),
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                        color: isSelected ? Colors.green : Colors.grey[300],
                        borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.center,
                    child: Text(cat,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black)),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: filteredProducts.isEmpty
                ? Center(
                child: Text("No products found",
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)))
                : GridView.builder(
              padding: EdgeInsets.all(12),
              itemCount: filteredProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(
                                product: product,
                                cartItems: cartItems,
                                currentUser: widget.currentUser)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15)),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          getCategoryIcon(product["category"]!),
                          size: 150,
                          color: Colors.black,
                        ),
                        SizedBox(height: 8),
                        Text(product["name"]!,
                            textAlign: TextAlign.center,
                            style:
                            TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(product["price"]!,
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
