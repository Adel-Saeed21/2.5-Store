// ignore_for_file: file_names, avoid_print, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:storeapp/data/DataUse.dart';
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
    // ignore: duplicate_ignore
    // ignore: avoid_print
    print('Failed to fetch user data.');
  }
}

Future<List<MyCartItems>> fetchCartItems() async {
  try {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("Authentication")
          .doc(user.uid)
          .collection("Cart")
          .orderBy("timestamp", descending: true)
          .get();

      List<MyCartItems> cartItems = snapshot.docs.map((doc) {
        // التحقق من وجود الحقول قبل استخدامها
        final data = doc.data() as Map<String, dynamic>;

        return MyCartItems(
          data.containsKey("img") ? data["img"] : "",
          data.containsKey("hasOffer") ? data["hasOffer"] : false,
          data.containsKey("name") ? data["name"] : "Unknown",
          data.containsKey("price") ? data["price"].toDouble() : 0.0,
          data.containsKey("sale") ? data["sale"].toDouble() : 0.0,
          true,
          data.containsKey("quantity") ? data["quantity"] : 1,// نفترض أن المنتج متوفر دائمًا
        );
      }).toList();

      print("✅ تم جلب ${cartItems.length} منتج من السلة بنجاح!");
      return cartItems;
    } else {
      print("⚠️ لا يوجد مستخدم مسجل الدخول.");
      return [];
    }
  } catch (e) {
    print("❌ خطأ أثناء جلب عناصر السلة: $e");
    return [];

  }
}

Future<void> addToCart(MyCartItems newItem) async {
  try {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // مرجع للوثيقة الخاصة بالمستخدم داخل مجموعة Authentication
      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection("Authentication").doc(user.uid);

      // مرجع للمنتج داخل الـ Cart الخاصة بالمستخدم
      CollectionReference cartCollection = userDocRef.collection("Cart");

      await cartCollection.add({
        "img": newItem.img,
        "name": newItem.name,
        "price": newItem.price,
        "sale": newItem.sale,
        "hasOffer": newItem.hasOffer,
        "quantity":newItem.quantity,

        "timestamp": FieldValue.serverTimestamp(),
      });

      print("✅ تم إضافة المنتج بنجاح إلى السلة!");
    } else {
      print("⚠️ لم يتم العثور على مستخدم مسجل الدخول.");
    }
  } catch (e) {
    print("❌ خطأ أثناء إضافة المنتج إلى السلة: $e");
  }
}

Future<void> deleteCartItem(String itemName) async {
  final User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Authentication")
        .doc(user.uid)
        .collection("Cart")
        .where("name", isEqualTo: itemName)
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }
}
