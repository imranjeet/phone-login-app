import 'package:aryago_login_app/screens/home.dart';
import 'package:aryago_login_app/screens/phone.dart';
import 'package:aryago_login_app/screens/splash_screen.dart';
import 'package:aryago_login_app/screens/upload_user_data.dart';
import 'package:aryago_login_app/screens/verify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: 'splash',
    debugShowCheckedModeBanner: false,
    routes: {
      'splash': (context) => const SplashScreen(),
      'phone': (context) => const MyPhone(),
      'verify': (context) => const MyVerify(),
      'home': (context) => const Home(),
      'uploadUserData': (context) => const UploadUserData(),
    },
  ));
}
