// ignore_for_file: sort_child_properties_last, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers

library rounded_tabbar_widget;

import 'package:flutter/material.dart';
import 'package:fourscore/Component/TabBar/MyTabbarWidget.dart';
import 'package:fourscore/main.dart';

class MyTabBar extends StatefulWidget {
  final List<Widget>? pages;
  final List<IconData>? tabIcons;
  final Color? itemNormalColor;
  final Color? itemSelectedColor;
  final Color? tabBarBackgroundColor;
  final int selectedIndex;
  final Function? onTabItemIndexChanged;

  MyTabBar({
    @required this.pages,
    @required this.tabIcons,
    this.onTabItemIndexChanged,
    this.tabBarBackgroundColor = Colors.black87,
    this.itemSelectedColor = Colors.yellow,
    this.itemNormalColor = Colors.yellow,
    this.selectedIndex = 0,
  });

  @override
  _MyTabBarState createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> with TickerProviderStateMixin {
  late TabController _tabController;
  late List<Widget> _pages;
  late List<IconData> _tabIcons;

  late final Color _itemNormalColor;
  late final Color _itemSelectedColor;
  late final Color _tabBarBackgroundColor;

  late AnimationController animationController;
  late Animation animation;

  late int _selectedIndex;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );

    animationController.addListener(() {
      setState(() {});
    });

    super.initState();
    //Check for pages length.
    _pages = widget.pages ?? [];
    _tabIcons = widget.tabIcons ?? [];
    _selectedIndex = widget.selectedIndex;
    _itemNormalColor = widget.itemNormalColor ?? Colors.yellow;
    _itemSelectedColor = widget.itemSelectedColor ?? Colors.yellow;
    _tabBarBackgroundColor = widget.tabBarBackgroundColor ?? Colors.black87;
    assert(
        _pages.length > 0 &&
            _pages.length < 6 &&
            _tabIcons.length == _pages.length,
        'Please set valid number of pages for tabs. You assign maximum. of 5 pages and minimum of 1 page to Rounded Tabbar.');
    _setupTabbarController();
  }

  void _setupTabbarController() {
    _tabController = new TabController(length: _pages.length, vsync: this);
    _tabController.index = _selectedIndex;
    _tabController.animation?.addListener(() => _animateTabbarOnScroll());
  }

  void _animateTabbarOnScroll() {
    //Since Animation Value switches between 0 and 1, We extract the mid value, where we can begin animation.
    final double _currentAnimationValue =
        _tabController.animation?.value ?? 0.0;
    final double _animationValue = (_currentAnimationValue * 10.0) - 10.0;
    final _modValue = ((_currentAnimationValue / 10) * 10).toInt();
    int _value = (_animationValue % 10).toInt().abs();

    if (_value == 5) {
      if (_modValue >= _tabController.index) {
        setState(() {
          _selectedIndex = _modValue + 1;
        });
      } else {
        setState(() {
          _selectedIndex = _modValue;
        });
      }
    }
    if (_tabController.indexIsChanging &&
        _tabController.previousIndex != _tabController.index) {
      if (animationController.isCompleted) {
        animationController.reverse();
      } else {
        animationController.forward();
      }
      if (widget.onTabItemIndexChanged != null) {
        widget.onTabItemIndexChanged!(_tabController.index);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            TabBarView(
              controller: _tabController,
              children: _pages,
            ),
            Positioned(
              child: MyTabbarWidget(
                tabIcons: _tabIcons,
                selectedIndex: _selectedIndex,
                itemNormalColor: _itemNormalColor,
                itemSelectedColor: _itemSelectedColor,
                tabBarBackgroundColor: _tabBarBackgroundColor,
                tabBarSelected: (int index) {
                  setState(() {
                    _tabController.index = index;
                    _selectedIndex = index;
                  });
                },
              ),
              bottom: 30.0,
            ),
            Positioned(
              bottom: 30,
              child: Transform.translate(
                offset: Offset(-25 + (animationController.value * 50), 0),
                child: Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
