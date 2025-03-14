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

class _SearchpageState extends State<Searchpage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool isSearching = false;
  final List<String> chipLabels = [
    "Alahly",
    "smart watch",
    "Arsenal",
    "sweatshirt"
  ];
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;
  final ValueNotifier<List<dynamic>> searchedItemNotifier = ValueNotifier([]);

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    searchedItemNotifier.dispose();
    super.dispose();
  }

  void addSearchForItem(String searchedCharacter) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      List<dynamic> results = searchedCharacter.isEmpty
          ? []
          : popularItem
              .where((item) => item.name
                  .toLowerCase()
                  .contains(searchedCharacter.toLowerCase()))
              .toList();

      searchedItemNotifier.value = results;
      setState(() {
        isSearching = searchedCharacter.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        leading: Icon(
          Icons.ac_unit,
          color: backgroundColor,
        ),
        backgroundColor: backgroundColor,
        title: Text(
          "Search",
          style: TextStyle(color: textIconColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            buildSearchField(),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child:
                    isSearching ? buildSearchResults() : buildPopularContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchField() {
    return TextField(
      onChanged: addSearchForItem,
      cursorColor: Colors.white,
      controller: searchController,
      style: TextStyle(color: textIconColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: ContaierColor,
        prefixIcon: Icon(Icons.search, color: textIconColor),
        suffixIcon: IconButton(
          icon: Icon(FontAwesomeIcons.listCheck, color: textIconColor),
          onPressed: () {},
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

  Widget buildPopularContent() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      children: [
        const SizedBox(height: 15),
        Text("Popular Search",
            style: TextStyle(
                color: textIconColor,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        buildChipList(),
        const SizedBox(height: 20),
        Text("Popular Item",
            style: TextStyle(
                color: textIconColor,
                fontSize: 22,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        SizedBox(
          height: 400,
          child: GridView.builder(
            cacheExtent: 1000, // Preload items for smoother performance
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
            ),
            itemCount: 4,
            itemBuilder: (context, i) => Productoutapi(
                name: popularItem[i].name, img: popularItem[i].img),
          ),
        )
      ],
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
                  borderRadius: BorderRadius.circular(16)),
              backgroundColor: Colors.grey[300],
            ),
          )
          .toList(),
    );
  }

  Widget buildSearchResults() {
    return ValueListenableBuilder<List<dynamic>>(
      valueListenable: searchedItemNotifier,
      builder: (context, searchedItem, child) {
        return GridView.builder(
          cacheExtent: 1000, // Preload for smoother scrolling
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
          ),
          itemCount: searchedItem.length,
          itemBuilder: (context, i) => Productoutapi(
            name: searchedItem[i].name,
            img: searchedItem[i].img,
          ),
        );
      },
    );
  }
}
