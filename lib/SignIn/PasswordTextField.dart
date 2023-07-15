// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PasswordTextField extends StatelessWidget {
  PasswordTextField(
      {super.key,
      required this.controller,
      this.obscureText,
      required this.onPressed});

  final TextEditingController controller;
  bool? obscureText = true;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HexColor("#2D2F3A"),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      child: TextField(
        cursorColor: HexColor("#7C7C7C"),
        controller: controller,
        style: TextStyle(
          fontFamily: "Lexend",
          color: HexColor("#7C7C7C"),
        ),
        obscureText: obscureText!,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: (obscureText == true)
                ? Icon(Icons.remove_red_eye)
                : Icon(Icons.remove_red_eye_outlined),
            color: HexColor("#7C7C7C"),
            onPressed: onPressed,
          ),
          hintText: "Password",
          hintStyle: TextStyle(
            fontFamily: "Lexend",
            color: HexColor("#7C7C7C"),
          ),
          fillColor: HexColor("#7C7C7C"),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: HexColor("#FFFFFF").withOpacity(0.4),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
            borderSide: BorderSide(
              color: HexColor("#FFFFFF").withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }
}
