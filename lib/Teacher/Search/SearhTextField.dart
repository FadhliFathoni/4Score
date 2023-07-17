import 'package:flutter/material.dart';
import 'package:fourscore/main.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    Key? key,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * 9 / 10,
      child: TextField(
        style: TextStyle(
          color: Colors.white,
          fontFamily: "Lexend",
        ),
        cursorColor: PRIMARY_COLOR,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.search,
              color: INPUT,
              size: 30,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: SECONDARY_COLOR),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: SECONDARY_COLOR),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: SECONDARY_COLOR,
          filled: true,
          hintText: " Search",
          contentPadding: EdgeInsets.only(left: 20),
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: INPUT,
          ),
        ),
        controller: controller,
        onChanged: onChanged,
      ),
    );
  }
}
