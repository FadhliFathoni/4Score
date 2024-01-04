import 'package:flutter/material.dart';
import 'package:fourscore/main.dart';

class ScoreButton extends StatefulWidget {
  ScoreButton({
    Key? key,
    required this.onMinusPressed,
    required this.onPlusPressed,
  }) : super(key: key);

  final VoidCallback onMinusPressed;
  final VoidCallback onPlusPressed;

  @override
  State<ScoreButton> createState() => _ScoreButtonState();
}

class _ScoreButtonState extends State<ScoreButton> {
  String? dropDownValue = "Terlambat";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PopupMenuButton<String>(
            initialValue: dropDownValue,
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("Terlambat"),
                  value: "Terlambat",
                ),
                PopupMenuItem(
                  child: Text("Tidak sopan"),
                  value: "Tidak sopan",
                ),
                PopupMenuItem(
                  child: Text("Melanggar peraturan"),
                  value: "Melanggar peraturan",
                ),
              ];
            },
            onSelected: (String value) {
              setState(() {
                dropDownValue = value;
              });
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: SECONDARY_COLOR,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.remove, color: PRIMARY_COLOR, size: 40),
            ),
          ),
          // GestureDetector(
          //   onTap: onMinusPressed,
          //   child: Container(
          //     width: 50,
          //     height: 50,
          //     decoration: BoxDecoration(
          //       color: SECONDARY_COLOR,
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     child: Icon(Icons.remove, color: PRIMARY_COLOR, size: 40),
          //   ),
          // ),
          GestureDetector(
            onTap: widget.onPlusPressed,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: SECONDARY_COLOR,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.add, color: PRIMARY_COLOR, size: 40),
            ),
          ),
        ],
      ),
    );
  }
}
