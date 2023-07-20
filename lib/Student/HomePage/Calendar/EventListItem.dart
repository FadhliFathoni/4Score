import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Student/HomePage/Calendar/Utils.dart';
import 'package:fourscore/main.dart';
import 'package:intl/intl.dart';

class EventListItem extends StatelessWidget {
  final DateTime date;
  final Event event;

  const EventListItem({Key? key, required this.event, required this.date})
      : super(key: key);

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
                  text: DateFormat('d').format(date),
                  color: PRIMARY_COLOR,
                ),
                MyText(
                  text: DateFormat('MMM').format(date),
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
