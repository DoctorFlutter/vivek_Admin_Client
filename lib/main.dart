import 'package:admin/AdminDashboard.dart';
import 'package:admin/AdminLoginScreen.dart';
import 'package:admin/auth_controller.dart';
import 'package:admin/client_home.dart';
import 'package:admin/firebase_options.dart';
import 'package:admin/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("Initializing Firebase...");
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase Initialized Successfully");
    Get.lazyPut(()=>AuthController());
  } catch (e) {
    print("Error initializing Firebase: $e");
  }

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Firebase App',
      debugShowCheckedModeBanner: false,

      // home: LoginScreen(),
      initialRoute: kIsWeb ? '/adminlogin' : '/',
      // initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/client', page: () => ClientHome()),
        if (kIsWeb) GetPage(name: '/admin', page: () => AdminDashboard()),
        if (kIsWeb) GetPage(name: '/adminlogin', page: () => AdminLoginScreen()),
        // Web-specific route
      ],
    );
  }
}
