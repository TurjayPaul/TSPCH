import 'package:flutter/material.dart';
import 'package:tspch/user_model.dart';
import 'package:tspch/login_screen.dart';
import 'package:tspch/home_screen.dart';

class RegistrationScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text.trim();
                if (name.isEmpty) name = "User";
                String email = emailController.text.trim();
                if (email.isEmpty) email = "user@example.com";
                User currentUser = User(name: name, email: email);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Registration Successful")));
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (_) => HomeScreen(currentUser: currentUser)));
              },
              child: Text("Register"),
            ),
          ]),
        ),
      ),
    );
  }
}