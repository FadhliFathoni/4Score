import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Component/myDialog.dart';
import 'package:fourscore/Teacher/Class/CardClass.dart';
import 'package:fourscore/Teacher/Class/TeacherAppBar.dart';
import 'package:fourscore/Teacher/Search/SearchSiswa.dart';
import 'package:fourscore/main.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({Key? key});

  @override
  State<ClassPage> createState() => _ClassPageState();
}

double height(BuildContext context) => MediaQuery.of(context).size.height;
double width(BuildContext context) => MediaQuery.of(context).size.width;

class _ClassPageState extends State<ClassPage> {
  final searchBarKelas = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  String searchQuery = '';
  List<String> uniqueClasses = [];
  Map<String, int> classCounts = {};

  @override
  void initState() {
    super.initState();
    fetchClassCounts();
  }

  void fetchClassCounts() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection("siswa");

    collection.orderBy("class").get().then((snapshot) {
      List<DocumentSnapshot> documents = snapshot.docs;

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

      setState(() {});
    }).catchError((error) {
      print('Error fetching class counts: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BG_COLOR,
      appBar: TeacherAppBar(
        NotificationIcon(),
      ),
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowGlow();
          return false;
        },
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                width: width(context) * 9 / 10,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Lexend",
                  ),
                  cursorColor: PRIMARY_COLOR,
                  decoration: InputDecoration(
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.search,
                        color: INPUT,
                        size: 30,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: SECONDARY_COLOR),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: SECONDARY_COLOR),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    fillColor: SECONDARY_COLOR,
                    filled: true,
                    hintText: " Search",
                    contentPadding: EdgeInsets.only(left: 20),
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontFamily: "Lexend",
                      color: INPUT,
                    ),
                  ),
                  controller: searchBarKelas,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              ),
              Container(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: uniqueClasses.length,
                  itemBuilder: (context, index) {
                    final className = uniqueClasses[index];
                    final classCount = classCounts[className] ?? 0;

                    if (searchQuery.isNotEmpty &&
                        !className
                            .toUpperCase()
                            .contains(searchQuery.toUpperCase())) {
                      // Skip the class if it doesn't match the search query
                      return Container();
                    }

                    return CardClass(
                      uniqueClasses: uniqueClasses,
                      classCounts: classCount,
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        myDialog(context, "Coming soon");
      },
      child: Container(
        margin: EdgeInsets.only(left: 10),
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: SECONDARY_COLOR,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.notifications_none_outlined,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
