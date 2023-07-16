import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/main.dart';

void myDialog(BuildContext context, String text) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      Timer(Duration(seconds: 2), () {
        Navigator.pop(context);
      });
      return AlertDialog(
        backgroundColor: SECONDARY_COLOR,
        title: Center(
          child: MyText(
            text: text,
            color: PRIMARY_COLOR,
          ),
        ),
      );
    },
  );
}
