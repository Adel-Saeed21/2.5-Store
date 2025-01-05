import 'package:flutter/material.dart';

import 'package:storeapp/data/constant.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    //var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // var backcolor = isDark ? Colors.black : Colors.white;
    return Scaffold(
      backgroundColor: BackgroundColor,
      body: ListView(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 750,
            ),
            // ignore: avoid_unnecessary_containers
            Container(
              child: Image.asset(
                "images/bagstart.png",
                height: MediaQuery.sizeOf(context).height - 400,
                width: MediaQuery.sizeOf(context).width - 30,
              ),
            ),
            const SizedBox(
              height: 100,
            ),

            SizedBox(
              width: 300,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: TextIconColor,
                        width: 2,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    Navigator.pushNamed(context, "LoginScreen");
                  },
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        color: TextIconColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )),
            ),
            Container(
              width: 340,
              height: 75,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: () {
                  Navigator.pushNamed(context, "Signup");
                },
                color: TextIconColor,
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
