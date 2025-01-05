// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:storeapp/Widgets/CustomTextField.dart';
import 'package:storeapp/Widgets/Custom_Button.dart';
import 'package:storeapp/data/constant.dart';
import 'package:storeapp/helper/SnaceBar.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  GlobalKey<FormState> formstate1 = GlobalKey();

  String? email, password;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    // var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // var backcolor = BackgroundColor;
    return ModalProgressHUD(
      inAsyncCall: isloading,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: BackgroundColor,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  FontAwesomeIcons.circleArrowLeft,
                  color: BackgroundColor,
                  size: 30,
                )),
          ),
          backgroundColor: BackgroundColor,
          body: Container(
            padding: const EdgeInsets.all(18),
            child: ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 700,
                ),
                Text(
                  "Sign Up",
                  style: TextStyle(
                      color: TextIconColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                Text(
                  "create an Account so you can order you",
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                Text(
                  "favourite products easily and quickly",
                  style: TextStyle(
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 15),
                Form(
                    key: formstate1,
                    child: Column(
                      children: [
                        CustomTextField(
                          text: "Username",
                          state: false,
                          dIcon: Icon(
                            Icons.person,
                            color: ContaierColor,
                            size: 22,
                          ),
                          validator: (p0) {
                            if (p0!.isEmpty) {
                              return "Can't be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          onChanged: (data) {
                            email = data;
                          },
                          text: "Email",
                          state: false,
                          dIcon: Icon(
                            Icons.email,
                            color: ContaierColor,
                          ),
                          validator: (value) {
                            // ignore: unrelated_type_equality_checks
                            if (value!.isEmpty || value == Null) {
                              return "Email can't be Empty";
                            } else if (!value.contains("@")) {
                              return "not type of mail";
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          onChanged: (p0) {
                            password = p0;
                          },
                          text: "Password",
                          state: true,
                          dIcon: Icon(
                            Icons.lock,
                            color: ContaierColor,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password can't be empty";
                            }
                            if (value.length < 8) {
                              return " this pass is short";
                            }
                            return null;
                          },
                          iconData: Icons.visibility,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Custom_Button(
                          text: "Register",
                          onPress: () async {
                            if (formstate1.currentState!.validate()) {
                              try {
                                isloading = true;
                                setState(() {});
                                await authentication();
                                isloading = false;
                                setState(() {});

                                // ignore: use_build_context_synchronously
                                ShowMessage(context, "Success");

                                Navigator.pushReplacementNamed(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    "LoginScreen");
                              // ignore: unused_catch_clause
                              } on FirebaseAuthException catch (e) {
                                ShowMessage(
                                    // ignore: use_build_context_synchronously
                                    context,
                                    "this email is used before");
                                isloading = false;
                                setState(() {});
                              }

                              //Navigator.pop(context);
                            } else {
                              ShowMessage(context, "register field");
                            }
                          },
                        )
                      ],
                    ))
              ],
            ),
          )),
    );
  }

  Future<void> authentication() async {
    var auth = FirebaseAuth.instance;
    // ignore: unused_local_variable
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
