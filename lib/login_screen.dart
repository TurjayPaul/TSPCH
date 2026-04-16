import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tspch/user_model.dart';
import 'package:tspch/home_screen.dart';
import 'package:tspch/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter both email and password"),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // 1️⃣ Sign in with Firebase Authentication
      fb_auth.UserCredential userCredential =
      await fb_auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      // 2️⃣ Fetch user data from Firestore
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!doc.exists) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User data not found")),
        );
        return;
      }

      User currentUser = User.fromMap(doc.id, doc.data()!);

      // 3️⃣ Navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(currentUser: currentUser),
        ),
      );
    } on fb_auth.FirebaseAuthException catch (e) {
      String message = "Login failed";
      if (e.code == 'user-not-found') {
        message = "No user found for this email";
      } else if (e.code == 'wrong-password') {
        message = "Incorrect password";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB8E6B8),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 120),
              Icon(Icons.computer, size: 80, color: Colors.green[700]),
              const SizedBox(height: 20),
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[800],
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: Colors.green[800]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green.shade900),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green.shade900),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(color: Colors.green[800]),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green.shade900),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green.shade900),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              isLoading
                  ? CircularProgressIndicator()
                  : SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: loginUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegistrationScreen()),
                  );
                },
                child: Text(
                  "Don't have an account? Register",
                  style: TextStyle(color: Colors.green[800]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}