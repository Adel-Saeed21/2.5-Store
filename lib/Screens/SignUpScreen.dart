// ignore_for_file: file_names, avoid_types_as_parameter_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:storeapp/Widgets/CustomTextField.dart';
import 'package:storeapp/Widgets/Custom_Button.dart';
import 'package:storeapp/cubit/cubitRun.dart';
import 'package:storeapp/cubit/cubitState.dart';
import 'package:storeapp/data/constant.dart';
import 'package:storeapp/helper/SnaceBar.dart';
import 'package:storeapp/services/Firebase/SignUpFirebase.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  GlobalKey<FormState> formstate1 = GlobalKey();
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  } 
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  if (RegExp(r'[A-Z]').allMatches(value).length < 2) {
    return 'Password must contain at least two uppercase letters';
  }
  if (RegExp(r'[a-z]').allMatches(value).length < 2) {
    return 'Password must contain at least two lowercase letters';
  }
  if (RegExp(r'\d').allMatches(value).length < 3) {
    return 'Password must contain at least three digits';
  }
  if (RegExp(r'[@$!%*?&]').allMatches(value).isEmpty) {
    return 'Password must contain at least one special character (@, \$, !, %, *, ?, &)';
  }
  return null;
}

  String? email, password, username;
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    // var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // var backcolor = BackgroundColor;
    return BlocConsumer<Cubitrun, cubitState>(
        builder: (context, State) {
          return ModalProgressHUD(
            inAsyncCall: isloading,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: backgroundColor,
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: ContaierColor,
                        size: 30,
                      )),
                ),
                backgroundColor: backgroundColor,
                body: Container(
                  padding: const EdgeInsets.all(18),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 800,
                      ),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            color: textIconColor,
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
                                onChanged: (p0) {
                                  username = p0;
                                },
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
                                mycontroller: passwordValidate,
                                onChanged: (p0) {
                                  password = p0;
                                },
                                text: "Password",
                                state: true,
                                dIcon: Icon(
                                  Icons.lock,
                                  color: ContaierColor,
                                ),
                                validator: validatePassword,
                                iconData: Icons.visibility,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              FlutterPwValidator(
                                  width: 370,
                                  height: 150,
                                  minLength: 8,
                                  successColor: ContaierColor,
                                  uppercaseCharCount: 2,
                                  lowercaseCharCount: 2,
                                  numericCharCount: 3,
                                  specialCharCount: 1,
                                  failureColor: Colors.red,
                                  onFail: () {
                                    BlocProvider.of<Cubitrun>(context)
                                        .setPasswordValidation(false);
                                  },
                                  onSuccess: () {
                                    BlocProvider.of<Cubitrun>(context)
                                        .setPasswordValidation(true);
                                  },
                                  controller: passwordValidate),
                              const SizedBox(
                                height: 30,
                              ),
                              Custom_Button(
                                text: "Register",
                                onPress: () async {
                                  if (formstate1.currentState!.validate() &&
                                      BlocProvider.of<Cubitrun>(context)
                                              .isPasswordValid ==
                                          true) {
                                    try {
                                      isloading = true;
                                      setState(() {});
                                      // await authentication();
                                      await signUpWithEmail(
                                          email: email!,
                                          password: password!,
                                          username: username!,
                                          phoneNumber: "01020237163");
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
        },
        listener: (context, State) {});
  }

  /*Future<void> authentication() async {
    var auth = FirebaseAuth.instance;
    // ignore: unused_local_variable
    UserCredential user = await auth.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }*/
}
