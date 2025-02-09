// ignore_for_file: file_names

import 'package:flutter/material.dart';

class UpdateProductPage extends StatelessWidget {
  const UpdateProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var backcolor = isDark ? Colors.black : Colors.white;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: backcolor,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: backcolor,
      body: const Column(
        children: [
          // CustomTextField()
        ],
      ),
    );
  }
}
