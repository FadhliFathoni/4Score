import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  String text;
  Color? color = Colors.black;
  double? fontSize = 14;
  FontWeight? fontWeight = FontWeight.normal;
  TextAlign? textAlign = TextAlign.left;

  MyText(
      {super.key,
      required this.text,
      this.color,
      this.fontSize,
      this.fontWeight,
      this.textAlign
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: "Lexend",
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }
}
