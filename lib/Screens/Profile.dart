// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/Widgets/ItemsProfile.dart';
import 'package:storeapp/data/constant.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // var backcolor = isDark ? Colors.black : Colors.white;
    // var textcolor = isDark ? Colors.white : Colors.black;
    return Scaffold(
      backgroundColor: BackgroundColor,
      appBar: AppBar(
        backgroundColor: BackgroundColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              LineAwesomeIcons.angle_left_solid,
              color: TextIconColor,
            )),
        title: Center(
          child: Text(
            "Profile",
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: TextIconColor),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                isDark ? LineAwesomeIcons.moon : LineAwesomeIcons.sun,
                color: TextIconColor,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
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
                          color: ContaierColor),
                      child: Icon(
                        LineAwesomeIcons.pencil_alt_solid,
                        size: 20,
                        color: TextIconColor,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                tprofileHeading!,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: TextIconColor),
              ),
              Text(
                tprofileEmail!,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: TextIconColor),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "EditProfile");
                  },
                  // ignore: sort_child_properties_last
                  child: Text(
                    "Edit profile",
                    style: TextStyle(
                        fontSize: 20,
                        color: TextIconColor,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ContaierColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Divider(
                height: 0,
                color: Colors.transparent,
              ),
              ItemsProfile(
                onpress: () {},
                icon: LineAwesomeIcons.cog_solid,
                title: "Settings",
                textColor: Colors.black,
                endIcon: true,
              ),
              ItemsProfile(
                onpress: () {},
                icon: LineAwesomeIcons.wallet_solid,
                title: "Billing Details",
                textColor: Colors.black,
                endIcon: true,
              ),
              ItemsProfile(
                onpress: () {},
                icon: LineAwesomeIcons.user_check_solid,
                title: "User management",
                textColor: Colors.black,
                endIcon: true,
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              ItemsProfile(
                onpress: () {},
                icon: LineAwesomeIcons.info_solid,
                title: "Information",
                textColor: Colors.black,
                endIcon: true,
              ),
              ItemsProfile(
                onpress: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setBool('isLoggedIn', false);
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(context, "startscreen");
                },
                icon: LineAwesomeIcons.sign_out_alt_solid,
                title: "logout",
                textColor: Colors.red,
                endIcon: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
