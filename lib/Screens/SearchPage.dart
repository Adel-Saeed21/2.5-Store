// ignore_for_file: file_names
import 'dart:async';
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
  List<String> chipLabels = ["Alahly", "smart watch", "Arsenal", "sweatshirt"];

  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void addSearchForITemToSearchList(String searchedCharacter) {
    setState(() {
      searchedItem = popularItem
          .where((element) =>
              element.name.toLowerCase().startsWith(searchedCharacter))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          "Search",
          style: TextStyle(color: textIconColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(right: 8, left: 8),
          children: [
            buildSearchField(),
            const SizedBox(height: 15),
            Text(
              "Popular Search",
              style: TextStyle(
                color: textIconColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            buildChipList(),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Popular Item",
              style: TextStyle(
                color: textIconColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            buildSearchResults(),
          ],
        ),
      ),
    );
  }

  Widget buildSearchField() {
    return TextField(
      onChanged: (value) {
        if (_debounce?.isActive ?? false) _debounce!.cancel();
        _debounce = Timer(const Duration(milliseconds: 500), () {
          addSearchForITemToSearchList(value);
        });
      },
      cursorColor: Colors.white,
      controller: searchController,
      style: TextStyle(color: textIconColor),
      decoration: InputDecoration(
        filled: true,
        // ignore: deprecated_member_use
        fillColor: ContaierColor.withOpacity(0.2),
        prefixIcon: Icon(Icons.search, color: textIconColor),
        suffixIcon: IconButton(
          icon: Icon(FontAwesomeIcons.listCheck, color: textIconColor),
          onPressed: () {
  
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: textIconColor),
        ),
        hintText: "Find item",
        hintStyle: const TextStyle(color: Colors.grey),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ContaierColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ContaierColor),
        ),
      ),
    );
  }

  Widget buildChipList() {
    return Wrap(
      spacing: 8.0,
      children: chipLabels
          .map(
            (label) => Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.blue,
                child:
                    Text(label[0], style: const TextStyle(color: Colors.white)),
              ),
              label: Text(label),
              deleteIcon: const Icon(Icons.cancel, color: Colors.black),
              onDeleted: () {
                setState(() {
                  chipLabels.remove(label);
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: Colors.grey[300],
            ),
          )
          .toList(),
    );
  }

  Widget buildSearchResults() {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
        ),
        itemCount: searchController.text.isEmpty
            ? popularItem.length
            : searchedItem.length,
        itemBuilder: (context, i) => Productoutapi(
          name: searchController.text.isEmpty
              ? popularItem[i].name
              : searchedItem[i].name,
          img: searchController.text.isEmpty
              ? popularItem[i].img
              : searchedItem[i].img,
        ),
      ),
    );
  }
}
