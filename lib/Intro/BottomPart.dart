// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:fourscore/main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';

class BottomPart extends StatelessWidget {
  final Widget content;
  int? page = 1;

  BottomPart({super.key, required this.content, required this.page});

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder(
        curve: Curves.easeInOut,
        tween: Tween(begin: 0.0, end: 1.0),
        duration: Duration(seconds: 1),
        builder: (context, value, child) {
          return Container(
            height: (page == 1)
                ? height(context) * 0.5 - (value * (height(context) * 0.1))
                : height(context) * 0.4 + (value * (height(context) * 0.1)),
            width: width(context),
            decoration: BoxDecoration(
              color: HexColor("#2D2F3A"),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                child: content),
          );
        });
  }
}
