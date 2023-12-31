import 'package:flutter/material.dart';
import 'package:fourscore/Component/TabBar/MyTabbarItemWidget.dart';

class MyTabbarWidget extends StatefulWidget {
  final int selectedIndex;
  late final Color itemNormalColor;
  late final Color itemSelectedColor;
  late final Color tabBarBackgroundColor;
  final Function? tabBarSelected;
  final List<IconData> tabIcons;
  MyTabbarWidget({
    this.selectedIndex = 0,
    this.tabBarSelected,
    required this.tabBarBackgroundColor,
    required this.itemSelectedColor,
    required this.itemNormalColor,
    required this.tabIcons,
  });
  @override
  _MyTabbarWidgetState createState() => _MyTabbarWidgetState();
}

class _MyTabbarWidgetState extends State<MyTabbarWidget> {
  late int _selectedTabbarMenuIndex;
  late List<IconData> _tabIcons;
  final double _defaultHorizontalPadding = 20.0;

  @override
  void initState() {
    super.initState();
    _selectedTabbarMenuIndex = widget.selectedIndex;
    _tabIcons = widget.tabIcons;
  }

  void _onTabItemPressed({required int tabItemIndex}) {
    setState(() {
      _selectedTabbarMenuIndex = tabItemIndex;
      if (widget.tabBarSelected != null) {
        widget.tabBarSelected!(tabItemIndex);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _selectedTabbarMenuIndex = widget.selectedIndex;
    final double _maxWidth = MediaQuery.of(context).size.width;
    double _containerWidth = _maxWidth - (_defaultHorizontalPadding * 2.0);
    _containerWidth = (_containerWidth > 480.0) ? 480.0 : _containerWidth;

    final _marginOffset = (_maxWidth - _containerWidth) / 2.0;
    return Container(
      margin: EdgeInsets.only(
        right: _marginOffset,
        left: _marginOffset,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: widget.tabBarBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 10,
              offset: Offset(1, 1),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.90),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: (_tabIcons.length == 1)
              ? MainAxisAlignment.center
              : MainAxisAlignment.spaceBetween,
          children: _getTabbarItems(),
        ),
      ),
    );
  }

  List<Widget> _getTabbarItems() {
    List<Widget> _tabItems = [];
    for (var i = 0; i < _tabIcons.length; i++) {
      final _tabItem = MyTabbarItemWidget(
        itemBackgroundColor: widget.tabBarBackgroundColor,
        itemNormalColor: widget.itemNormalColor,
        itemSelectedColor: widget.itemSelectedColor,
        isSelected: (_selectedTabbarMenuIndex == i),
        icon: _tabIcons[i],
        onItemPressed: () => _onTabItemPressed(
          tabItemIndex: i,
        ),
      );
      _tabItems.add(_tabItem);
    }
    return _tabItems;
  }
}
