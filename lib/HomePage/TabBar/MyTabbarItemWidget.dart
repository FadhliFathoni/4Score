import 'package:flutter/material.dart';
import 'package:fourscore/main.dart';
import 'package:hexcolor/hexcolor.dart';

class MyTabbarItemWidget extends StatefulWidget {
  late final bool isSelected;
  late final IconData icon;
  final Function? onItemPressed;
  late final Color itemNormalColor;
  late final Color itemSelectedColor;
  late final Color itemBackgroundColor;
  MyTabbarItemWidget({
    required this.isSelected,
    required this.icon,
    this.onItemPressed,
    required this.itemBackgroundColor,
    required this.itemSelectedColor,
    required this.itemNormalColor,
  });
  @override
  _MyTabbarItemWidgetState createState() => _MyTabbarItemWidgetState();
}

class _MyTabbarItemWidgetState extends State<MyTabbarItemWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInCubic),
    );
    animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _backgroundColor = widget.itemSelectedColor;
    final _iconColor = (widget.isSelected == false)
        ? widget.itemNormalColor
        : widget.itemBackgroundColor;
    final _backgroundSize = (widget.isSelected == false) ? 0.0 : 50.0;
    return Container(
      child: Stack(
        children: [
          // Positioned(
          //     bottom: 0,
          //     child: Transform.translate(
          //       offset: Offset(animationController.value, 0),
          //       child: Container(
          //         color: PRIMARY_COLOR,
          //         height: 5,
          //         width: _backgroundSize,
          //       ),
          //     )
          //     // AnimatedContainer(
          //     //   duration: Duration(
          //     //     milliseconds: 200,
          //     //   ),
          //     //   width: _backgroundSize * 0.8,
          //     //   height: 5,
          //     //   curve: Curves.easeInOutCubic,
          //     //   decoration: BoxDecoration(
          //     //     color: PRIMARY_COLOR,
          //     //     borderRadius: BorderRadius.circular(10.0),
          //     //   ),
          //     // ),
          //     ),
          Container(
            child: IconButton(
                icon: Icon(
                  widget.icon,
                  color: (widget.isSelected == false)
                      ? HexColor("#FFFFFF")
                      : PRIMARY_COLOR,
                ),
                onPressed: () {
                  if (widget.onItemPressed != null) {
                    widget.onItemPressed!();
                  }
                }),
          ),
        ],
      ),
    );
  }
}
