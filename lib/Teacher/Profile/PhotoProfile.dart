import 'package:flutter/material.dart';
import '../Home/HomeTeacher.dart';

class PhotoProfile extends StatefulWidget {
  const PhotoProfile({super.key});

  @override
  State<PhotoProfile> createState() => _PhotoProfileState();
}

class _PhotoProfileState extends State<PhotoProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BackButton(),
          Hero(
            tag: "pp",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(500),
              child: Container(
                width: width(context),
                child: Image(
                  image: NetworkImage(
                      "https://s3.getstickerpack.com/storage/uploads/sticker-pack/genshin-impact-keqing/sticker_7.png?405e4422ce30b3b6747d6b0b8ea4baf4&d=200x200"),
                      fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
