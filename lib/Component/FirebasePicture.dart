import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/main.dart';

class FirebasePicture extends StatelessWidget {
  FirebasePicture({
    super.key,
    required this.boxFit,
    required this.data,
  });
  final dynamic data;
  final BoxFit boxFit;
  // String? email = FirebaseAuth.instance.currentUser!.email;

  Future<String> getImage(String image) async {
    String imageUrl = 'gs://score-49de5.appspot.com/';
    try {
      final ref = FirebaseStorage.instance.refFromURL(imageUrl + image);
      final url = await ref.getDownloadURL();
      print(url);
      return url;
    } catch (e) {
      return "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjCX5TOKkOk3MBt8V-f8PbmGrdLHCi4BoUOs_yuZ1pekOp8U_yWcf40t66JZ4_e_JYpRTOVCl0m8ozEpLrs9Ip2Cm7kQz4fUnUFh8Jcv8fMFfPbfbyWEEKne0S9e_U6fWEmcz0oihuJM6sP1cGFqdJZbLjaEQnGdgJvcxctqhMbNw632OKuAMBMwL86/s414/pp%20kosong%20wa%20default.jpg";
    }
  }

  Future<String> image() {
    try {
      if (data != null && data['picture'] != null) {
        return getImage(data['picture']);
      } else {
        return getImage("");
      }
    } catch (e) {
      return getImage("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: image(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.network(
            snapshot.data!,
            fit: boxFit,
          );
        } else if (snapshot.hasError) {
          return Text("There's an error");
        } else {
          return CircularProgressIndicator(
            color: PRIMARY_COLOR,
          );
        }
      },
    );
  }
}
