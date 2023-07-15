import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/MyButton.dart';
import 'package:fourscore/Component/ScaffoldCheckUser.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Component/mySnackBar.dart';
import 'package:fourscore/Profile/ProfileTextField.dart';
import 'package:fourscore/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.user});
  final User? user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();
  final nisController = TextEditingController();
  final classController = TextEditingController();
  final bornController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldCheckUser(
      body: SingleChildScrollView(
        child: Container(
          width: width(context),
          color: BG_COLOR,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 17, horizontal: 17),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BackButton(
                      color: Colors.white,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Hero(
                      tag: 'pp',
                      child: Container(
                        height: 118,
                        width: 118,
                        decoration: BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: PRIMARY_COLOR),
                        onPressed: () {},
                        child: MyText(
                          text: "Edit Profile",
                          color: PRIMARY_COLOR,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ProfileTextField(
                controller: nameController,
                title: "Name",
                hintText: "Name",
              ),
              ProfileTextField(
                controller: nisController,
                hintText: "NIS",
                title: "NIS",
              ),
              ProfileTextField(
                controller: classController,
                hintText: "Class",
                title: "Class",
              ),
              ProfileTextField(
                controller: bornController,
                hintText: "Born",
                title: "Born",
              ),
              Container(
                margin: EdgeInsets.only(top: 8.5),
                child: MyButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    mySnackBar(context, "Successfully sign out", Colors.red);
                    print("Successfully sign out");
                  },
                  text: "Logout",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
