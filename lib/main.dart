// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fourscore/HomePage/MainPage.dart';
import 'package:fourscore/Intro/IntroSliderPage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'firebase_options.dart';
import 'Component/Text/MyText.dart';

Color PRIMARY_COLOR = HexColor("#FF7800");
Color SECONDARY_COLOR = HexColor("#2D2F3A");
Color BG_COLOR = HexColor("#252525");

double height(BuildContext context) => MediaQuery.of(context).size.height;
double width(BuildContext context) => MediaQuery.of(context).size.width;

void main() async {
  initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: BG_COLOR,
      title: "4Score",
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

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

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
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    animation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.bounceOut),
    );
    animationController.addListener(() {
      setState(() {});
    });
    Timer(Duration(seconds: 1), () {
      animationController.forward();
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
        child: Transform.translate(
          offset: Offset(0, animation.value * -400),
          child: MyText(
            text: "4Score",
            color: PRIMARY_COLOR,
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}
