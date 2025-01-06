// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:storeapp/Widgets/customCard.dart';
import 'package:storeapp/data/constant.dart';
import 'package:storeapp/models/productModel.dart';
import 'package:storeapp/services/get_all_product.dart';

class Moreitems extends StatelessWidget {
  const Moreitems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: textIconColor,
        ),
        backgroundColor: backgroundColor,
        title: Text(
          "Products",
          style: TextStyle(color: textIconColor),
        ),
      ),
      backgroundColor: backgroundColor,
      body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 2),
          child: FutureBuilder<List<Productmodel>>(
              future: GetAllProductService().getAllProducts(),
              // ignore: non_constant_identifier_names
              builder: (Context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else {
                    if (snapshot.hasData) {
                      List<Productmodel> products = snapshot.data!;
                      return GridView.builder(
                          itemCount: products.length,
                          clipBehavior: Clip.none,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return CustomCard(
                              product: products[index],
                            );
                          });
                    } else {
                      return const Center(child: Text("don't have data "));
                    }
                  }
                }
              })),
    );
  }
}
