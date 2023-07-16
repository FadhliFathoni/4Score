import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/myDialog.dart';
import 'package:fourscore/SignIn/SignInPage.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;
GoogleSignIn? googleSignIn = GoogleSignIn();

void signOut(BuildContext context) async {
  await googleSignIn!.signOut();
  await auth.signOut();
  myDialog(context, "Successfully Logout");
  Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) {
      return SignInPage();
    },
  ));
}
