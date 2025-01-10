// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:storeapp/Screens/itemsOfCategories.dart';
import 'package:storeapp/Widgets/productOutAPI.dart';
import 'package:storeapp/data/constant.dart';

class CategoriezIcon extends StatelessWidget {
  const CategoriezIcon(
      {super.key, this.data, required this.text, required this.listItems, });
  final String? data;
  final String text;
  final List<Productoutapi> listItems;
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => Itemsofcategories(lists:listItems,name: text,)));
            },
            child: Container(
                margin: const EdgeInsets.only(right: 10),
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: textIconColor,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      data!,
                      fit: BoxFit.contain,
                    ))),
          ),
          Text(
            text,
            style: TextStyle(
                color: textIconColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
