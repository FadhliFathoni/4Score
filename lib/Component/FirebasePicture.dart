import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/main.dart';
import 'package:transparent_image/transparent_image.dart';

class FirebasePicture extends StatefulWidget {
  FirebasePicture({
    super.key,
    required this.boxFit,
    required this.picture,
  });
  final String picture;
  final BoxFit boxFit;

  @override
  State<FirebasePicture> createState() => _FirebasePictureState();
}

class _FirebasePictureState extends State<FirebasePicture> {
  Future<String> getImage(String image) async {
    String awaitImage = await image;
    if (awaitImage.isEmpty || awaitImage == "") {
      return "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjCX5TOKkOk3MBt8V-f8PbmGrdLHCi4BoUOs_yuZ1pekOp8U_yWcf40t66JZ4_e_JYpRTOVCl0m8ozEpLrs9Ip2Cm7kQz4fUnUFh8Jcv8fMFfPbfbyWEEKne0S9e_U6fWEmcz0oihuJM6sP1cGFqdJZbLjaEQnGdgJvcxctqhMbNw632OKuAMBMwL86/s414/pp%20kosong%20wa%20default.jpg";
    } else {
      String imageUrl = 'gs://score-49de5.appspot.com/';
      final ref = FirebaseStorage.instance.refFromURL(imageUrl + image);
      final url = await ref.getDownloadURL();
      return url;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getImage(widget.picture),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.network(
            snapshot.data!,
            fit: widget.boxFit,
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
