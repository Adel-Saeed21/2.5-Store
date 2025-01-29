import 'package:flutter/material.dart';
import 'package:storeapp/data/constant.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Searchpage> {
  @override
  Widget build(BuildContext context) {
    // bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // var bcolor = isDark ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
     
    );
  }
}
