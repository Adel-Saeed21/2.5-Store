// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/cubit/cubitState.dart';
import 'package:storeapp/data/DataUse.dart';

class Cubitrun extends Cubit<cubitState> {
  Cubitrun() : super(TshirtChange());
  String imageChose = "";
  bool state1 = false;
  bool state2 = false;
  bool state3 = false;
  bool M_size = false;
  bool X_size2 = false;
  bool XL_size = false;
  int sizeIncreament = 1;

  String imageGalary = "";
  bool isBooked = false;
  bool isPasswordValid = false;
  void changeImage(String x) {
    imageChose = x;
    emit(TshirtChange());
  }

  bool getStateByIndex(int index) {
    switch (index) {
      case 1:
        return state1;
      case 2:
        return state2;
      case 3:
        return state3;
      default:
        return false;
    }
  }

  void DetailsBookButton() {
    isBooked = !isBooked;
    emit(BookedState());
  }

  void changeContainerColor(int index) {
    state1 = index == 1;
    state2 = index == 2;
    state3 = index == 3;

    emit(UpdateContainerImageColor());
  }

  void setPasswordValidation(bool isValid) {
    isPasswordValid = isValid;
    emit(PasswordValidationState());
  }

  void Changeimages() {}

  void cartIncrement(bool isIncrement) {
    if (isIncrement) {
      if (sizeIncreament < 9) {
        sizeIncreament++;
        emit(CartIncrement());
      }
    } else {
      if (sizeIncreament > 1) {
        sizeIncreament--;
        emit(CartIncrement());
      }
    }
  }

  Future<void> loadCartItems() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection("Authentication")
        .doc(user.uid)
        .collection("Cart")
        .orderBy("timestamp", descending: true)
        .get();

    final cartItems = snapshot.docs.map((doc) {
      final data = doc.data();
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

    emit(cartItems as cubitState);
  }

  Future<void> updateItemQuantity(MyCartItems item, int newQuantity,int id) async {
    if (newQuantity < 1) return;

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

      if (state is CartLoaded) {
        final updatedCart = (state as CartLoaded).cartItems.map((cartItem) {
          if (cartItem.name == item.name) {
            return MyCartItems(
              cartItem.img,
              cartItem.hasOffer,
              cartItem.name,
              cartItem.price,
              cartItem.sale,
              true,
              newQuantity,
              
              
            );
          }
          return cartItem;
        }).toList();

        emit(CartLoaded(updatedCart)); 
      }
    }
  }
}
