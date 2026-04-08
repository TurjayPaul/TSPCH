class User {
  String name;
  String email;
  List<Map<String, String>> purchasedItems;

  User({
    required this.name,
    required this.email,
  }) : purchasedItems = [];
}