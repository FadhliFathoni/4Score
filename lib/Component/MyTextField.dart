import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyTextField extends StatelessWidget {
  MyTextField({super.key, required this.controller, required this.hintText});

  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: HexColor("#2D2F3A"), borderRadius: BorderRadius.circular(10)),
      child: TextField(
        cursorColor: HexColor("#7C7C7C"),
        controller: controller,
        style: TextStyle(
          fontFamily: "Lexend",
          color: HexColor("#7C7C7C"),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: "Lexend",
            color: HexColor("#7C7C7C"),
          ),
          fillColor: HexColor("#7C7C7C"),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: HexColor("#FFFFFF").withOpacity(0.4),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: HexColor("#FFFFFF").withOpacity(0.4),
            ),
          ),
        ),
      ),
    );
  }
}
