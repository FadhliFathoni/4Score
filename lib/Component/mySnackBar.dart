import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';

void mySnackBar(BuildContext context, String text, Color? color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: MyText(
        text: text,
        color: Colors.white,
      ),
    ),
  );
}
