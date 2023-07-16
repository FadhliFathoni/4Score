// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fourscore/HomePage/MainPage.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth? auth = FirebaseAuth.instance;
GoogleSignIn? googleSignIn = GoogleSignIn();

Future<UserCredential> SignInWithGoogle(BuildContext context) async {
  final GoogleSignInAccount? account = await googleSignIn!.signIn();
  if (account == null) {
    throw FirebaseAuthException(
      code: 'ERROR_ABORTED_BY_USER',
      message: 'Sign in aborted by user',
    );
  }

  final GoogleSignInAuthentication googleAuth = await account.authentication;
  final OAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  final UserCredential userCredential =
      await auth!.signInWithCredential(credential);
  return userCredential;
}
