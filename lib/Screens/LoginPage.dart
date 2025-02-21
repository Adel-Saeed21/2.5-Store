// ignore: 
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/Widgets/CustomTextField.dart';
import 'package:storeapp/Widgets/Custom_Button.dart';
import 'package:storeapp/data/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formState = GlobalKey();

  String? email;

  String? password;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    //var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // var backcolor = isDark ? Colors.black : Colors.white;
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                FontAwesomeIcons.circleArrowLeft,
                color: maincolor,
                size: 30,
              )),
        ),
        backgroundColor: backgroundColor,
        body: Container(
          padding: const EdgeInsets.all(18),
          child: ListView(
            children: [
              const SizedBox(
                height: 150,
              ),
              Text(
                "Welcome Back!",
                style: TextStyle(
                    color: ContaierColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 33),
              ),
              const Text(
                "Sign in to your account.",
                style: TextStyle(color: Color.fromARGB(255, 114, 113, 113)),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                  key: formState,
                  child: Column(
                    children: [
                      CustomTextField(
                        text: "Email",
                        state: false,
                        dIcon: Icon(
                          Icons.email_rounded,
                          color: textIconColor,
                        ),
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Email  requiered ";
                          }
                          if (!p0.contains("@")) {
                            return "this form not type for Email";
                          }
                          return null;
                        },
                        onChanged: (p0) {
                          email = p0;
                          tprofileEmail = p0;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        dIcon: Icon(
                          Icons.lock,
                          color: textIconColor,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password required";
                          }
                          return null;
                        },
                        onChanged: (p0) {
                          password = p0;
                        },
                        text: "Password",
                        iconData: Icons.visibility,
                        state: true,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width - 170,
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forget Password?",
                                style: TextStyle(
                                    color: textIconColor, fontSize: 13),
                              ))
                        ],
                      ),
                      Custom_Button(
                        text: "Login",
                        onPress: () async {
                          if (formState.currentState!.validate()) {
                            try {
                              loading = true;
                              setState(() {});
                              await SignIn();
                              loading = false;
                              setState(() {});
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool('isLoggedIn', true);
                              await prefs.setString('userEmail', email!);
                              Navigator.pushReplacementNamed(
                                  // ignore: use_build_context_synchronously
                                  context, "NavigationbarStatus",
                                  arguments: email);
                            } on FirebaseAuthException catch (e) {
                              // ignore: use_build_context_synchronously
                              Showevent(context, "Error: ${e.message}");
                            }
                          } else {
                            Showevent(context, "login Field");
                          }
                        },
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  void Showevent(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      content: Text(message),
    ));
  }

  // ignore: non_constant_identifier_names
  Future<void> SignIn() async {
    var auth = FirebaseAuth.instance;

    UserCredential user = await auth.signInWithEmailAndPassword(
        email: email!, password: password!);

    // ignore: avoid_print
    print("Login Successful: ${user.user?.email}");
  }
}
