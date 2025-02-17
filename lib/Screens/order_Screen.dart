import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/cubit/cubitRun.dart';
import 'package:storeapp/cubit/cubitState.dart';
import 'package:storeapp/data/DataUse.dart';
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
        child: SafeArea(child: buildFinalUI()),
      ),
    );
  }

  Widget buildFinalUI() {
    if (myCartItem.isEmpty) {
      return const Center(
        child: Text(
          "Add data to cart",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "${myCartItem.length} Item in Cart",
            style: TextStyle(
                color: textIconColor,
                fontSize: 20,
                fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: ListView.builder(
              itemCount: myCartItem.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(myCartItem[index].name),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (direction) async {
                    setState(() {
                      myCartItem.removeAt(index);
                    });
                    return true;
                    
                  },
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:
                        const Icon(Icons.delete, color: Colors.white, size: 30),
                  ),
                  child: itemAddFromDetails(myCartItem[index]),
                );
              },
            ),
          ),
          
        ],
      );
    }
  }

  Widget itemAddFromDetails(MyCartItems x) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
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
                  x.Img,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                children: [
                  Text(
                    x.name,
                    style: TextStyle(
                        color: ContaierColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [buildSizeChoose(), NumberOfItem()],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      x.hasOffer
                          ? Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        "\$${x.price - (x.price * x.sale / 100)}",
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 28),
                                  ),
                                  TextSpan(
                                    text: "\$${x.price}",
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.lineThrough),
                                  ),
                                  TextSpan(
                                      text: "  ${x.sale}% OFF",
                                      style: TextStyle(
                                          color: Colors.green[600],
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            )
                          : Row(
                              children: [
                                Text(
                                  "\$${x.price}",
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
                                const SizedBox(width: 120)
                              ],
                            ),
                    ],
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildSizeChoose() {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
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
            items: ["S", "M", "L", "XL", "XXL"].map((String size) {
              return DropdownMenuItem<String>(
                value: size,
                child: Text(size,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedSize = newValue!;
              });
            },
            underline: Container(),
            icon: Icon(Icons.arrow_drop_down_sharp, color: ContaierColor),
            style: TextStyle(color: ContaierColor),
            dropdownColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget NumberOfItem() {
    return BlocConsumer<Cubitrun, cubitState>(
      listener: (context, state) {},
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
                icon: const Icon(Icons.remove, color: Colors.black, size: 15),
                onPressed: () {
                  BlocProvider.of<Cubitrun>(context).cartIncrement(false);
                },
              ),
              Text(
                "${BlocProvider.of<Cubitrun>(context).sizeIncreament}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.black, size: 12),
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
