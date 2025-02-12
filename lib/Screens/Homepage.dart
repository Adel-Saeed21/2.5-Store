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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          "2.5tore",
          style: TextStyle(
              color: textIconColor, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "OrderScreen");
            },
            icon: Icon(
              FontAwesomeIcons.cartShopping,
              color: textIconColor,
              size: 25,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(height: 20),
          Text(
            "Categories",
            style: TextStyle(
                color: textIconColor,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CategoriezIcon(
                text: "Tech",
                data: "images/digitals.jpg",
                listItems: techList,
              ),
              CategoriezIcon(
                text: "Sports",
                data: "images/shirt_sports/sports.jpg",
                listItems: techList,
              ),
              CategoriezIcon(
                  text: "Man", data: "images/man.jpg", listItems: techList),
              CategoriezIcon(
                  text: "Woman", data: "images/woman.jpg", listItems: techList),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 35),
            height: MediaQuery.of(context).size.height - 330,
            decoration: BoxDecoration(
              color: ContaierColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: TPromoSLider(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Best Sales",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "more");
                        },
                        child: const Row(
                          children: [
                            Text(
                              "More",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_circle_right,
                                color: Colors.blueAccent),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
