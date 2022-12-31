import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.authStateChanges().listen((User? user) async {
      if (user == null) {
        // print('User is currently signed out!');
        Timer(
            const Duration(seconds: 2),
            () => Navigator.pushNamedAndRemoveUntil(
                context, 'phone', ((route) => false)));
      } else {
        // print('User is signed in!');
        if (mounted) {
          try {
            final User? user = auth.currentUser;
            DocumentSnapshot userData =
                await _firestore.collection("users").doc(user!.uid).get();
            if (userData.exists) {
              Timer(
                  const Duration(seconds: 2),
                  () => Navigator.pushNamedAndRemoveUntil(
                      context, 'home', ((route) => false)));
            } else {
              Timer(
                  const Duration(seconds: 2),
                  () => Navigator.pushNamedAndRemoveUntil(
                      context, 'uploadUserData', ((route) => false)));
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Something went wrong!"),
              ),
            );
          }
          // Timer(
          //     const Duration(seconds: 2),
          //     () => Navigator.pushNamedAndRemoveUntil(
          //         context, 'home', ((route) => false)));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
            child: Center(
              child: Image.asset(
                'assets/logo.png',
                width: 150,
                height: 150,
              ),
            ),
          ),
          Image.asset(
            'assets/banner.jpg',
          ),
        ],
      ),
    );
  }
}
