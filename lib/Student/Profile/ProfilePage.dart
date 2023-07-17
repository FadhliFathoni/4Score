import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Auth/SignOut.dart';
import 'package:fourscore/Component/MyButton.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Component/myDialog.dart';
import 'package:fourscore/Student/Profile/BornTextField.dart';
import 'package:fourscore/Student/Profile/MyTextButton.dart';
import 'package:fourscore/Component/PhotoProfile.dart';
import 'package:fourscore/Student/Profile/ProfileTextField.dart';
import 'package:fourscore/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final nameController = TextEditingController();
  final nisController = TextEditingController();
  final classController = TextEditingController();
  final bornController = TextEditingController();
  DateTime? born;

  PlatformFile? pickedFile;
  String fileName = "File Name";
  UploadTask? uploadTask;
  User? user = FirebaseAuth.instance.currentUser;
  String? id;
  dynamic data = null;
  String picture = "";

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }
    setState(() {
      pickedFile = result?.files.first;
      fileName = pickedFile!.name;
    });
  }

  Future<void> saveProfile() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collection = firestore.collection("siswa");
      final querySnapshot =
          await collection.where("email", isEqualTo: user!.email).get();

      if (querySnapshot.docs.isEmpty) {
        collection.add({
          "email": user!.email,
          "score": 100,
          "picture": pickedFile?.name,
          "name": nameController.text,
          "nis": int.parse(nisController.text),
          "class": classController.text.toUpperCase(),
          "born": born,
        });
      } else {
        final docId = querySnapshot.docs.first.id;
        id = docId;
        collection.doc(docId).update({
          "name": nameController.text.isNotEmpty
              ? nameController.text
              : data['name'],
          "nis": nisController.text.isNotEmpty
              ? int.parse(nisController.text)
              : data['nis'],
          "class": classController.text.isNotEmpty
              ? classController.text.toUpperCase()
              : data['class'],
          "born": born ?? data['born'],
        });

        if (pickedFile != null) {
          final file = File(pickedFile!.path!);
          final ref = FirebaseStorage.instance.ref().child(pickedFile!.name);
          uploadTask = ref.putFile(file);
          await uploadTask!.whenComplete(() {});
          collection.doc(id).update({
            "picture": pickedFile!.name,
          });
        }
      }

      Navigator.pop(context);
      myDialog(context, "Success");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final collection = firestore.collection("siswa");

    return Scaffold(
      backgroundColor: BG_COLOR,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowGlow();
          return false;
        },
        child: FutureBuilder<QuerySnapshot>(
          future: collection.where("email", isEqualTo: user!.email).get(),
          builder: (context, futureSnapshot) {
            if (futureSnapshot.hasData) {
              final documents = futureSnapshot.data!.docs;
              if (documents.isNotEmpty) {
                final id = documents.first.id;

                return StreamBuilder<DocumentSnapshot>(
                  stream: collection.doc(id).snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      data = snapshot.data!.data()!;
                      picture = data['picture'] ?? "";

                      return SingleChildScrollView(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        child: Container(
                          width: width(context),
                          color: BG_COLOR,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 17, horizontal: 17),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BackButton(
                                      color: Colors.white,
                                    ),
                                    MyText(
                                      text: user!.email!,
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                    IconButton(
                                      onPressed: saveProfile,
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
                                      child: PhotoProfile(
                                        pickedFile: pickedFile,
                                        picture: picture,
                                        size: 118,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      child: MyTextButton(
                                        text: "Edit Profile",
                                        onPressed: selectFile,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ProfileTextField(
                                controller: nameController,
                                title: "Name",
                                hintText:
                                    (data != null) ? data['name'] : "Name",
                              ),
                              ProfileTextField(
                                controller: nisController,
                                hintText: (data != null)
                                    ? data['nis'].toString()
                                    : "NIS",
                                title: "NIS",
                              ),
                              ProfileTextField(
                                controller: classController,
                                hintText:
                                    (data != null) ? data['class'] : "Class",
                                title: "Class",
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2023),
                                    firstDate: DateTime(1945),
                                    lastDate: DateTime(2023),
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      born = picked;
                                      bornController.text = born.toString();
                                    });
                                  }
                                },
                                child: BornTextField(data: data, born: born),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8.5, bottom: 8.5),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 10,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                                child: MyButton(
                                  foreground: PRIMARY_COLOR,
                                  background: SECONDARY_COLOR,
                                  onPressed: () {
                                    signOut(context);
                                  },
                                  text: "Logout",
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("There's an error");
                    } else {
                      return Container(
                        height: height(context),
                        width: width(context),
                        color: BG_COLOR,
                      );
                    }
                  },
                );
              } else {
                return Text("Collection is empty");
              }
            } else if (futureSnapshot.hasError) {
              print(futureSnapshot.error);
              return Text("There's an error");
            } else {
              return CircularProgressIndicator(
                color: PRIMARY_COLOR,
              );
            }
          },
        ),
      ),
    );
  }
}
