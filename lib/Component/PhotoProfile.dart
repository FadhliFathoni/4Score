import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/FirebasePicture.dart';
import 'package:fourscore/main.dart';

class PhotoProfile extends StatelessWidget {
  PhotoProfile({
    super.key,
    required this.picture,
    this.pickedFile,
    this.size,
  });

  PlatformFile? pickedFile;
  final String picture;
  double? size = 118;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(360),
        child: (pickedFile == null)
            ? FirebasePicture(
                picture: picture,
                boxFit: BoxFit.cover,
              )
            : Image.file(
                File(pickedFile!.path!),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
