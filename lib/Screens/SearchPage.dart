// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:storeapp/Widgets/productOutAPI.dart';
import 'package:storeapp/data/constant.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  bool isSearching = false;

  void addSearchForITemToSearchList(String serchedCharacter) {
    searchedItem = popularItem
        .where((element) =>
            element.name.toLowerCase().startsWith(serchedCharacter))
        .toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: ListView(
        padding: const EdgeInsets.only(right: 8, left: 8),
        children: [
          const SizedBox(
            height: 30,
          ),
          buildSearchField(),
          BuildSearchItem(),
        ],
      ),
    );
  }

  Widget buildSearchField() {
    return TextField(
      onChanged: (value) {
        addSearchForITemToSearchList(value);
      },
      cursorColor: Colors.white,
      controller: search_controler,
      style: TextStyle(color: textIconColor),
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: textIconColor,
          ),
          suffixIcon: Icon(
            FontAwesomeIcons.listCheck,
            color: textIconColor,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: textIconColor)),
          hintText: "Find  item",
          hintStyle: const TextStyle(color: Colors.grey),
          enabled: true,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: ContaierColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              // ignore: prefer_const_constructors
              borderSide: BorderSide(color: ContaierColor))),
    );
  }

  Widget BuildSearchItem() {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            //childAspectRatio: 3 / 2,
            crossAxisSpacing: 2,
          ),
          itemCount: search_controler.text.isEmpty ? 4 : searchedItem.length,
          itemBuilder: (context, i) => Productoutapi(
              name: search_controler.text.isEmpty
                  ? popularItem[i].name
                  : searchedItem[i].name,
              img: search_controler.text.isEmpty
                  ? popularItem[i].img
                  : searchedItem[i].img)),
    );
  }
}
/* */
