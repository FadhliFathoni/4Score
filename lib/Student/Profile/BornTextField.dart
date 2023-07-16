import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fourscore/Component/FormattedDateTime.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/main.dart';
import 'package:hexcolor/hexcolor.dart';

class BornTextField extends StatelessWidget {
  const BornTextField({
    super.key,
    required this.data,
    required this.born,
  });

  final dynamic data;
  final DateTime? born;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.5,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(text: "Born", color: Colors.white),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: SECONDARY_COLOR,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                  child: Icon(
                    Icons.calendar_month_outlined,
                    size: 32,
                    color: HexColor("#7C7C7C"),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                      color: SECONDARY_COLOR,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                    child: MyText(
                      text: (born != null)
                          ? formatDateTime(born!)
                          : (data != null)
                              ? formatDateTime(
                                  (data['born'] as Timestamp).toDate(),
                                )
                              : "Born",
                      color: HexColor("#7C7C7C"),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
