// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:storeapp/data/constant.dart';

Future<Map<String, dynamic>?> getUserData() async {
  try {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('Authentication')
        .doc(uid)
        .get();

    if (userDoc.exists) {
      return userDoc.data() as Map<String, dynamic>;
    } else {
      // ignore: avoid_print
      print('User not found');
      return null;
    }
  } catch (e) {
    // ignore: avoid_print
    print('Error fetching user data: $e');
    return null;
  }
}

void fetchAndDisplayUserData() async {
  Map<String, dynamic>? userData = await getUserData();

  if (userData != null) {
    tprofileHeading = userData['username'];
    tProfilePicture = userData['profileImage'];
  } else {
    // ignore: avoid_print
    print('Failed to fetch user data.');
  }
}
