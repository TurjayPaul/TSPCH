class User {
  String name;
  String email;
  String? address;
  String? paymentMethod;
  List<Map<String, String>> purchasedItems;

  User({
    required this.name,
    required this.email,
    this.address,
    this.paymentMethod,
  }) : purchasedItems = [];
}