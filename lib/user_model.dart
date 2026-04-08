class User {
  String name;
  String email;
  String? address;
  List<Map<String, String>> purchasedItems;

  User({
    required this.name,
    required this.email,
    this.address,
  }) : purchasedItems = [];
}