import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/Permissions.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Component/myDialog.dart';
import 'package:fourscore/Student/HomePage/Home/QrView.dart';
import 'package:fourscore/main.dart';

class AbsentButton extends StatelessWidget {
  final CollectionReference collection;
  final User user;
  const AbsentButton({super.key, required this.collection, required this.user});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: collection.where("email", isEqualTo: user.email).get(),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.hasData) {
            var documents = futureSnapshot.data!.docs;
            if (documents.isNotEmpty) {
              var id = documents.first.id;
              return StreamBuilder(
                stream: collection.doc(id).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return AbsentButtonLogin(
                      user: user!,
                      collection: collection,
                      futureSnapshot: futureSnapshot,
                    );
                  } else if (snapshot.hasError) {
                    return Text("There's an error");
                  } else {
                    return Container();
                  }
                },
              );
            } else {
              return AbsentButtonDontLogin();
            }
          } else if (futureSnapshot.hasError) {
            print(futureSnapshot.error);
            return Text("There's an error");
          } else {
            return Container();
          }
        });
  }
}

class AbsentButtonLogin extends StatefulWidget {
  const AbsentButtonLogin({
    super.key,
    required this.user,
    required this.collection,
    required this.futureSnapshot,
  });

  final User user;
  final CollectionReference<Object?> collection;
  final AsyncSnapshot<QuerySnapshot<Object?>> futureSnapshot;

  @override
  State<AbsentButtonLogin> createState() => _AbsentButtonLoginState();
}

class _AbsentButtonLoginState extends State<AbsentButtonLogin> {
  Color bg_color = BG_COLOR;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Permissions().checkPermission();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return QRViewExample(
                user: widget.user,
                collections: widget.collection,
                futureSnapshot: widget.futureSnapshot,
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: height(context) * 0.1),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        width: width(context) * 9 / 10,
        decoration: BoxDecoration(
            color: SECONDARY_COLOR,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 10,
                offset: Offset(1, 1),
              ),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.document_scanner_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: MyText(
                    text: "Absent",
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

class AbsentButtonDontLogin extends StatelessWidget {
  const AbsentButtonDontLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        myDialog(context, "Fill the profile first");
      },
      child: Container(
        margin: EdgeInsets.only(top: height(context) * 0.1),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        width: width(context) * 9 / 10,
        decoration: BoxDecoration(
          color: SECONDARY_COLOR,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.document_scanner_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: MyText(
                    text: "Absent",
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
