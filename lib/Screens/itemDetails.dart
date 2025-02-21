// ignore:
// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:storeapp/Widgets/colotTshirtContainer.dart';
import 'package:storeapp/cubit/cubitRun.dart';
import 'package:storeapp/cubit/cubitState.dart';
import 'package:storeapp/data/DataUse.dart';

import 'package:storeapp/data/constant.dart';
import 'package:storeapp/helper/SnaceBar.dart';
import 'package:storeapp/services/Firebase/getUserData.dart';

// ignore: must_be_immutable
class Itemdetails extends StatefulWidget {
  const Itemdetails(
      {super.key,
      required this.detials,
      required this.imageess,
      required this.names,
      required this.price,
      required this.sale});

  final List detials;
  final String imageess;
  final String names;
  final double price;
  final double sale;

  @override
  State<Itemdetails> createState() => _ItemdetailsState();
}

class _ItemdetailsState extends State<Itemdetails> {
  String imgSelect = "";

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<Cubitrun>(context).changeImage(widget.imageess);

    List<String> sizes = ["M", "L", "XL"];
    imgSelect = widget.imageess;
    final User? user = FirebaseAuth.instance.currentUser;

    return BlocConsumer<Cubitrun, cubitState>(
        // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
        builder: (context, State) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: backgroundColor,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    BlocProvider.of<Cubitrun>(context).state1 = false;
                    BlocProvider.of<Cubitrun>(context).state2 = false;
                    BlocProvider.of<Cubitrun>(context).state3 = false;
                    BlocProvider.of<Cubitrun>(context).isBooked = false;
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: textIconColor,
                  )),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Details",
                    style: TextStyle(
                        color: iconColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 1),
                  SizedBox(
                    height: 15,
                    width: 120,
                    child: Marquee(
                      text: 'Easy shopping is our goal',
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                      velocity: 50.0,
                      pauseAfterRound: const Duration(seconds: 1),
                      blankSpace: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: backgroundColor,
            body: ListView(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 10),
              children: [
                Align(
                  child: Container(
                    height: 320,
                    width: 320,
                    decoration: BoxDecoration(
                      color: iconColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: iconColor,
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                    child: Align(
                      child: Image.asset(
                          height: 250,
                          width: 250,
                          BlocProvider.of<Cubitrun>(context).imageChose),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Original sports T-shirt\n A comfortable sports t-shirt with breathable, moisture-wicking fabric, perfect for workouts and running with a stylish and practical look.",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Colors available",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: List.generate(widget.detials.length, (index) {
                    return ColorTshirtContainer(
                      imageName: widget.detials[index],
                      onpressed: () {
                        BlocProvider.of<Cubitrun>(context)
                            .changeContainerColor(index + 1);
                        BlocProvider.of<Cubitrun>(context)
                            .changeImage(widget.detials[index]);
                        imgSelect = widget.detials[index];
                      },
                      changecolor: BlocProvider.of<Cubitrun>(context)
                          .getStateByIndex(index + 1),
                    );
                  }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Size Avialable",
                  style: TextStyle(color: textIconColor, fontSize: 16),
                ),
                Row(
                  children: List.generate(sizes.length, (index) {
                    return OutButtonSize(size: sizes[index]);
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      child: Container(
                          decoration: BoxDecoration(
                              color: ContaierColor,
                              borderRadius: BorderRadius.circular(5)),
                          width: 150,
                          height: 40,
                          child: TextButton(
                            onPressed: () async {
                              ShowMessage(context, "Item added to cart");

                              await addToCart(MyCartItems(
                                  imgSelect,
                                  true,
                                  widget.names,
                                  widget.price,
                                  widget.sale,
                                  true,1));

                              setState(() {}); // إعادة تحميل الشاشة بعد الإضافة
                            },
                            child: Text(
                              "Add to Cart",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: textIconColor),
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Align(
                      child: Container(
                          decoration: BoxDecoration(
                              color: ContaierColor,
                              borderRadius: BorderRadius.circular(5)),
                          width: 150,
                          height: 40,
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Buy Now",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: textIconColor),
                              ))),
                    )
                  ],
                )
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}

class OutButtonSize extends StatelessWidget {
  const OutButtonSize({
    super.key,
    required this.size,
  });
  final String size;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: textIconColor,
                width: 2,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {},
          child: Text(
            size,
            style: TextStyle(
                color: textIconColor,
                fontWeight: FontWeight.w500,
                fontSize: 14),
          )),
    );
  }
}
