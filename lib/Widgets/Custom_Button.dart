// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:storeapp/data/constant.dart';

class Custom_Button extends StatelessWidget {
  const Custom_Button({
    super.key,
    required this.text,
    this.onPress,
  });
  final String text;
  final VoidCallback? onPress;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: ContaierColor, borderRadius: BorderRadius.circular(20)),
        child: TextButton(
            onPressed: onPress,
            child: Text(
              text,
              style:const TextStyle(color: Colors.white),
            )));
  }
}
