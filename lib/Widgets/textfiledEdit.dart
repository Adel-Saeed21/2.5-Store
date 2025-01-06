import 'package:flutter/material.dart';

import 'package:storeapp/data/constant.dart';

// ignore: must_be_immutable
class TextfiledEdit extends StatelessWidget {
  const TextfiledEdit(
      {super.key,
      required this.word,
      required this.width,
      required this.input,
      this.validator,
      this.onChanged});
  final String word;
  final double width;
  final TextInputType input;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 120,
      child: TextFormField(
        keyboardType: input,
        style: TextStyle(color: textIconColor),
        decoration: InputDecoration(
          hintMaxLines: 1,
          fillColor: textIconColor,
          focusColor: textIconColor,
          label: Text(word),
          hoverColor: textIconColor,
          labelStyle: TextStyle(color: textIconColor, fontSize: 18),
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
        ),
      ),
    );
  }
}
