// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:storeapp/Screens/Favourite_screen.dart';
import 'package:storeapp/Screens/SearchPage.dart';
import 'package:storeapp/Screens/homePage.dart';
import 'package:storeapp/data/constant.dart';

class NavigationbarStatus extends StatefulWidget {
  const NavigationbarStatus({super.key});

  @override
  State<NavigationbarStatus> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<NavigationbarStatus> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const Homepage(),
    const Searchpage(),
    const FavouriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        labels: const ["Home", "Search", "Favourite"],
        initialSelectedTab: "Home",
        icons: const [
          Icons.home,
          Icons.search_sharp,
          FontAwesomeIcons.heart,
        ],
        tabSize: 50,
        tabBarColor:ContaierColor,
        tabSelectedColor:ContaierColor,
        tabIconColor: iconColor,
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        onTabItemSelected: (int index) => setState(() => _selectedIndex = index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:storeapp/Screens/SearchPage.dart';
import 'package:storeapp/Screens/UpdateproductPage.dart';
import 'package:storeapp/Screens/homePage.dart';
import 'package:storeapp/data/constant.dart';

class NavigationbarStatus extends StatefulWidget {
  const NavigationbarStatus({super.key});

  @override
  State<NavigationbarStatus> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<NavigationbarStatus> {
  int _selectedIndex = 0;
  List<Widget> pages = [
    const Homepage(),
    const Searchpage(),
    const UpdateProductPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return 
  }
 */
