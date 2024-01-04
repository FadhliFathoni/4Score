import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/main.dart';

class NotifPage extends StatefulWidget {
  AsyncSnapshot<DocumentSnapshot<Object?>> snapshot;
  NotifPage({super.key, required this.snapshot});

  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  @override
  Widget build(BuildContext context) {
    var snapshot = widget.snapshot;
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection("siswa");
    // String id = collection.where("email", isEqualTo: user.email).get();
    return Scaffold(
        backgroundColor: BG_COLOR,
        appBar: AppBar(
          title: Text("Notifications"),
          centerTitle: true,
          leading: BackButton(),
          backgroundColor: BG_COLOR,
          elevation: 0,
        ),
        body: FutureBuilder(
            future: collection.where("email", isEqualTo: user!.email).get(),
            builder: (context, futureSnapshot) {
              if (futureSnapshot.hasData) {
                var documents = futureSnapshot.data!.docs;
                if (documents.isNotEmpty) {
                  var id = documents.first.id;
                  return StreamBuilder(
                    stream: collection
                        .doc(id)
                        .collection("notif")
                        .orderBy("date", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.size,
                          itemBuilder: (context, index) {
                            var data = snapshot.data!.docs[index].data();
                            if (data["type"] == "Pengurangan") {
                              return Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade500,
                                  border: Border.all(
                                    color: Colors.red.shade900,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 70,
                                child: KurangWidget(
                                    poin: data["poin"],
                                    dari: data["dari"],
                                    message: data["message"]),
                              );
                            } else {
                              return Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade500,
                                  border: Border.all(
                                    color: Colors.green.shade900,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 70,
                                child: TambahWidget(poin: data["poin"]),
                              );
                            }
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          "There's an error",
                          style: TextStyle(color: PRIMARY_COLOR),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: PRIMARY_COLOR,
                    ),
                  );
                }
              } else if (futureSnapshot.hasError) {
                print(futureSnapshot.error);
                return Text("There's an error");
              } else {
                return Container();
              }
            }));
  }
}

// class ScoreKurangWidget extends StatelessWidget {
//   final String message;
//   final String dari;
//   final int poin;

//   ScoreKurangWidget({
//     required this.message,
//     required this.dari,
//     required this.poin,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

class KurangWidget extends StatelessWidget {
  const KurangWidget({
    super.key,
    required this.poin,
    required this.dari,
    required this.message,
  });

  final int poin;
  final String dari;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(Icons.dangerous),
        ),
        Flexible(
          child: MyText(
            text:
                "Pengurangan score sebanyak $poin oleh guru $dari karena $message",
          ),
        ),
      ],
    );
  }
}

class TambahWidget extends StatelessWidget {
  const TambahWidget({
    super.key,
    required this.poin,
  });

  final int poin;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Icon(Icons.dangerous),
        ),
        Flexible(
          child: MyText(
            text: "Berhasil absensi mendapatkan $poin poin",
          ),
        ),
      ],
    );
  }
}
