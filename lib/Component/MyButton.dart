import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/main.dart';

class MyButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  Color? background = PRIMARY_COLOR;
  MyButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      height: 60,
      constraints: BoxConstraints(maxWidth: 335),
      child: ElevatedButton(
        onPressed: onPressed,
        child: MyText(
          text: text,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
