import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Student/HomePage/Home/AppBar/StudentAppBar.dart';
import 'package:fourscore/main.dart';

class UserProfileAppBar extends StatelessWidget {
  final CollectionReference collection;
  final User user;

  UserProfileAppBar({
    required this.collection,
    required this.user,
  });

  var mySnapshot;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: collection.where("email", isEqualTo: user.email).get(),
        builder: (context, futureSnapshot) {
          try {
            if (futureSnapshot.hasData) {
              var id = futureSnapshot.data!.docs.first.id;
              return StreamBuilder(
                stream: collection.doc(id).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    mySnapshot = snapshot;
                    try {
                      var data = snapshot.data!.data();
                      String picture =
                          (data as Map<String, dynamic>)['picture'];
                      return StudentAppBar(picture: picture, snapshot: snapshot,);
                    } catch (e) {
                      return StudentAppBar(picture: "", snapshot: snapshot,);
                    }
                  } else if (snapshot.hasError) {
                    return Text("There's an error");
                  } else {
                    return SizedBox();
                  }
                },
              );
            } else if (futureSnapshot.hasError) {
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
          } catch (e) {
            return StudentAppBar(picture: "", snapshot: mySnapshot,);
          }
        });
  }
}
