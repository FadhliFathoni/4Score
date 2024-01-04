import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/ProgressBarWidget.dart';
import 'package:fourscore/Student/HomePage/Home/AbsentButton.dart';
import 'package:fourscore/Student/HomePage/Home/AppBar/UserProfileAppBar.dart';
import 'package:fourscore/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var id;
  // dynamic data;
  String picture = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection("siswa");
    User? user = FirebaseAuth.instance.currentUser;
    return Container(
      height: height(context),
      width: width(context),
      color: BG_COLOR,
      child: Stack(
        alignment: Alignment.center,
        children: [
          UserProfileAppBar(
            collection: collection,
            user: user!,
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProgressBarWidget(collection: collection, user: user),
                AbsentButton(collection: collection, user: user),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
