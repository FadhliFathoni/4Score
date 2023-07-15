import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/HomePage/MySimpleCircularProgressBar.dart';
import 'package:fourscore/Profile/ProfilePage.dart';
import 'package:fourscore/main.dart';
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: height(context),
        width: width(context),
        color: BG_COLOR,
        child: Stack(alignment: Alignment.center, children: [
          Positioned(
            top: 0,
            child: Container(
              width: width(context),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: HexColor("#2D2F3A"), shape: BoxShape.circle),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                      )),
                  MyText(
                    text: "4Score",
                    fontSize: 27,
                    color: Colors.white,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          // transitionDuration: Duration(milliseconds: 100),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return ProfilePage();
                          },
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'pp',
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MySimpleCircularProgressBar(
                  animationDuration: 1500,
                  maxValue: 100,
                  progressColors: [PRIMARY_COLOR],
                  mergeMode: true,
                  backColor: HexColor("#FFFFFF"),
                  size: 250,
                  valueNotifier: ValueNotifier(75),
                  onGetText: (value) {
                    return Text("${value.toInt()}");
                  },
                ),
                Container(
                    margin: EdgeInsets.only(top: height(context) * 0.1),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    width: width(context) * 9 / 10,
                    decoration: BoxDecoration(
                      color: SECONDARY_COLOR,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.document_scanner_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: MyText(
                                text: "Absent",
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        )
                      ],
                    ))
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
