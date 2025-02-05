
import 'package:flutter/material.dart';
import 'package:storeapp/data/constant.dart';
import 'package:storeapp/models/productModel.dart';

// ignore: must_be_immutable
class CustomCard extends StatelessWidget {
  CustomCard({
    required this.product,
    super.key,
  });
  Productmodel product;
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
                      product.title,
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
            child: Image.network(
              product.image,
              height: 70,
              width: 100,
            ),
          )
        ],
      ),
    );
  }
}
