// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fourscore/Student/HomePage/Calendar/CalendarPage.dart';
import 'package:fourscore/Student/HomePage/Home/HomePage.dart';
import 'package:fourscore/Component/TabBar/MyTabBar.dart';
import 'package:fourscore/main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:akar_icons_flutter/akar_icons_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 2), () {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: BG_COLOR,
      title: "4Score",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowGlow();
          return false;
        },
        child: MyTabBar(
            itemSelectedColor: PRIMARY_COLOR,
            tabBarBackgroundColor: HexColor("#2D2F3A"),
            itemNormalColor: HexColor("#FFFFFF"),
            pages: [
              HomePage(),
              CalendarPage(),
            ],
            tabIcons: [
              AkarIcons.home_alt1,
              AkarIcons.newspaper,
            ]),
      )),
    );
  }
}
