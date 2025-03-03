// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:storeapp/Screens/itemDetails.dart';
import 'package:storeapp/data/constant.dart';

class SalesCard extends StatelessWidget {
  const SalesCard({
    super.key,
    required this.prince,
    required this.sales,
    required this.imagess,
    required this.nameofobj,
    required this.details,
    this.id
  });
  final double prince;
  final double sales;
  final String imagess;
  final String nameofobj;
  final List<String> details;
  final int? id;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Itemdetails(
                  detials: details,
                  imageess: imagess,
                  names: nameofobj,
                  price: prince,
                  sale: sales,
                )));
      },
      child: Stack(
        children: [
          // Main container
          Container(
            height: 183,
            width: 180,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 40,
                    color: ContaierColor,
                    spreadRadius: 0,
                    offset: const Offset(10, 10)),
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Card(
              shadowColor: textIconColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        imagess,
                        height: 100,
                        width: 100,
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      nameofobj,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "$prince\$",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "$sales\$",
                              style: TextStyle(
                                  color: backgroundColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_outline,
                            color: Colors.black,
                            size: 30,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
          // SALE label
          Positioned(
            top: 10,
            left: -10,
            child: Transform.rotate(
              angle: -0.5, // Adjust the rotation angle in radians
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                color: Colors.red,
                child: const Text(
                  'SALE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
