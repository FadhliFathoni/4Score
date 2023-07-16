import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Component/myDialog.dart';
import 'package:fourscore/Component/mySnackBar.dart';
import 'package:fourscore/SignIn/SignInPage.dart';
import 'package:fourscore/main.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth auth = FirebaseAuth.instance;
GoogleSignIn? googleSignIn = GoogleSignIn();

void signOut(BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: BG_COLOR,
        title: MyText(text: "Are you sure", color: PRIMARY_COLOR),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: SECONDARY_COLOR,
              foregroundColor: Colors.white.withOpacity(0.4),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: MyText(text: "No"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: PRIMARY_COLOR,
              foregroundColor: SECONDARY_COLOR,
            ),
            onPressed: () async {
              await googleSignIn!.signOut();
              await auth.signOut();
              myDialog(context, "Logout Successful");
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignInPage();
                  },
                ),
              );
            },
            child: MyText(text: "Yes"),
          ),
        ],
      );
    },
  );
}
