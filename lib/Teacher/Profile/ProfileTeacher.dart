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
        fileName = pickedFile!.name;
      },
    );
  }

  Future uploadFile() async {
    // final path = '${user!.email}/${pickedFile!.name}';
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
      body: FutureBuilder(
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
                              Container(
                                width: width(context) * 9 / 10,
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: Container(
                                  alignment: Alignment.center,
                                  // color: Colors.red,
                                  width: width(context) * 3 / 10,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Spacer(
                                        flex: 2,
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
                                      Spacer(
                                        flex: 1,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20)),
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
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
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
                                      child: (pickedFile == null)
                                          ? FirebasePicture(
                                              boxFit: BoxFit.cover, data: data)
                                          : Image.file(
                                              File(pickedFile!.path!),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      foregroundColor: PRIMARY_COLOR),
                                  onPressed: () {
                                    selectFile();
                                  },
                                  child: MyText(
                                    text: "Edit Profile",
                                    color: PRIMARY_COLOR,
                                  ),
                                ),
                              ),
                              ProfileTextField(
                                controller: nameController,
                                title: "Name",
                                hintText: data['name'] != null
                                    ? data['name']!
                                    : "Name",
                              ),
                              ProfileTextField(
                                controller: nuptkController,
                                title: "NUPTK",
                                hintText: data['nuptk'] != null
                                    ? data['nuptk']!
                                    : "NUPTK",
                              ),
                              ProfileTextField(
                                controller: teachController,
                                title: "Teach",
                                hintText: data['teach'] != null
                                    ? data['teach']!
                                    : "Japanese",
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 335,
                                margin: EdgeInsets.symmetric(horizontal: 40),
                                alignment: Alignment.centerLeft,
                                // child:
                                //     MyText(text: "Activity", color: Colors.white, fontSize: 20),
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
                                            : pickedFile!.name
                                      });
                                      nameController.clear();
                                      nuptkController.clear();
                                      teachController.clear();
                                      myDialog(context, "Success");
                                    },
                                    text: "Done"),
                              )
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: MyText(text: "There's an error"),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: PRIMARY_COLOR,
                        ),
                      );
                    }
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: MyText(text: "There's an error"),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: PRIMARY_COLOR,
                ),
              );
            }
          }),
    );
  }
}
