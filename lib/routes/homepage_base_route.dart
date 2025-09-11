import 'dart:convert';

import 'package:biggertask/common/static.dart';
import 'package:biggertask/l10n/app_localizations.dart';
import 'package:biggertask/pages/explore_route.dart';
import 'package:biggertask/routes/search_page.dart';
import 'package:biggertask/pages/my_info_route.dart';
import 'package:biggertask/routes/settings_route.dart';
import 'package:biggertask/widgets/keep_alive_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/github_user.dart';

class HomepageBaseRoute extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _HomepageBaseRouteState();
}

class _HomepageBaseRouteState extends State<HomepageBaseRoute> {
  int _selectedIndex = 0;
  bool _isInitialized = false;

  final List<Widget> _pages = [
    MyEventsRoute(),
    KeepAliveWrapper(child: MyInfoRoute())
  ];

  late PageController _pageController;
  late SharedPreferences pref;

  Future<void> _initSharedPreferences() async {

    final storage = FlutterSecureStorage(
        aOptions: AndroidOptions(
            encryptedSharedPreferences: true
        )
    );

    pref = await SharedPreferences.getInstance();
    Global.isLogin = pref.getBool('isLogin') ?? false;
    Global.token = await storage.read(key: 'github_token') ?? '';

    final userData = pref.getString('userData') ?? ''; // 字符串
    final userMap = userData.isNotEmpty ? jsonDecode(userData) : {}; // 解析 json 字符串成 map
    Global.gitHubUser = userMap.isNotEmpty ? GitHubUser.fromJson(userMap) : null; // 如果 map 不为空，则创建 GitHubUser 实例

    setState(() {
      _isInitialized = true;
    });

  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
    _initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        body: Center(
          child: SizedBox(),
        ),
      );
    }

    final List<String> titles = [
      AppLocalizations.of(context)!.bottomNavigationExplore,
      AppLocalizations.of(context)!.bottomNavigationMine,
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_selectedIndex]),
        actions: [
          if (_selectedIndex == 0) IconButton(
              onPressed: () {
                Get.to(() => SearchPage());
              },
              icon: Icon(Icons.search)
          ),
          if (_selectedIndex == 1) IconButton(
              onPressed: () {
                Get.to(() => SettingsRoute());
              }, 
              icon: Icon(Icons.settings)
          )
        ],
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
              label: AppLocalizations.of(context)!.bottomNavigationExplore,

            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
              label: AppLocalizations.of(context)!.bottomNavigationMine
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
