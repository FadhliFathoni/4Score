// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/mySnackBar.dart';
import 'package:fourscore/Student/HomePage/MainPage.dart';
import 'package:fourscore/Teacher/Class/ClassPage.dart';
import 'package:fourscore/Teacher/MainTeacher.dart';

FirebaseAuth auth = FirebaseAuth.instance;

Future<void> signInWithEmail(
    BuildContext context, String email, String password) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collectionGuru = firestore.collection("guru");
    CollectionReference collectionSiswa = firestore.collection("siswa");
    User? user = userCredential.user;
    try {
      final data = await collectionGuru
          .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
          .get();
      if (data.docs.isNotEmpty) {
        // Email exists in "guru" collection
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MainTeacher();
            },
          ),
        );
      } else {
        // Email doesn't exist in "guru" collection
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MainPage();
            },
          ),
        );
      }
    } catch (e) {
      // Handle any potential errors
      print(e);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return MainPage();
          },
        ),
      );
    }

    // Sign in successful, navigate to the desired page
  } catch (e) {
    // Handle sign in errors
    print(e.toString());
    mySnackBar(
        context, "Sign in failed. Please check your credentials.", Colors.red);
  }
}
