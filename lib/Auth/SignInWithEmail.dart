// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/mySnackBar.dart';
import 'package:fourscore/Student/HomePage/MainPage.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<void> signInWithEmail(
    BuildContext context, String email, String password) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;

    // Sign in successful, navigate to the desired page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(),
      ),
    );
  } catch (e) {
    // Handle sign in errors
    print(e.toString());
    mySnackBar(
        context, "Sign in failed. Please check your credentials.", Colors.red);
  }
}
