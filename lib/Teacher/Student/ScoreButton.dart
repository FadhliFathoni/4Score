import 'package:flutter/material.dart';
import 'package:fourscore/main.dart';

class ScoreButton extends StatelessWidget {
  const ScoreButton({
    Key? key,
    required this.onMinusPressed,
    required this.onPlusPressed,
  }) : super(key: key);

  final VoidCallback onMinusPressed;
  final VoidCallback onPlusPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: onMinusPressed,
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
          GestureDetector(
            onTap: onPlusPressed,
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

