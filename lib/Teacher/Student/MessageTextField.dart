import 'package:flutter/material.dart';
import 'package:fourscore/main.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({Key? key, required this.controller})
      : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * 9 / 10,
      height: 100,
      decoration: BoxDecoration(
        color: SECONDARY_COLOR,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        cursorColor: PRIMARY_COLOR,
        style: TextStyle(color: Colors.white, fontFamily: "Lexend"),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: SECONDARY_COLOR)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: SECONDARY_COLOR)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText: "Type something...",
          contentPadding: EdgeInsets.only(left: 20),
          hintStyle: TextStyle(color: INPUT, fontFamily: "Lexend"),
        ),
        controller: controller,
      ),
    );
  }
}
