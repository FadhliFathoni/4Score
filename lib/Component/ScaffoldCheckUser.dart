import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Intro/IntroSliderPage.dart';
import 'package:fourscore/SignIn/SignInPage.dart';

class ScaffoldCheckUser extends StatelessWidget {
  const ScaffoldCheckUser({super.key, required this.body, this.appbar});
  final Widget body;
  final AppBar? appbar;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          try {
            return Scaffold(
              appBar: appbar,
              body: body,
            );
          } catch (e) {
            throw (e);
          }
          // if (snapshot.hasData) {
          //   return Scaffold(
          //     appBar: appbar,
          //     body: body,
          //   );
          // } else if (snapshot.hasError) {
          //   throw "Login failed";
          // } else if (snapshot.connectionState == ConnectionState.waiting) {
          //   return CircularProgressIndicator();
          // } else {
          //   return IntroSliderPage();
          // }
        });
  }
}
