import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/FirebasePicture.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Component/myDialog.dart';
import 'package:fourscore/Student/HomePage/Home/MySimpleCircularProgressBar.dart';
import 'package:fourscore/Teacher/Student/MessageTextField.dart';
import 'package:fourscore/Teacher/Student/ScoreButton.dart';
import 'package:fourscore/Teacher/Student/SendMessageButton.dart';
import 'package:fourscore/main.dart';
import 'package:hexcolor/hexcolor.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({
    Key? key,
    required this.email,
    required this.name,
    required this.nis,
    required this.data,
    required this.collection,
  }) : super(key: key);

  final String email;
  final String name;
  final int nis;
  final dynamic data;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> collection;

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final messageController = TextEditingController();
  final progressValueNotifier = ValueNotifier<double>(0.0);

  @override
  Widget build(BuildContext context) {
    final myCollection = FirebaseFirestore.instance.collection("siswa");
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: myCollection.where("email", isEqualTo: widget.email).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              var id = snapshot.data!.docs.first.id;
              return StreamBuilder(
                stream: myCollection.doc(id).snapshots(),
                builder: (context, streamSnapshot) {
                  if (streamSnapshot.hasData) {
                    final score = double.parse(
                        streamSnapshot.data!.data()!['score'].toString());
                    progressValueNotifier.value = score;
                    return Column(
                      children: [
                        AppBarWidget(),
                        StudentInfoWidget(
                          name: widget.name,
                          nis: widget.nis,
                          data: widget.data,
                        ),
                        SizedBox(height: 30),
                        MyText(
                          text: 'Analystic',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        SizedBox(height: 30),
                        ValueListenableBuilder(
                          valueListenable: progressValueNotifier,
                          builder: (context, value, child) {
                            return MySimpleCircularProgressBar(
                              animationDuration: 0,
                              maxValue: 100,
                              progressColors: [PRIMARY_COLOR],
                              mergeMode: true,
                              backColor: HexColor("#FFFFFF"),
                              size: 250,
                              valueNotifier: progressValueNotifier,
                              onGetText: (value) => Text("${value.toInt()}"),
                            );
                          },
                        ),
                        SizedBox(height: 40),
                        ScoreButton(
                          onMinusPressed: () => _updateScore(id, score - 1),
                          onPlusPressed: () => _updateScore(id, score + 1),
                        ),
                        SizedBox(height: 30),
                        MyText(
                          text: 'Send Message',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        MessageTextField(controller: messageController),
                        SizedBox(height: 10),
                        SendMessageButton(
                          onPressed: () {
                            myCollection.doc(id).collection("message").add({
                              "from": FirebaseAuth.instance.currentUser!.email,
                              "message": messageController.text,
                            });
                            messageController.clear();
                            myDialog(context, "Success");
                          },
                        ),
                      ],
                    );
                  } else if (streamSnapshot.hasError) {
                    return Center(child: MyText(text: 'There\'s an error'));
                  } else {
                    return Center(
                        child: CircularProgressIndicator(color: PRIMARY_COLOR));
                  }
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: MyText(text: 'There\'s an error'));
            } else {
              return Center(
                  child: CircularProgressIndicator(color: PRIMARY_COLOR));
            }
          },
        ),
      ),
    );
  }

  void _updateScore(String id, double newScore) {
    FirebaseFirestore.instance
        .collection("siswa")
        .doc(id)
        .update({"score": newScore});
    setState(() {});
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: width(context) * 9 / 10,
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: BackButton(color: Colors.white),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: width(context) * 3 / 10,
                  child:
                      MyText(text: '4Score', color: Colors.white, fontSize: 25),
                ),
                Container(height: 30, width: width(context) * 2 / 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StudentInfoWidget extends StatelessWidget {
  const StudentInfoWidget({
    Key? key,
    required this.name,
    required this.nis,
    required this.data,
  }) : super(key: key);

  final String name;
  final int nis;
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * 9 / 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: FirebasePicture(
                boxFit: BoxFit.cover,
                picture: data['picture'] ?? "",
              ),
            ),
          ),
          Spacer(flex: 1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(text: name, color: PRIMARY_COLOR, fontSize: 14),
              MyText(text: "$nis", color: INPUT, fontSize: 12),
            ],
          ),
          Spacer(flex: 9),
        ],
      ),
    );
  }
}
