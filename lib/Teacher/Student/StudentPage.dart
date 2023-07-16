import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/FirebasePicture.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Student/HomePage/Home/MySimpleCircularProgressBar.dart';
import 'package:fourscore/main.dart';
import 'package:hexcolor/hexcolor.dart';

class StudentPage extends StatefulWidget {
  const StudentPage(
      {super.key,
      required this.email,
      required this.name,
      required this.nis,
      required this.data,
      required this.collection});
  final String email;
  final String name;
  final int nis;
  final dynamic data;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> collection;

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final message = TextEditingController();
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

                        print(score);
                        return Column(
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: width(context) * 9 / 10,
                                    margin: EdgeInsets.symmetric(vertical: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: BackButton(
                                            color: Colors.white,
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
                                ],
                              ),
                            ),
                            Container(
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
                                            data: widget.data)),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                            text: widget.name,
                                            color: PRIMARY_COLOR,
                                            fontSize: 14),
                                        MyText(
                                          text: "${widget.nis}",
                                          color: INPUT,
                                          fontSize: 12,
                                        )
                                      ],
                                    ),
                                  ),
                                  Spacer(
                                    flex: 9,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: width(context) * 9 / 10,
                              alignment: Alignment.centerLeft,
                              child: MyText(
                                  text: "Analystic",
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              height: 30,
                            ),
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
                                    onGetText: (value) {
                                      return Text("${value.toInt()}");
                                    },
                                  );
                                }),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              width: width(context),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      myCollection.doc(id).update({
                                        "score": score - 1,
                                      });
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: SECONDARY_COLOR,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Icon(
                                        Icons.remove,
                                        color: PRIMARY_COLOR,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      myCollection.doc(id).update({
                                        "score": score + 1,
                                      });
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: SECONDARY_COLOR,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Icon(
                                        Icons.add,
                                        color: PRIMARY_COLOR,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: width(context) * 9 / 10,
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  MyText(
                                    text: "Send Message",
                                    color: Colors.white,
                                    fontSize: 18,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: width(context) * 9 / 10,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: SECONDARY_COLOR,
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextField(
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100),
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: SECONDARY_COLOR)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: SECONDARY_COLOR)),
                                  // contentPadding: EdgeInsets.symmetric(horizontal: 20),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),

                                  hintText: " Type something...",
                                  contentPadding: EdgeInsets.only(left: 20),
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: INPUT),
                                ),
                                controller: message,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: width(context) * 9 / 10,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        side: (BorderSide(
                                            width: 1, color: Colors.black)),
                                        backgroundColor: PRIMARY_COLOR,
                                        primary: Colors.black,
                                      ),
                                      child: MyText(
                                        text: "Send",
                                        color: Colors.black,
                                        fontSize: 16,
                                      )),
                                ],
                              ),
                            )
                          ],
                        );
                      } else if (streamSnapshot.hasError) {
                        return Center(child: MyText(text: "There's an error"));
                      } else {
                        return Center(
                            child: CircularProgressIndicator(
                          color: PRIMARY_COLOR,
                        ));
                      }
                    });
              } else if (snapshot.hasError) {
                return Center(child: MyText(text: "There's an error"));
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  color: PRIMARY_COLOR,
                ));
              }
            }),
      ),
    );
  }
}
