// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:storeapp/data/constant.dart';

class CategoriezIcon extends StatelessWidget {
  const CategoriezIcon({
    super.key,
    this.data,
    required this.text,
  });
  final String? data;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        
        children: [
          Container(
            margin:const EdgeInsets.only(right: 10),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: TextIconColor,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset(
                    data!,
                    fit: BoxFit.contain,
                  ))),
          Text(
            text,
            style: TextStyle(
                color: TextIconColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
