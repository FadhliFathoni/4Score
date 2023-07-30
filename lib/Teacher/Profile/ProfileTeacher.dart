import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Auth/SignOut.dart';
import 'package:fourscore/Component/FirebasePicture.dart';
import 'package:fourscore/Component/MyButton.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Component/myDialog.dart';
import 'package:fourscore/Student/Profile/ProfileTextField.dart';
import 'package:fourscore/main.dart';

class ProfileTeacher extends StatefulWidget {
  const ProfileTeacher({Key? key});

  @override
  State<ProfileTeacher> createState() => _ProfileTeacherState();
}

class _ProfileTeacherState extends State<ProfileTeacher> {
  final nameController = TextEditingController();
  final nuptkController = TextEditingController();
  final teachController = TextEditingController();

  PlatformFile? pickedFile;
  String fileName = "File Name";
  UploadTask? uploadTask;
  User? user = FirebaseAuth.instance.currentUser;
  String? id;

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    setState(
      () {
        pickedFile = result?.files.first;
        fileName = pickedFile!.name!;
      },
    );
  }

  Future<void> uploadFile() async {
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child("${pickedFile!.name}");
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print("Download link ${urlDownload}");
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference collection =
        FirebaseFirestore.instance.collection("guru");
    final user = FirebaseAuth.instance;
    return Scaffold(
      backgroundColor: BG_COLOR,
      appBar: AppBar(
        title: Text("4Score"),
        centerTitle: true,
        backgroundColor: BG_COLOR,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              onPressed: () {
                signOut(context);
              },
              icon: Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowGlow();
          return false;
        },
        child: FutureBuilder(
          future: collection
              .where("email", isEqualTo: user.currentUser!.email)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              final id = snapshot.data!.docs.first.id;
              return StreamBuilder(
                stream: collection.doc(id).snapshots(),
                builder: (context, streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    var data =
                        streamSnapshot.data!.data() as Map<String, dynamic>;
                    return SingleChildScrollView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(height: 30),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(360),
                              child: Container(
                                width: 150,
                                height: 150,
                                child: (pickedFile == null)
                                    ? FirebasePicture(
                                        boxFit: BoxFit.cover,
                                        picture: (data['picture'] != null)
                                            ? data['picture']
                                            : "",
                                      )
                                    : Image.file(
                                        File(pickedFile!.path!),
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Center(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: PRIMARY_COLOR),
                                onPressed: () {
                                  selectFile();
                                },
                                child: MyText(
                                    text: "Edit Profile", color: PRIMARY_COLOR),
                              ),
                            ),
                            ProfileTextField(
                              controller: nameController,
                              title: "Name",
                              hintText: data['name'] ?? "Name",
                            ),
                            ProfileTextField(
                              controller: nuptkController,
                              title: "NUPTK",
                              hintText: data['nuptk'] ?? "NUPTK",
                            ),
                            ProfileTextField(
                              controller: teachController,
                              title: "Teach",
                              hintText: data['teach'] ?? "Teach",
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: 335,
                              margin: EdgeInsets.symmetric(horizontal: 40),
                              alignment: Alignment.centerLeft,
                              // child: MyText(text: "Activity", color: Colors.white, fontSize: 20),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: MyButton(
                                background: SECONDARY_COLOR,
                                foreground: PRIMARY_COLOR,
                                onPressed: () {
                                  collection.doc(id).update({
                                    "name": (nameController.text.isEmpty)
                                        ? data['name']
                                        : nameController.text,
                                    "nuptk": (nuptkController.text.isEmpty)
                                        ? data['nuptk']
                                        : nuptkController.text,
                                    "teach": (teachController.text.isEmpty)
                                        ? data['teach']
                                        : teachController.text,
                                    "picture": (pickedFile == null)
                                        ? (data['picture'] == null)
                                            ? null
                                            : data['picture']
                                        : pickedFile!.name!,
                                  });
                                  nameController.clear();
                                  nuptkController.clear();
                                  teachController.clear();
                                  myDialog(context, "Success");
                                },
                                text: "Done",
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: MyText(text: "There's an error"));
                  } else {
                    return Center(
                        child: CircularProgressIndicator(color: PRIMARY_COLOR));
                  }
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: MyText(text: "There's an error"));
            } else {
              return Center(
                  child: CircularProgressIndicator(color: PRIMARY_COLOR));
            }
          },
        ),
      ),
    );
  }
}
