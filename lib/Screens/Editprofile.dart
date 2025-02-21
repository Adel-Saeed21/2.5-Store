// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:storeapp/cubit/cubitRun.dart';
import 'package:storeapp/cubit/cubitState.dart';
import 'package:storeapp/data/constant.dart';

class EditProfile extends StatefulWidget {
  const EditProfile(
      {super.key, this.img, this.email, this.phoneNumber, this.username});

  final String? img;
  final String? email;
  final String? phoneNumber;
  final String? username;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? file;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email ?? "";
    usernameController.text = widget.username ?? "";
    phoneController.text = widget.phoneNumber ?? "";

    // استرجاع الصورة من Firestore إذا كانت محفوظة
    fetchProfileImage();
  }

  /// استرجاع الصورة من Firestore
  Uint8List? imageBytes; // تخزين الصورة كـ Uint8List

  Future<void> fetchProfileImage() async {
    final String uid = FirebaseAuth.instance.currentUser?.uid ?? "";
    if (uid.isEmpty) return;

    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("Authentication")
          .doc(uid)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        String? base64Image = userDoc["img"];
        if (base64Image != null && base64Image.isNotEmpty) {
          setState(() {
            imageBytes = base64Decode(base64Image);
          });
        }
      }
    } catch (e) {
      debugPrint("Error fetching profile image: $e");
    }
  }

  /// Picks an image from gallery
 Future<void> getImage() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  if (image != null) {
    List<int> imageBytesList = await File(image.path).readAsBytes();
    setState(() {
      file = File(image.path);
      imageBytes = Uint8List.fromList(imageBytesList); // تحديث الصورة فورًا
    });
  }
}


  /// Converts the image file to a Base64 string
  String? convertImageToBase64(File? imageFile) {
    if (imageFile == null) return null;
    List<int> imageBytes = imageFile.readAsBytesSync();
    return base64Encode(imageBytes);
  }

  /// Updates user profile in Firestore
  Future<void> updateUserData() async {
  if (!formKey.currentState!.validate()) return;

  final String uid = FirebaseAuth.instance.currentUser?.uid ?? "";
  if (uid.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("User not logged in!")),
    );
    return;
  }

  String? base64Image;
  if (imageBytes != null) { // استخدم imageBytes بدلاً من file
    base64Image = base64Encode(imageBytes!);
  }

  try {
    await FirebaseFirestore.instance
        .collection("Authentication")
        .doc(uid)
        .update({
      "email": emailController.text.trim(),
      "username": usernameController.text.trim(),
      "phone": phoneController.text.trim(),
      if (base64Image != null) "img": base64Image,
    });

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated successfully!")),
    );
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error updating profile: $e")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubitrun, cubitState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(LineAwesomeIcons.angle_left_solid, color: maincolor),
            ),
            centerTitle: true,
            title: Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: textIconColor,
              ),
            ),
          ),
          backgroundColor: backgroundColor,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(height: 30),
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundColor: ContaierColor,
                      backgroundImage: imageBytes != null
                          ? MemoryImage(
                              imageBytes!) // الصورة المحفوظة من Base64
                          : (widget.img != null && widget.img!.isNotEmpty)
                              ? NetworkImage(widget.img!) as ImageProvider
                              : null,
                      child: imageBytes == null &&
                              (widget.img == null || widget.img!.isEmpty)
                          ? const Icon(Icons.person,
                              size: 100, color: Colors.white)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: textIconColor,
                        child: IconButton(
                          onPressed: getImage,
                          icon: Icon(LineAwesomeIcons.pencil_alt_solid,
                              size: 20, color: ContaierColor),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      DynamicTextField(
                        controller: emailController,
                        label: "Email",
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value!.isEmpty ? "Can't be empty" : null,
                      ),
                      DynamicTextField(
                        controller: usernameController,
                        label: "Username",
                        keyboardType: TextInputType.text,
                        validator: (value) =>
                            value!.isEmpty ? "Can't be empty" : null,
                      ),
                      DynamicTextField(
                        controller: phoneController,
                        label: "Phone Number",
                        keyboardType: TextInputType.phone,
                        validator: (value) =>
                            value!.isEmpty ? "Can't be empty" : null,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ContaierColor,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: updateUserData,
                    child: const Text("Save",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// DynamicTextField Widget
class DynamicTextField extends StatelessWidget {
  const DynamicTextField({
    super.key,
    required this.label,
    this.validator,
    required this.keyboardType,
    this.controller,
  });

  final String label;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: TextStyle(color: textIconColor),
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: textIconColor, fontSize: 18),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: ContaierColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: ContaierColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.red),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: ContaierColor),
          ),
        ),
      ),
    );
  }
}
