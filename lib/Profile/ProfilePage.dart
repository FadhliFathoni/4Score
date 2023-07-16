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
import 'package:fourscore/Component/mySnackBar.dart';
import 'package:fourscore/Profile/BornTextField.dart';
import 'package:fourscore/Profile/ProfileTextField.dart';
import 'package:fourscore/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

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
    final path = '${user!.email}/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();
    print("Download link ${urlDownload}");
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection("siswa");
    dynamic data;

    return Scaffold(
      body: StreamBuilder(
        stream: collection.where("email", isEqualTo: user!.email).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder(
                future: collection.where("email", isEqualTo: user!.email).get(),
                builder: (context, futureSnapshot) {
                  if (futureSnapshot.hasData) {
                    if (futureSnapshot.data!.docs.isNotEmpty) {
                      data = futureSnapshot.data!.docs.first;
                    } else {
                      data = null;
                    }
                    //Widget starts here
                    return SingleChildScrollView(
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
                                    text: "${user!.email}",
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      try {
                                        final querySnapshot = await collection
                                            .where("email",
                                                isEqualTo: user!.email)
                                            .get();
                                        // final data = querySnapshot.docs.first;
                                        if (querySnapshot.docs.isEmpty) {
                                          collection.add({
                                            "email": user!.email,
                                            "score": 100,
                                            "picture":
                                                (pickedFile!.name.isNotEmpty)
                                                    ? pickedFile!.name
                                                    : null,
                                            "name": nameController.text,
                                            "nis":
                                                int.parse(nisController.text),
                                            "class": classController.text,
                                            "born": born
                                          });
                                        } else {
                                          final docId =
                                              querySnapshot.docs.first.id;
                                          id = docId;
                                          collection.doc(docId).update({
                                            "name":
                                                (nameController.text.isEmpty)
                                                    ? data['name']
                                                    : nameController.text,
                                            "nis": (nisController.text.isEmpty)
                                                ? data["nis"]
                                                : int.parse(nisController.text),
                                            "class":
                                                (classController.text.isEmpty)
                                                    ? data["class"]
                                                    : classController.text,
                                            "born": (born == null)
                                                ? data["born"]
                                                : born
                                          });
                                          uploadFile();
                                          collection.doc(id).update({
                                            "picture": pickedFile!.name,
                                          });
                                        }
                                        Navigator.pop(context);
                                        myDialog(context, "Success");
                                      } catch (e) {
                                        mySnackBar(context, "Fill all the form",
                                            Colors.red);
                                      }
                                    },
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
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(360),
                                        child: (pickedFile == null)
                                            ? FirebasePicture(
                                                data: data,
                                                boxFit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                File(pickedFile!.path!),
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
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
                                ],
                              ),
                            ),
                            ProfileTextField(
                              controller: nameController,
                              title: "Name",
                              hintText: (data != null) ? data['name'] : "Name",
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
                    );
                    //End here
                  } else if (snapshot.hasError) {
                    return Text("There's an error");
                  } else {
                    return Container(
                      height: height(context),
                      width: width(context),
                      color: BG_COLOR,
                    );
                  }
                });
          } else if (snapshot.hasError) {
            return Text("There's an error");
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
