import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/TabBar/MyTabBar.dart';
import 'package:fourscore/Teacher/Class/ClassPage.dart';
import 'package:fourscore/Teacher/Profile/ProfileTeacher.dart';
import 'package:fourscore/main.dart';
import 'package:hexcolor/hexcolor.dart';

class MainTeacher extends StatefulWidget {
  const MainTeacher({super.key});

  @override
  State<MainTeacher> createState() => _MainTeacherState();
}

class _MainTeacherState extends State<MainTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ClassPage());
  }
}
