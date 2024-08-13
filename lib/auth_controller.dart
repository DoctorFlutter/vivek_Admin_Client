import 'package:admin/AdminDashboard.dart';
import 'package:admin/AdminLoginScreen.dart';
import 'package:admin/client_home.dart';
import 'package:admin/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // void login(String email, String password) async {
  //   try {
  //     UserCredential userCredential = await auth.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     User? user = userCredential.user;
  //
  //     if (user != null) {
  //       if (user.email == "admin@example.com") {
  //         Get.offAll(() => AdminDashboard());
  //       } else {
  //         Get.offAll(() => ClientHome());
  //       }
  //     }
  //   } catch (e) {
  //     Get.snackbar("Login Failed", e.toString());
  //   }
  // }

  void login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      print("Authenticated user email: ${user?.email}");

      if (user != null) {
        if (kIsWeb) { // Admin login logic
          Get.offAll(() => AdminLoginScreen());
        } else { // Client login logic
          Get.offAll(() => ClientHome());
        }
      }
    } catch (e) {
      Get.snackbar("Login Failed", e.toString(),backgroundColor: Colors.green,snackPosition:SnackPosition.BOTTOM ,colorText: Colors.white);
    }
  }


  void logout() async {
    await auth.signOut();
    Get.offAll(() => LoginScreen());
  }
}
