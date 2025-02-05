// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:storeapp/cubit/cubitRun.dart';
import 'package:storeapp/cubit/cubitState.dart';
import 'package:storeapp/data/constant.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, this.img, this.email});

  final String? img;
  final String? email;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? file;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        file = File(image.path);
      });
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
                  color: textIconColor),
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
                      backgroundImage: file != null
                          ? FileImage(file!) 
                          : (widget.img != null && widget.img!.isNotEmpty)
                              ? NetworkImage(widget.img!)
                                  as ImageProvider 
                              : null,
                      child: file == null &&
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
                        label: "Username",
                        keyboardType: TextInputType.text,
                        validator: (value) =>
                            value!.isEmpty ? "Can't be empty" : null,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: DynamicTextField(
                              label: "Gender",
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value != null && value.isNotEmpty) {
                                  final lowerValue = value.toLowerCase();
                                  if (lowerValue != "male" &&
                                      lowerValue != "female") {
                                    return "Gender must be Male or Female";
                                  }
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: DynamicTextField(
                              label: "Birthday",
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                        ],
                      ),
                      DynamicTextField(
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
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ContaierColor,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      
                    },
                    child: const Text("Edit Profile",
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
