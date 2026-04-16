import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String id;
  String name;
  String email;
  String? address;
  List<Map<String, String>> purchasedItems;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.address,
    List<Map<String, String>>? purchasedItems,
  }) : purchasedItems = purchasedItems ?? [];

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'purchasedItems': purchasedItems,
    };
  }

  factory User.fromMap(String id, Map<String, dynamic> map) {
    return User(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      address: map['address'],
      purchasedItems: List<Map<String, String>>.from(
        (map['purchasedItems'] ?? []).map(
              (item) => Map<String, String>.from(item),
        ),
      ),
    );
  }

  Future<void> save() async {
    final usersRef = FirebaseFirestore.instance.collection('users');
    await usersRef.doc(id).set(toMap());
  }

  Future<void> update(Map<String, dynamic> data) async {
    final usersRef = FirebaseFirestore.instance.collection('users');
    await usersRef.doc(id).update(data);
  }

  static Future<User?> getById(String id) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(id).get();
    if (!doc.exists) return null;
    return User.fromMap(doc.id, doc.data()!);
  }
}