// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:fourscore/main.dart';
import 'package:simple_animations/animation_builder/play_animation_builder.dart';

class BoyWithShadow extends StatelessWidget {
  int? page = 1;
  BoyWithShadow({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder(
        duration: Duration(seconds: 1),
        tween: Tween(begin: 0.0, end: 1.0),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Container(
            alignment: Alignment.center,
            height: (page == 1)
                ? height(context) * 0.5 + (value * (height(context) * 0.1))
                : height(context) * 0.6 - (value * (height(context) * 0.1)),
            width: width(context),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 100,
                        spreadRadius: 0.1,
                        color: Colors.yellow,
                      )
                    ]),
                height: 300,
                width: 300,
                child: Image(image: AssetImage("assets/images/boy.png"))),
          );
        });
  }
}
