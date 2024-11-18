import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:movie_video/presentation/main/home_page.dart';
import 'package:movie_video/presentation/main/movie/movie_page.dart';
import 'package:movie_video/presentation/main/notifications_page.dart';
import 'package:movie_video/presentation/main/profile_page.dart';
import 'package:movie_video/presentation/main/search_page.dart';
import 'package:movie_video/presentation/main/settings_page.dart';
import 'package:movie_video/presentation/resources/color_manager.dart';
import 'package:movie_video/presentation/resources/strings_manager.dart';
import 'package:movie_video/presentation/resources/value_manager.dart';
class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
   MoviePage(),
   SearchPage(),
   ProfilePage(),
   SettingsPage()
  ];
  List<String> title = [
    AppString.home,
    AppString.search,
    AppString.notification,
    AppString.settings
  ];

  var _title = AppString.home;
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(color: ColorManager.lightGrey, spreadRadius: AppSize.s1)
        ]),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorManager.black1,
          selectedItemColor: ColorManager.white,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: AppString.home),

            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: AppString.search),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: AppString.notification),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: AppString.settings),
          ],
        ),
      ),
    );
  }

  onTap(int index){
    setState(() {
      _currentIndex = index;
      _title = title[index];
    });
  }
}


