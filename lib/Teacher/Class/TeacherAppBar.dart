import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/main.dart';

AppBar TeacherAppBar(Widget leading) {
  return AppBar(
    title: MyText(text: "4Score"),
    centerTitle: true,
    backgroundColor: BG_COLOR,
    elevation: 0,
    leading: leading,
  );
}
