import 'package:flutter/material.dart';
import 'package:storeapp/Widgets/productOutAPI.dart';
import 'package:storeapp/data/constant.dart';

class Itemsofcategories extends StatelessWidget {
  const Itemsofcategories({
    super.key,
    required this.lists, required this.name,
  });
  final List<Productoutapi> lists;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          name,
          style: TextStyle(
              color: textIconColor, fontSize: 22, fontWeight: FontWeight.w500),
        ),
        backgroundColor: backgroundColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: textIconColor,
            )),
      ),
      backgroundColor: backgroundColor,
      body: GridView.builder(
          itemCount: lists.length,
          clipBehavior: Clip.none,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return Productoutapi(
                name: lists[index].name, img: lists[index].img);
          }),
    );
  }
}
