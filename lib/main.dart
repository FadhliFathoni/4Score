// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:fourscore/Intro/IntroSliderPage.dart';
import 'package:fourscore/Student/HomePage/MainPage.dart';
import 'package:fourscore/Teacher/Class/ClassPage.dart';
import 'package:fourscore/Teacher/MainTeacher.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'firebase_options.dart';
import 'Component/Text/MyText.dart';

Color PRIMARY_COLOR = HexColor("#FF7800");
Color SECONDARY_COLOR = HexColor("#2D2F3A");
Color BG_COLOR = HexColor("#252525");
Color INPUT = HexColor("#7C7C7C");

double height(BuildContext context) => MediaQuery.of(context).size.height;
double width(BuildContext context) => MediaQuery.of(context).size.width;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  initializeDateFormatting();
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
      // Check if the user is a teacher
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference collectionGuru = firestore.collection("guru");
      return FutureBuilder<QuerySnapshot>(
        future:
            collectionGuru.where("email", isEqualTo: currentUser.email).get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for the query result
            return Center(
                child: CircularProgressIndicator(
              color: PRIMARY_COLOR,
            ));
          }
          if (snapshot.hasError) {
            // Handle any potential errors
            print(snapshot.error);
            return Text('An error occurred');
          }
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            // User is a teacher, navigate to teacher screen
            return MainTeacher();
          } else {
            // User is not a teacher, navigate to student screen
            return MainPage();
          }
        },
      );
    } else {
      // User is not logged in, navigate to intro slider page
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
      backgroundColor: BG_COLOR,
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
