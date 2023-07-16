import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/FirebasePicture.dart';
import 'package:fourscore/Component/FirebasePicture.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Teacher/Student/StudentPage.dart';
import 'package:fourscore/main.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key, required this.Class});
  final String Class;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchBarSiswa = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final collection = firestore.collection("siswa");
    return Scaffold(
      backgroundColor: BG_COLOR,
      body: FutureBuilder(
          future: collection.where("class", isEqualTo: widget.Class).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              var listData = [];
              for (int x = 0; x < snapshot.data!.size; x++) {
                var dataId = snapshot.data?.docs[x];
                var data = dataId!.data() as Map<String, dynamic>;
                listData.add(data);
              }
              return Container(
                child: Column(
                  children: [
                    Container(
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
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
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
                        controller: searchBarSiswa,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: width(context) * 9 / 10,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: listData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return StudentPage(
                                  email: listData[index]['email'],
                                  name: listData[index]['name'],
                                  nis: listData[index]['nis'],
                                  data: listData[index],
                                  collection: snapshot,
                                );
                              }));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              width: width(context) * 9 / 10,
                              height: 80,
                              decoration: BoxDecoration(
                                  color: SECONDARY_COLOR,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: ListTile(
                                  title: MyText(
                                      text: listData[index]['name'],
                                      color: PRIMARY_COLOR,
                                      fontSize: 14),
                                  subtitle: MyText(
                                    text: "${listData[index]['nis']}",
                                    color: INPUT,
                                    fontSize: 12,
                                  ),
                                  leading: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: FirebasePicture(
                                      boxFit: BoxFit.cover,
                                      data: listData[index],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
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
          }),
    );
  }
}
