import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Teacher/Class/TeacherAppBar.dart';
import 'package:fourscore/Teacher/Search/CardStudent.dart';
import 'package:fourscore/Teacher/Search/SearhTextField.dart';
import 'package:fourscore/Teacher/Student/StudentPage.dart';
import 'package:fourscore/main.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, required this.Class}) : super(key: key);
  final String Class;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchBarSiswa = TextEditingController();
  var searchQuery = "";
  var listData = [];

  @override
  void initState() {
    fetchStudent();
    super.initState();
  }

  void fetchStudent() {
    final firestore = FirebaseFirestore.instance;
    final collection = firestore.collection("siswa");

    collection.where("class", isEqualTo: widget.Class).get().then((snapshot) {
      var documents = snapshot.docs;

      documents.forEach((element) {
        listData.add(element.data());
      });

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final collection = firestore.collection("siswa");
    return Scaffold(
      backgroundColor: BG_COLOR,
      appBar: TeacherAppBar(BackButton(
        color: Colors.white,
      )),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: FutureBuilder(
          future: collection.where("class", isEqualTo: widget.Class).get(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: SearchTextField(
                        controller: searchBarSiswa,
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        }),
                  ),
                  SizedBox(height: 15),
                  Container(
                    alignment: Alignment.center,
                    width: width(context) * 9 / 10,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listData.length,
                      itemBuilder: (BuildContext context, int index) {
                        String name =
                            listData[index]['name'].toString().toUpperCase();
                        String nis = listData[index]['nis'].toString();
                        if (searchQuery.isNotEmpty &&
                            !name.contains(searchQuery.toUpperCase()) &&
                            !nis.contains(searchQuery)) {
                          return Container();
                        }
                        return CardStudent(
                          listData: listData,
                          index: index,
                          snapshot: snapshot,
                        );
                      },
                    ),
                  ),
                ],
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

