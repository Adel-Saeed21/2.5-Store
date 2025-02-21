// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/Screens/Editprofile.dart';
import 'package:storeapp/Widgets/ItemsProfile.dart';
import 'package:storeapp/data/constant.dart';
import 'package:storeapp/services/Firebase/getUserData.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    setState(() {}); // تحميل البيانات عند فتح الشاشة
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: textIconColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              isDark ? LineAwesomeIcons.moon : LineAwesomeIcons.sun,
              color: textIconColor,
            ),
          ),
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data != null) {
            var userData = snapshot.data!;
            String username = userData['username'] ?? 'N/A';
            String phone = userData['phoneNumber'] ?? 'N/A';
            String email = userData['email'] ?? 'N/A';
            String profileImageBase64 = userData['img'] ?? '';

            Uint8List? imageBytes;
            try {
              if (profileImageBase64.isNotEmpty) {
                imageBytes = base64Decode(profileImageBase64);
              }
            } catch (e) {
              print("Error decoding base64 image: $e");
            }

            return SingleChildScrollView(
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
                            child: imageBytes != null
                                ? Image.memory(
                                    imageBytes,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(
                                    Icons.person,
                                    size: 100,
                                    color: Colors.white,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textIconColor,
                      ),
                    ),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: textIconColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditProfile(
                                    img: profileImageBase64,
                                    email: email,
                                    phoneNumber: phone,
                                    username: username,
                                  )));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ContaierColor,
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          "Edit profile",
                          style: TextStyle(
                            fontSize: 20,
                            color: textIconColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Divider(height: 0, color: Colors.transparent),
                    ItemsProfile(
                      onpress: () {},
                      icon: LineAwesomeIcons.cog_solid,
                      title: "Settings",
                      textColor: Colors.white,
                      endIcon: true,
                    ),
                    ItemsProfile(
                      onpress: () {},
                      icon: LineAwesomeIcons.wallet_solid,
                      title: "Billing Details",
                      textColor: Colors.white,
                      endIcon: true,
                    ),
                    ItemsProfile(
                      onpress: () {},
                      icon: LineAwesomeIcons.user_check_solid,
                      title: "User management",
                      textColor: Colors.white,
                      endIcon: true,
                    ),
                    const Divider(),
                    const SizedBox(height: 20),
                    ItemsProfile(
                      onpress: () {},
                      icon: LineAwesomeIcons.info_solid,
                      title: "Information",
                      textColor: Colors.white,
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
                      title: "Logout",
                      textColor: Colors.red,
                      endIcon: false,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Failed to load user data.'));
          }
        },
      ),
    );
  }
}
