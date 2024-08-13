import 'package:admin/AdminDashboard.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AdminLoginScreen extends StatefulWidget {
  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final String adminEmail = "admin@example.com";
  final String adminPassword = "adminPassword";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email == adminEmail && password == adminPassword) {
      try {
        // await _auth.signInWithEmailAndPassword(email: email, password: password); //for dynamic

        Get.offAll(() => AdminDashboard());
      } catch (e) {
        Get.snackbar("Error", "Login failed: $e",backgroundColor: Colors.green,snackPosition:SnackPosition.BOTTOM ,colorText: Colors.white);
      }
    } else {
      Get.snackbar("Error", "Invalid email or password",backgroundColor: Colors.red,snackPosition:SnackPosition.BOTTOM ,colorText: Colors.white);
    }
  }
}
