import 'package:flutter/material.dart';
import 'package:fourscore/Component/FirebasePicture.dart';
import 'package:fourscore/Component/PhotoProfile.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Component/myDialog.dart';
import 'package:fourscore/Student/Profile/ProfilePage.dart';
import 'package:fourscore/main.dart';
import 'package:hexcolor/hexcolor.dart';

class StudentAppBar extends StatelessWidget {
  const StudentAppBar({
    super.key,
    required this.picture,
  });

  final String picture;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      child: Container(
        width: width(context),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                myDialog(context, "Coming soon");
              },
              child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: HexColor("#2D2F3A"), shape: BoxShape.circle),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: Colors.white,
                  )),
            ),
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
                    pageBuilder: (context, animation, secondaryAnimation) {
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
                child: PhotoProfile(
                  picture: picture,
                  size: 50,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
