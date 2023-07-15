// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:fourscore/Component/ScaffoldCheckUser.dart';
import 'package:fourscore/HomePage/CalendarPage.dart';
import 'package:fourscore/HomePage/HomePage.dart';
import 'package:fourscore/HomePage/TabBar/MyTabBar.dart';
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
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScaffoldCheckUser(
        body: MyTabBar(
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
      ),
    );
  }
}

