// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/cubit/cubitRun.dart';
import 'package:storeapp/cubit/cubitState.dart';
import 'package:storeapp/data/constant.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String selectedSize = "L"; // Default selected size
  final List<String> sizes = ["S", "M", "L", "XL", "XXL"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          "My Cart",
          style: TextStyle(color: textIconColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: textIconColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "5 Item in Cart",
                style: TextStyle(
                    color: textIconColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w900),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 130,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: textIconColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: 100,
                      child: Image.asset(
                        "images/shirt_sports/Alahly3.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      children: [
                        Text(
                          "Alahly Tshirt ",
                          style: TextStyle(
                              color: ContaierColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [buildSizeChoose(), NumberOfItem()],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSizeChoose() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey.shade200, // Light grey background
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "SIZE: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: ContaierColor,
            ),
          ),
          DropdownButton<String>(
            value: selectedSize,
            items: sizes.map((String size) {
              return DropdownMenuItem<String>(
                value: size,
                child: Text(
                  size,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedSize = newValue!;
              });
            },
            underline: Container(), // Remove default underline
            icon: Icon(Icons.arrow_drop_down_sharp, color: ContaierColor),
            style: TextStyle(color: ContaierColor),
            dropdownColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget NumberOfItem() {
    BlocProvider.of<Cubitrun>(context).sizeIncreament;
    return BlocConsumer<Cubitrun, cubitState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.remove,
                  color: Colors.black,
                  size: 15,
                ),
                onPressed: () {
                   BlocProvider.of<Cubitrun>(context).cartIncrement(false);
                },
              ),
              Text(
                "${BlocProvider.of<Cubitrun>(context).sizeIncreament}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 12,
                ),
                onPressed: () {
                  BlocProvider.of<Cubitrun>(context).cartIncrement(true);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
