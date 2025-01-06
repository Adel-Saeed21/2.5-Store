import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
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
    Homepage(),

    const Searchpage(),
    const UpdateProductPage(),
    // const Profilescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MotionTabBar(
        labels: const ["Home", "Search", "Items"],
        initialSelectedTab: "Home",
        icons: const [
          Icons.home,
          FontAwesomeIcons.searchengin, // Icon for Home tab
          FontAwesomeIcons.cartShopping, // Icon for Search tab

          // Icons.person,     // Icon for Profile tab
        ],
        tabSize: 50,
        tabBarColor: BackgroundColor,
        tabSelectedColor: BackgroundColor,
        tabIconColor: IconColor,
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
