// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/MyButton.dart';
import 'package:fourscore/Component/ScaffoldCheckUser.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Component/mySnackBar.dart';
import 'package:fourscore/SignIn/Auth/SignInWithEmail.dart';
import 'package:fourscore/SignIn/Auth/SignInWithGoogle.dart';
import 'package:fourscore/SignIn/EmailTextField.dart';
import 'package:fourscore/SignIn/PasswordTextField.dart';
import 'package:fourscore/main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscureText = true;

  void getFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("first", false);
  }

  // void checkUser(BuildContext context, String email, String password) {
  //   try {
  //     registerWithEmail(context, email, password);
  //   } catch (e) {
  //     signInWithEmail(context, email, password);
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCheckUser(
      body: Container(
        height: height(context),
        width: width(context),
        color: BG_COLOR,
        child: Center(
          child: Container(
            height: height(context) * 0.7,
            width: width(context) - 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: "Easy to be absent anywhere anytime",
                      color: HexColor("#FFFFFF"),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 17),
                      child: MyText(
                        text: "Sign in to your account",
                        color: HexColor("#7C7C7C"),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    EmailTextField(controller: emailController),
                    PasswordTextField(
                      controller: passwordController,
                      obscureText: obscureText,
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                  ],
                ),
                Center(
                  child: Column(
                    children: [
                      MyButton(
                          onPressed: () {
                            signInWithEmail(
                              context,
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            );
                            print("login");
                          },
                          text: "Sign In"),
                      ButtonGoogle(onPressed: () async {
                        UserCredential? userCredential =
                            await SignInWithGoogle();
                        User? user = userCredential.user;
                        mySnackBar(context, "Succesfully Login", Colors.green);
                      }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonGoogle extends StatelessWidget {
  const ButtonGoogle({
    super.key,
    required this.onPressed,
  });

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 17),
      width: width(context),
      height: 60,
      constraints: BoxConstraints(maxWidth: 335),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/icons/google.png"),
            ),
            Container(
              margin: EdgeInsets.only(left: 14),
              child: MyText(
                text: "Sign In With Google",
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
