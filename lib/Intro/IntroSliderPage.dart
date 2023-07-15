// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fourscore/Component/MyButton.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Intro/BottomPart.dart';
import 'package:fourscore/Intro/BoyWithShadow.dart';
import 'package:fourscore/Intro/IntroSliderPage2.dart';
import 'package:fourscore/main.dart';
import 'package:hexcolor/hexcolor.dart';
// ignore: unused_import
import 'package:simple_animations/simple_animations.dart';

class IntroSliderPage extends StatefulWidget {
  const IntroSliderPage({super.key});

  @override
  State<IntroSliderPage> createState() => _IntroSliderPageState();
}

class _IntroSliderPageState extends State<IntroSliderPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
    animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height(context),
        width: width(context),
        color: BG_COLOR,
        child: Stack(
          children: <Widget>[
            Positioned(
                top: 0,
                child: BoyWithShadow(
                  page: 1,
                )),
            Positioned(
              bottom: 0,
              child: BottomPart(
                content: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        MyText(
                          text: "Let's be more disciplined students",
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: HexColor("#FFFFFF"),
                        ),
                        Container(
                          width: width(context) * 0.7,
                          margin: EdgeInsets.only(top: 12),
                          child: MyText(
                            text:
                                "Mulailah belajar dengan menjadi siswa yang disiplin.",
                            fontSize: 16,
                            textAlign: TextAlign.center,
                            color: HexColor("#7C7C7C"),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      child: MyButton(
                        text: "Get Started",
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return IntroSliderPage2();
                                },
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ));
                        },
                      ),
                    ),
                  ],
                ),
                page: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
