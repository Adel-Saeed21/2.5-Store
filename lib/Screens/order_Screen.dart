import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:storeapp/data/constant.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String selectedSize = "L";

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
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, color: textIconColor),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Authentication")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection("Cart")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final cartItems = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return MyCartItems(
              data["img"] ?? "",
              data["hasOffer"] ?? false,
              data["name"] ?? "Unknown",
              (data["price"] ?? 0).toDouble(),
              (data["sale"] ?? 0).toDouble(),
              true,
              data["quantity"] ?? 1,
              doc.id, // Store document ID for updates
            );
          }).toList();

          return Column(
            children: [
              Expanded(
                child: cartItems.isEmpty
                    ? Center(
                        child: Text("🛒 Cart is empty",
                            style: TextStyle(color: ContaierColor)))
                    : ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) => Dismissible(
                          key: Key(cartItems[index].documentId),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) =>
                              deleteItemFromCart(cartItems[index]),
                          background: Container(
                            color: ContaierColor,
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                          child: CartItemCard(
                            item: cartItems[index],
                            onQuantityChanged: (newQuantity) {
                              updateQuantity(cartItems[index], newQuantity);
                            },
                          ),
                        ),
                      ),
              ),
              if (cartItems.isNotEmpty)
                CheckOut(
                  total: cartItems.fold(
                    0.0,
                    // ignore: avoid_types_as_parameter_names
                    (sum, item) =>
                        sum +
                        ((item.price - (item.price * item.sale / 100)) *
                            item.quantity),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> deleteItemFromCart(MyCartItems item) async {
    await FirebaseFirestore.instance
        .collection("Authentication")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("Cart")
        .doc(item.documentId)
        .delete();
  }

  Future<void> updateQuantity(MyCartItems item, int newQuantity) async {
    await FirebaseFirestore.instance
        .collection("Authentication")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("Cart")
        .doc(item.documentId)
        .update({'quantity': newQuantity});
  }
}

class CartItemCard extends StatelessWidget {
  final MyCartItems item;
  final Function(int) onQuantityChanged;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: textIconColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Image.asset(item.img,
                height: double.infinity, width: 100, fit: BoxFit.cover),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                        color: ContaierColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SizeDropdown(),
                      const SizedBox(width: 10),
                      QuantitySelector(
                        quantity: item.quantity,
                        onChanged: onQuantityChanged,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  item.hasOffer
                      ? Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    "\$${(item.price - (item.price * item.sale / 100)).toStringAsFixed(2)}",
                                style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              TextSpan(
                                text: " \$${item.price.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough),
                              ),
                              TextSpan(
                                text: "  ${item.sale.toStringAsFixed(0)}% OFF",
                                style: TextStyle(
                                    color: Colors.green[600],
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      : Text(
                          "\$${item.price.toStringAsFixed(2)}",
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckOut extends StatelessWidget {
  final double total;

  const CheckOut({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ContaierColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TOTAL",
                style: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
              Text(
                "\$${total.toStringAsFixed(2)}",
                style: TextStyle(
                    color: textIconColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              )
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              side: BorderSide(color: ContaierColor, width: 2),
            ),
            child: Row(
              children: [
                Text(
                  "CHECK OUT",
                  style: TextStyle(
                    color: ContaierColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.double_arrow, color: ContaierColor, size: 20),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SizeDropdown extends StatefulWidget {
  @override
  State<SizeDropdown> createState() => _SizeDropdownState();
}

class _SizeDropdownState extends State<SizeDropdown> {
  String selectedSize = "L";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      child: DropdownButton<String>(
        value: selectedSize,
        items: ["S", "M", "L", "XL", "XXL"].map((String size) {
          return DropdownMenuItem<String>(
            value: size,
            child: Text(size, style: TextStyle(color: ContaierColor)),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() => selectedSize = newValue!);
        },
        underline: Container(),
        icon: Icon(Icons.arrow_drop_down, color: ContaierColor),
        dropdownColor: Colors.white,
      ),
    );
  }
}

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final Function(int) onChanged;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 18),
            onPressed: () => onChanged(quantity > 1 ? quantity - 1 : 1),
          ),
          Text('$quantity',
              style:
                  TextStyle(color: ContaierColor, fontWeight: FontWeight.bold)),
          IconButton(
            icon: const Icon(Icons.add, size: 18),
            onPressed: () => onChanged(quantity + 1),
          ),
        ],
      ),
    );
  }
}

class MyCartItems {
  final String img;
  final bool hasOffer;
  final String name;
  final double price;
  final double sale;
  final bool isFavorite;
  final int quantity;
  final String documentId;

  MyCartItems(
    this.img,
    this.hasOffer,
    this.name,
    this.price,
    this.sale,
    this.isFavorite,
    this.quantity,
    this.documentId,
  );
}
