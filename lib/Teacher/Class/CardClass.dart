import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Teacher/Search/SearchSiswa.dart';
import 'package:fourscore/main.dart';

class CardClass extends StatelessWidget {
  const CardClass({
    Key? key,
    required this.uniqueClasses,
    required this.classCounts,
    required this.index,
  }) : super(key: key);

  final List<String> uniqueClasses;
  final int classCounts;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return SearchPage(
              Class: uniqueClasses[index],
            );
          }),
        );
      },
      child: Container(
        width: width(context) * 9 / 10,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        height: 75,
        decoration: BoxDecoration(
          color: SECONDARY_COLOR,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: uniqueClasses[index],
                  color: PRIMARY_COLOR,
                  fontSize: 14,
                ),
                MyText(
                  text: "${classCounts ?? 0} person",
                  color: INPUT,
                  fontSize: 12,
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_sharp,
              color: PRIMARY_COLOR,
            ),
          ],
        ),
      ),
    );
  }
}
