import 'package:flutter/material.dart';
import 'package:fourscore/Component/MyTextField.dart';
import 'package:fourscore/Component/Text/MyText.dart';

class ProfileTextField extends StatelessWidget {
  ProfileTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 335),
      margin: EdgeInsets.symmetric(vertical: 8.5, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: MyText(
              text: title,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
          MyTextField(
            controller: controller,
            hintText: hintText,
          ),
        ],
      ),
    );
  }
}
