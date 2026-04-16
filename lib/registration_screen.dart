import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tspch/user_model.dart';
import 'package:tspch/home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  bool isLoading = false;

  Future<void> registerUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String address = addressController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || address.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Enter a valid email")),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password must be at least 6 characters")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final userCredential =
      await fb_auth.FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user == null) {
        throw Exception("User creation failed");
      }

      final uid = user.uid;

      User currentUser = User(
        id: uid,
        name: name,
        email: email,
        address: address,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set(currentUser.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Successful")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(currentUser: currentUser),
        ),
      );
    } on fb_auth.FirebaseAuthException catch (e) {
      print("ERROR: ${e.code} - ${e.message}");

      String message;

      switch (e.code) {
        case 'email-already-in-use':
          message = "Email already registered";
          break;
        case 'invalid-email':
          message = "Invalid email format";
          break;
        case 'weak-password':
          message = "Password is too weak";
          break;
        case 'network-request-failed':
          message = "Check your internet connection";
          break;
        default:
          message = e.message ?? "Registration failed";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      print("UNKNOWN ERROR: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB8E6B8),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Icon(Icons.app_registration, size: 80, color: Colors.green),
              SizedBox(height: 20),

              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Full Name"),
              ),

              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),

              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
              ),

              TextField(
                controller: addressController,
                decoration: InputDecoration(labelText: "Address"),
              ),

              SizedBox(height: 20),

              isLoading
                  ? CircularProgressIndicator()
                  : SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}