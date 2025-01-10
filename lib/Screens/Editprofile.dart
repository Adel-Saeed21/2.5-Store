// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:storeapp/cubit/cubitRun.dart';
import 'package:storeapp/cubit/cubitState.dart';

import 'package:storeapp/data/constant.dart';

// ignore: must_be_immutable
class Editprofile extends StatelessWidget {
  Editprofile({super.key, this.img, this.email});
  String? img;
  final String? email;

  @override
  Widget build(BuildContext context) {
    // var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // var backcolor = isDark ? Colors.black : Colors.white;
    // var textcolor = isDark ? Colors.white : Colors.black;
    GlobalKey<FormState> formstate1 = GlobalKey();

    return BlocConsumer<Cubitrun, cubitState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  LineAwesomeIcons.angle_left_solid,
                  color: maincolor,
                )),
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
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: ContaierColor, shape: BoxShape.circle),
                      width: 150,
                      height: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: img!.isNotEmpty
                            ? Image.asset(img!, fit: BoxFit.cover)
                            : const Icon(Icons.person,
                                size: 100, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: textIconColor),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              LineAwesomeIcons.pencil_alt_solid,
                              size: 20,
                              color: ContaierColor,
                            ),
                          )),
                    )
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                  child: Form(
                      key: formstate1,
                      child: Column(
                        children: [
                         
                          DynamicTextfiled(
                            keyboard: TextInputType.text,
                            sizee: 500,
                            word: "Email",
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Can't be empty";
                              }
                              return null;
                            },
                          ),
                          DynamicTextfiled(
                            keyboard: TextInputType.text,
                            sizee: 500,
                            word: "Username",
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Can't be empty";
                              }
                              return null;
                            },
                          ),
                          Row(
                            children: [
                              DynamicTextfiled(
                                keyboard: TextInputType.text,
                                sizee: 200,
                                word: "Gender",
                                validator: (p0) {
                                  if (p0 != null &&
                                      p0 != "male" &&
                                      p0 != "female" &&
                                      p0 != "Male" &&
                                      p0 != "Female") {
                                    return " gender is Male or Female";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              DynamicTextfiled(
                                keyboard: TextInputType.number,
                                sizee: 150,
                                word: "Birthday",
                                validator: (p0) {
                                  if (p0 == null || p0.isEmpty) {
                                    return null;
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),

                          DynamicTextfiled(
                            keyboard: TextInputType.number,
                            sizee: 500,
                            word: "Phone Number",
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return "Can't be empty";
                              }
                              return null;
                            },
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ContaierColor,
                          side: BorderSide.none,
                          shape: const StadiumBorder()),
                      onPressed: () {
                        if (formstate1.currentState!.validate()) {
                        } else {
                          return;
                        }
                      },
                      child: const Text(
                        "Edit profile",
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}

class DynamicTextfiled extends StatelessWidget {
  const DynamicTextfiled({
    super.key,
    required this.word,
    this.validator,
    required this.sizee,
    required this.keyboard,
  });
  final String word;
  final String? Function(String?)? validator;
  final double sizee;
  final TextInputType keyboard;
  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: sizee,
      child: Column(
        children: [
          TextFormField(
            keyboardType: keyboard,
            style: TextStyle(color: textIconColor),
            //   onChanged: onChanged, // Pass the onChanged callback
            validator: validator, // Pass the validator callback
            decoration: InputDecoration(
              hintMaxLines: 1,
              fillColor: textIconColor,
              focusColor: textIconColor,
              label: Text(word),
              hoverColor: textIconColor,
              labelStyle: TextStyle(color: textIconColor, fontSize: 18),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.red),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: ContaierColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: ContaierColor),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: ContaierColor),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
