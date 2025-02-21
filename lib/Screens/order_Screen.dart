import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/cubit/cubitRun.dart';
import 'package:storeapp/cubit/cubitState.dart';
import 'package:storeapp/data/DataUse.dart';
import 'package:storeapp/data/constant.dart';
import 'package:storeapp/services/Firebase/getUserData.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String selectedSize = "L"; // Default selected size
  List<MyCartItems> cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCartItems(); // تحميل البيانات عند فتح الشاشة
  }

  Future<void> loadCartItems() async {
    List<MyCartItems> items = await fetchCartItems(); 
    setState(() {
      cartItems = items; 
    });
  }

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
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? buildEmptyUI()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: buildFinalUI(),
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildEmptyUI() {
    return const Center(
      child: Text("Add data to cart", style: TextStyle(color: Colors.white)),
    );
  }

  Widget buildFinalUI() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Authentication")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("Cart")
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text("❌ Error: ${snapshot.error}"));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("🛒 No items in cart"));
        }

        print("🔥 Received cart items: ${snapshot.data!.docs.length}");

        List<MyCartItems> cartItems = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;

          print("🛒 Adding to cart: ${data["name"]}, Price: ${data["price"]}");

          return MyCartItems(
            data["img"] ?? "",
            data["hasOffer"] ?? false,
            data["name"] ?? "Unknown",
            (data["price"] ?? 0).toDouble(),
            (data["sale"] ?? 0).toDouble(),
            true,
            data["quantity"] ?? 1,
          );
        }).toList();

        return ListView.builder(
          itemCount: cartItems.length,
          itemBuilder: (context, index) {
            return itemAddFromDetails(cartItems[index]);
          },
        );
      },
    );
  }

  Widget itemAddFromDetails(MyCartItems item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: TextStyle(
                      color: ContaierColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    buildSizeChoose(),
                    NumberOfItem(item)
                  ], // 👈 تمرير العنصر هنا
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    item.hasOffer
                        ? Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "\$${item.price - (item.price * item.sale / 100)}",
                                  style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
                                TextSpan(
                                  text: " \$${item.price}",
                                  style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough),
                                ),
                                TextSpan(
                                  text: "  ${item.sale}% OFF",
                                  style: TextStyle(
                                      color: Colors.green[600],
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            "\$${item.price}",
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 28),
                          ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void updateItemQuantity(MyCartItems item, int newQuantity) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final cartCollection = FirebaseFirestore.instance
        .collection("Authentication")
        .doc(user.uid)
        .collection("Cart");

    final querySnapshot =
        await cartCollection.where("name", isEqualTo: item.name).limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      final docId = querySnapshot.docs.first.id;
      await cartCollection.doc(docId).update({"quantity": newQuantity});
      print("🔄 Updated quantity in Firestore: $newQuantity");

      setState(() {
        item.quantity = newQuantity;
        print("🛒 Updated quantity in UI: ${item.quantity}");
      });
    }
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
                color: ContaierColor),
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

  Widget NumberOfItem(MyCartItems item) {
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
              if (item.quantity > 1) {
                updateItemQuantity(item, item.quantity - 1);
              }
            },
          ),
          Text(
            "${item.quantity}",
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black, size: 12),
            onPressed: () {
              updateItemQuantity(item, item.quantity + 1);
            },
          ),
        ],
      ),
    );
  }
}
