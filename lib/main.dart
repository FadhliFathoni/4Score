// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fourscore/HomePage/MainPage.dart';
import 'package:fourscore/Intro/IntroSliderPage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'firebase_options.dart';
import 'Component/Text/MyText.dart';

Color PRIMARY_COLOR = HexColor("#FF7800");
Color SECONDARY_COLOR = HexColor("#2D2F3A");
Color BG_COLOR = HexColor("#252525");

double height(BuildContext context) => MediaQuery.of(context).size.height;
double width(BuildContext context) => MediaQuery.of(context).size.width;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      checkerboardOffscreenLayers: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  Widget checkUser() {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      return MainPage();
    } else {
      return IntroSliderPage();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return checkUser();
        },
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: height(context),
        width: width(context),
        decoration: BoxDecoration(
          color: BG_COLOR,
        ),
        child: MyText(
          text: "4Score",
          color: PRIMARY_COLOR,
          fontSize: 50,
        ),
      ),
    );
  }
}
