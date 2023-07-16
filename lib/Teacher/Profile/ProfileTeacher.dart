import 'package:flutter/material.dart';
import 'package:fourscore/Auth/SignOut.dart';
import 'package:fourscore/Component/MyButton.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Student/Profile/ProfileTextField.dart';
import 'package:fourscore/Teacher/Profile/PhotoProfile.dart';
import 'package:fourscore/main.dart';

class ProfileTeacher extends StatefulWidget {
  const ProfileTeacher({super.key});

  @override
  State<ProfileTeacher> createState() => _ProfileTeacherState();
}

class _ProfileTeacherState extends State<ProfileTeacher> {
  final nameController = TextEditingController();
  final nuptkController = TextEditingController();
  final teachController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width(context) * 9 / 10,
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        child: BackButton(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      // color: Colors.red,
                      width: width(context) * 3 / 10,
                      child: MyText(
                        text: "4Score",
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    Container(
                      height: 30,
                      width: width(context) * 2 / 10,
                      child: Spacer(
                        flex: 1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PhotoProfile();
                  }));
                },
                child: Hero(
                  tag: "pp",
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      width: 150,
                      height: 150,
                      child: Image(
                        image: NetworkImage(
                            "https://s3.getstickerpack.com/storage/uploads/sticker-pack/keqing/sticker_9.png?4996771f86fd38e818153e52edcc458f&d=200x200"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: MyText(
                  text: "Edit Profile",
                  color: PRIMARY_COLOR,
                ),
              ),
              SizedBox(height: 20),
              ProfileTextField(
                  controller: nameController,
                  title: "Name",
                  hintText: "Keqing Lucu"),
              ProfileTextField(
                  controller: nuptkController,
                  title: "NUPTK",
                  hintText: "2122119151"),
              ProfileTextField(
                  controller: teachController,
                  title: "Teach",
                  hintText: "Japanese"),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 335,
                margin: EdgeInsets.symmetric(horizontal: 40),
                alignment: Alignment.centerLeft,
                child:
                    MyText(text: "Activity", color: Colors.white, fontSize: 20),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.5),
                child: MyButton(
                  onPressed: () {
                    signOut(context);
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
