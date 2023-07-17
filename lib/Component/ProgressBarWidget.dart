import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Student/HomePage/Home/MySimpleCircularProgressBar.dart';
import 'package:fourscore/main.dart';
import 'package:hexcolor/hexcolor.dart';

class ProgressBarWidget extends StatelessWidget {
  final CollectionReference collection;
  final User user;

  ProgressBarWidget({
    required this.collection,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: collection.where("email", isEqualTo: user.email).get(),
      builder: (context, futureSnapshot) {
        if (futureSnapshot.hasData) {
          try {
            var id = futureSnapshot.data!.docs.first.id;

            return StreamBuilder(
              stream: collection.doc(id).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.data() as Map<String, dynamic>;

                  return MySimpleCircularProgressBar(
                    animationDuration: 1500,
                    maxValue: 100,
                    progressColors: [PRIMARY_COLOR],
                    mergeMode: true,
                    backColor: HexColor("#FFFFFF"),
                    size: 250,
                    valueNotifier: ValueNotifier(
                      (data.isNotEmpty && data['score'] != null)
                          ? double.parse(data['score'].toString())
                          : 100.0,
                    ),
                    onGetText: (value) {
                      return Text("${value.toInt()}");
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("There's an error");
                } else {
                  return SizedBox();
                }
              },
            );
          } catch (e) {
            return MySimpleCircularProgressBar(
              animationDuration: 1500,
              maxValue: 100,
              progressColors: [PRIMARY_COLOR],
              mergeMode: true,
              backColor: HexColor("#FFFFFF"),
              size: 250,
              valueNotifier: ValueNotifier(100),
              onGetText: (value) {
                return Text("${value.toInt()}");
              },
            );
          }
        } else if (futureSnapshot.hasError) {
          return Text("There's an error");
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: PRIMARY_COLOR,
            ),
          );
        }
      },
    );
  }
}
