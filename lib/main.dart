import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/Screens/Editprofile.dart';
import 'package:storeapp/Screens/LoginPage.dart';
import 'package:storeapp/Screens/MoreItems.dart';
import 'package:storeapp/Screens/NavigationBar.dart';
import 'package:storeapp/Screens/Profile.dart';
import 'package:storeapp/Screens/SignUpScreen.dart';
import 'package:storeapp/Screens/StartScreen.dart';
import 'package:storeapp/Screens/UpdateproductPage.dart';
import 'package:storeapp/Screens/homePage.dart';
import 'package:storeapp/Screens/order_Screen.dart';
import 'package:storeapp/cubit/cubitRun.dart';
import 'package:storeapp/firebase_options.dart';

late SharedPreferences share;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  share = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => Cubitrun(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            'HomePage': (context) => const Homepage(),
            'Updateproduct': (context) => const UpdateProductPage(),
            'NavigationbarStatus': (context) => const NavigationbarStatus(),
            'LoginScreen': (context) => const LoginScreen(),
            'startscreen': (context) => const StartScreen(),
            'Signup': (context) => const Signupscreen(),
            'EditProfile': (context) => const EditProfile(),
            'Profile': (context) => const Profile(),
            'more': (context) => const Moreitems(),
            'OrderScreen': (context) => const OrderScreen(),
          },
          home: const NavigationbarStatus(),
        ));
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkLoginStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          );
        }

        if (snapshot.data == true) {
          return const NavigationbarStatus();
        } else {
          return const StartScreen();
        }
      },
    );
  }

  Future<bool> _checkLoginStatus() async {
    return share.getBool('isLoggedIn') ?? false;
  }
}
