// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:storeapp/data/constant.dart';

class Productoutapi extends StatelessWidget {
  const Productoutapi({super.key, required this.name, required this.img});
final String name;
final String img;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'Updateproduct');
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            width: 210,
            height: 200,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 40,
                  color: ContaierColor,
                  spreadRadius: 0,
                  offset: const Offset(10, 10)),
            ]),
            child: Card(
              elevation: 10,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      maxLines: 1,
                    name ,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          r"$225",
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_outline,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 15,
            bottom: 90,
            child: Image.asset(
            img ,
              height: 70,
              width: 100,
            ),
          )
        ],
      ),
    );
  }
}
