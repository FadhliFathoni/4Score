import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/main.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(foregroundColor: PRIMARY_COLOR),
      onPressed: onPressed,
      child: MyText(
        text: text,
        color: PRIMARY_COLOR,
      ),
    );
  }
}
