// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:storeapp/Screens/Profile.dart';
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
  List<Widget> pagess = [
    const Homepage(),

    const Searchpage(),
    const UpdateProductPage(),
    const Profile()
    // const Profilescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        labels: const ["Home", "Search", "Favourite", "Profile"],
        initialSelectedTab: "Home",
        icons: const [
          Icons.home,
          Icons.search_sharp, // Icon for Home tab
          FontAwesomeIcons.heart,
          Icons.person // Icon for Search tab

          // Icons.person,     // Icon for Profile tab
        ],
        tabSize: 50,
        tabBarColor: backgroundColor,
        tabSelectedColor: backgroundColor,
        tabIconColor: iconColor,
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        onTabItemSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: pagess[_selectedIndex],
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
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: backgroundColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Home"),
            selectedColor: Colors.white,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite_outline),
            title: const Text("Favorite"),
            selectedColor: Colors.redAccent,
          ),
          SalomonBottomBarItem(
            icon: const Icon(FontAwesomeIcons.cartShopping),
            title: const Text("Items"),
            selectedColor: Colors.blueAccent,
          ),
        ],
      ),
    );
  }
}
 */
