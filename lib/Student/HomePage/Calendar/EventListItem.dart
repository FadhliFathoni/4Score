import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Student/HomePage/Calendar/Utils.dart';
import 'package:fourscore/main.dart';

class EventListItem extends StatelessWidget {
  final Event event;

  const EventListItem({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            alignment: Alignment.center,
            height: 61,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: SECONDARY_COLOR,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  text: "16-20",
                  color: PRIMARY_COLOR,
                ),
                MyText(
                  text: "Jan",
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: 61,
            width: width(context) * 0.7,
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: SECONDARY_COLOR,
              borderRadius: BorderRadius.circular(15),
            ),
            child: MyText(
              text: "${event}",
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
