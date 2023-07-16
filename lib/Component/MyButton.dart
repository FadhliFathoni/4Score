import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/main.dart';

class MyButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  Color? background = PRIMARY_COLOR;
  Color? foreground = Colors.black;
  double? Width;
  double? Height;
  MyButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.Width,
      this.Height,
      this.foreground,
      this.background});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (Width == null) ? width(context) : Width,
      height: (Height == null) ? 60 : Height,
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
          foregroundColor: foreground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
