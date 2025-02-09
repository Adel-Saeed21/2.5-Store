// ignore_for_file: file_names, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> signUpWithEmail({
  required String email,
  required String password,
  required String username,
  required String phoneNumber,
  String? profileImageUrl,
}) async {

  UserCredential userCredential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);

  String uid = userCredential.user!.uid;
  profileImageUrl ??= "images/Blank-Profile-Photo.jpg";

  await FirebaseFirestore.instance.collection('Authentication').doc(uid).set({
    'uid': uid,
    'username': username,
    'Phone': phoneNumber,
    'ProfileImage': profileImageUrl,
    'createdAt': DateTime.now().toString(),
    'email': email,
  });


   print("User registered and data saved successfully!");
}
