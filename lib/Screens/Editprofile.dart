import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:storeapp/Widgets/InputTextField.dart';
import 'package:storeapp/data/constant.dart';

class Editprofile extends StatelessWidget {
  const Editprofile({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var backcolor = isDark ? Colors.black : Colors.white;
    var textcolor = isDark ? Colors.white : Colors.black;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backcolor,
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
              fontSize: 25, fontWeight: FontWeight.bold, color: textcolor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                          image: AssetImage("images/adel (2).jpg"))),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: maincolor),
                    child: const Icon(
                      LineAwesomeIcons.camera_solid,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25, left: 25),
              child: Form(
                  child: Column(
                children: [
                  inputTextfiled(
                    username: "Full name",
                    iconData: Icons.person,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  inputTextfiled(
                    username: "Email",
                    iconData: Icons.email,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  inputTextfiled(
                    username: "phone number",
                    iconData: Icons.phone,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              )),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: maincolor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  onPressed: () {},
                  child: const Text(
                    "Edit profile",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
