import 'package:flutter/material.dart';
import 'package:fourscore/Component/Text/MyText.dart';
import 'package:fourscore/Component/myDialog.dart';
import 'package:fourscore/main.dart';

AppBar TeacherAppBar(
    BuildContext context, Widget leading, List<Widget> actions) {
  return AppBar(
    title: MyText(text: "4Score"),
    centerTitle: true,
    backgroundColor: BG_COLOR,
    elevation: 0,
    leading: leading,
    actions: actions
  );
}

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        myDialog(context, "Coming soon");
      },
      child: Container(
        margin: EdgeInsets.only(left: 10),
        padding: EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: SECONDARY_COLOR,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.notifications_none_outlined,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
