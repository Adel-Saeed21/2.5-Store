// ignore: unnecessary_import
// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:storeapp/Widgets/TPromoSlider.dart';
import 'package:storeapp/Widgets/categorizeIcon.dart';
import 'package:storeapp/Widgets/salesCard.dart';
import 'package:storeapp/data/constant.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: AppBar(
        backgroundColor: BackgroundColor,
        title: Text(
          "2.5Store",
          style: TextStyle(
              color: TextIconColor, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "Profile");
            },
            icon: Icon(
              Icons.person,
              color: TextIconColor,
              size: 30,
            ),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(right: 15, left: 15),
        children: [
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            child: TextField(
              enabled: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: ContaierColor,
                  ),
                  suffixIcon: Icon(
                    FontAwesomeIcons.listCheck,
                    color: TextIconColor,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: TextIconColor)),
                  hintText: "Search",
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: TextIconColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: TextIconColor))),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "More than customers,\nYou are part of our family",
            style: TextStyle(
                color: TextIconColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Categories",
            style: TextStyle(
                color: TextIconColor,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Row(
            children: [
              CategoriezIcon(
                text: "Tech",
                data: "images/digitals.jpg",
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width - 400,
              // ),
              CategoriezIcon(
                text: "Sports",
                data: "images/shirt_sports/sports.jpg",
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width - 400,
              // ),
              CategoriezIcon(
                text: "Man",
                data: "images/man.jpg",
              ),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width - 400,
              // ),
              CategoriezIcon(
                text: "Woman",
                data: "images/woman.jpg",
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            height: 480,
            decoration: BoxDecoration(
                color: ContaierColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: TPromoSLider(),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      const Text(
                        "Best sales",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 220,
                      ),
                      const Text(
                        "More",
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "more");
                          },
                          icon: const Icon(Icons.arrow_circle_right))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: salescards.length,
                          itemBuilder: (context, i) => SalesCard(
                            prince: salescards[i].prince,
                            sales: salescards[i].sales,
                            imagess: salescards[i].imagess,
                            nameofobj: salescards[i].nameofobj,
                            details: salescards[i].details,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
