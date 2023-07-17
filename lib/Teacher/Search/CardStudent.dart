import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/FirebasePicture.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Teacher/Student/StudentPage.dart';
import 'package:fourscore/main.dart';

class CardStudent extends StatelessWidget {
  CardStudent({
    super.key,
    required this.listData,
    required this.index,
    required this.snapshot,
  });

  final List listData;
  final int index;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
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
            color: SECONDARY_COLOR, borderRadius: BorderRadius.circular(5)),
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
            leading: Container(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(360),
                child: FirebasePicture(
                  boxFit: BoxFit.cover,
                  picture: listData[index]['picture'] ?? "",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
