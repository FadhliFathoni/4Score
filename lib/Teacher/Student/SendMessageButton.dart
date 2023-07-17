import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/main.dart';

class SendMessageButton extends StatelessWidget {
  const SendMessageButton({Key? key, required this.onPressed})
      : super(key: key);

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * 9 / 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              side: BorderSide(width: 1, color: Colors.black),
              backgroundColor: PRIMARY_COLOR,
              primary: Colors.black,
            ),
            child: MyText(text: "Send", color: Colors.black, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
