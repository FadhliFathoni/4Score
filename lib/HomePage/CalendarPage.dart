// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/main.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width(context),
        height: height(context),
        color: BG_COLOR,
        child: Column(
          children: [
            TableCalendar(
              focusedDay: today,
              firstDay: DateTime(2020),
              lastDay: DateTime(2030),
              headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(color: Colors.white),
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
              formatAnimationCurve: Curves.bounceOut,
              formatAnimationDuration: Duration(milliseconds: 500),
              calendarStyle: CalendarStyle(
                  holidayTextStyle:
                      TextStyle(color: Colors.red, fontFamily: "Lexend"),
                  defaultTextStyle:
                      TextStyle(color: Colors.white, fontFamily: "Lexend"),
                  weekendTextStyle:
                      TextStyle(color: Colors.red, fontFamily: "Lexend"),
                  todayTextStyle:
                      TextStyle(color: SECONDARY_COLOR, fontFamily: "Lexend"),
                  todayDecoration: BoxDecoration(
                      color: PRIMARY_COLOR, shape: BoxShape.circle),
                  isTodayHighlighted: true),
              availableGestures: AvailableGestures.all,
              currentDay: today,
            ),
            Divider(
              height: 20,
              color: SECONDARY_COLOR,
            ),
            Row(
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
                    text: "Libur semester ganjil",
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
