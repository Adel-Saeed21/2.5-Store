import 'package:flutter/material.dart';
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
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? email;
  String? password;
  bool loading = false;

  void setLoading(bool value) {
    setState(() {
      loading = value;
    });
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email is required";
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.length < 8) {
      return "Password must be at least 8 characters long";
    }
    return null;
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  Future<void> signIn() async {
    if (!formState.currentState!.validate()) {
      showSnackbar(context, "Please fill all required fields.");
      return;
    }

    try {
      setLoading(true);
      await _auth.signInWithEmailAndPassword(email: email!, password: password!);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userEmail', email!);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, "NavigationbarStatus", arguments: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        // ignore: use_build_context_synchronously
        showSnackbar(context, "Incorrect email or password");
      } else {
        // ignore: use_build_context_synchronously
        showSnackbar(context, "Error: ${e.message}");
      }
    } finally {
      setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: loading,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios, color: ContaierColor, size: 30),
          ),
        ),
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: ListView(
            children: [
              const SizedBox(height: 150),
              Text("Welcome Back!", style: TextStyle(color: ContaierColor, fontWeight: FontWeight.bold, fontSize: 33)),
              const Text("Sign in to your account.", style: TextStyle(color: Color(0xFF727171))),
              const SizedBox(height: 20),
              Form(
                key: formState,
                child: Column(
                  children: [
                    CustomTextField(
                      text: "Email",
                      state: false,
                      dIcon: Icon(Icons.email_rounded, color: textIconColor),
                      validator: validateEmail,
                      onChanged: (p0) => email = p0,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      text: "Password",
                      state: true,
                      dIcon: Icon(Icons.lock, color: textIconColor),
                      iconData: Icons.visibility,
                      validator: validatePassword,
                      onChanged: (p0) => password = p0,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Forget Password?", style: TextStyle(color: textIconColor, fontSize: 13)),
                      ),
                    ),
                    Custom_Button(text: "Login", onPress: signIn),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
