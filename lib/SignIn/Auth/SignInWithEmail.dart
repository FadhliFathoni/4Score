// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/mySnackBar.dart';
import 'package:fourscore/HomePage/MainPage.dart';

FirebaseAuth auth = FirebaseAuth.instance;

void signInWithEmail(
    BuildContext context, String email, String password) async {
  try {
    mySnackBar(context, "Successfully login", Colors.green);
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return MainPage();
      },
    ));
  } catch (e) {
    if (email.isEmpty || password.isEmpty) {
      mySnackBar(context, "Fill the form", Colors.red);
    } else {
      mySnackBar(context, "Email or password Wrong", Colors.red);
    }
  }
}
