import 'package:biggertask/routes/explore_route.dart';
import 'package:biggertask/routes/user_info_route.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class HomepageBaseRoute extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HomepageBaseRouteState();
}

class _HomepageBaseRouteState extends State<HomepageBaseRoute> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    ExploreRoute(),
    UserInfoRoute()
  ];

  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.explore),
              label: '首页',

            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
              label: '我的'
            )
          ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

}
