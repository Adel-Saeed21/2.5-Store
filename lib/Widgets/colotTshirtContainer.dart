// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:storeapp/data/constant.dart';

class ColorTshirtContainer extends StatelessWidget {
  const ColorTshirtContainer({
    super.key,
    required this.imageName,
    required this.onpressed,
    required this.changecolor,
  });
  final String imageName;
  final VoidCallback onpressed;
  final bool changecolor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: onpressed,
        child: Align(
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: changecolor ? Colors.red : IconColor,
                ),
                borderRadius: BorderRadius.circular(10),
                color: IconColor),
            child: Image.asset(imageName),
          ),
        ),
      ),
    );
  }
}
