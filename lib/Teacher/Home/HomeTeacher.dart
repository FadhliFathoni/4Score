import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Teacher/Search/SearchSiswa.dart';
import 'package:fourscore/main.dart';

class HomeTeacher extends StatefulWidget {
  const HomeTeacher({super.key});

  @override
  State<HomeTeacher> createState() => _HomeTeacherState();
}

double height(BuildContext context) => MediaQuery.of(context).size.height;
double width(BuildContext context) => MediaQuery.of(context).size.width;

class _HomeTeacherState extends State<HomeTeacher> {
  final searchBarKelas = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    print(user);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection("siswa");

    return Scaffold(
      backgroundColor: BG_COLOR,
      body: FutureBuilder(
          future: collection.orderBy("class").get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> documents = snapshot.data!.docs;
              List<String> uniqueClasses = [];
              Map<String, int> classCounts = {};
              documents.forEach((item) {
                String className = item['class'];
                if (!uniqueClasses.contains(className)) {
                  uniqueClasses.add(className);
                }

                if (classCounts.containsKey(className)) {
                  classCounts[className] = classCounts[className]! + 1;
                } else {
                  classCounts[className] = 1;
                }
              });

              print(classCounts);
              print(uniqueClasses);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: width(context) * 9 / 10,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  color: SECONDARY_COLOR,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Icon(
                                Icons.notifications_none_outlined,
                                color: Colors.white,
                                size: 20,
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: width(context) * 9 / 10,
                    child: TextField(
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w100),
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(
                              Icons.search,
                              color: INPUT,
                              size: 30,
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: SECONDARY_COLOR)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: SECONDARY_COLOR)),
                        // contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: SECONDARY_COLOR,
                        filled: true,
                        hintText: " Search",
                        contentPadding: EdgeInsets.only(left: 20),
                        hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: INPUT),
                      ),
                      controller: searchBarKelas,
                    ),
                  ),
                  Container(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: uniqueClasses.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return SearchPage(Class: uniqueClasses[index]);
                              }));
                            },
                            child: Container(
                              width: width(context) * 9 / 10,
                              margin: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              height: 75,
                              decoration: BoxDecoration(
                                  color: SECONDARY_COLOR,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                        text: uniqueClasses[index],
                                        color: PRIMARY_COLOR,
                                        fontSize: 14,
                                      ),
                                      MyText(
                                        text:
                                            "${classCounts[uniqueClasses[index]]} person",
                                        color: INPUT,
                                        fontSize: 12,
                                      )
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    color: PRIMARY_COLOR,
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
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
          }),
    );
  }
}
