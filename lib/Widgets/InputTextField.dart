import 'package:flutter/material.dart';
import 'package:storeapp/data/constant.dart';

// ignore: must_be_immutable
class inputTextfiled extends StatelessWidget {
  inputTextfiled({
    super.key,
    this.username,
    this.iconData,
  });
  String? username;
  IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        label: Text(
          username!,
          style: TextStyle(color: TextIconColor, fontSize: 18),
        ),
        prefixIcon: Icon(
          iconData,
          color: TextIconColor,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ContaierColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ContaierColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ContaierColor),
        ),
        enabled: true,
      ),
    );
  }
}
