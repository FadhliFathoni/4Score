// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fourscore/Component/MyButton.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Intro/BottomPart.dart';
import 'package:fourscore/Intro/BoyWithShadow.dart';
import 'package:fourscore/SignIn/SignInPage.dart';
import 'package:fourscore/main.dart';
import 'package:hexcolor/hexcolor.dart';

class IntroSliderPage2 extends StatefulWidget {
  const IntroSliderPage2({super.key});

  @override
  State<IntroSliderPage2> createState() => _IntroSliderPage2State();
}

class _IntroSliderPage2State extends State<IntroSliderPage2>
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
                  page: 2,
                )),
            Positioned(
              bottom: 0,
              child: BottomPart(
                content: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: MyText(
                        text: "Who are you?",
                        fontSize: 30,
                        color: HexColor("#ffffff"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 25),
                      child: MyButton(
                        background: PRIMARY_COLOR,
                        foreground: BG_COLOR,
                        text: "I'am Teacher",
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return SignInPage();
                              },
                              transitionDuration: Duration(milliseconds: 500),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0.0, 1.0),
                                    end: Offset.zero,
                                  ).animate(
                                    CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeInOut,
                                    ),
                                  ),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    MyButton(
                      background: PRIMARY_COLOR,
                      foreground: BG_COLOR,
                      text: "I am Student",
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) {
                              return SignInPage();
                            },
                            transitionDuration: Duration(milliseconds: 500),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0.0, 1.0),
                                  end: Offset.zero,
                                ).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeInOut,
                                  ),
                                ),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                page: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
