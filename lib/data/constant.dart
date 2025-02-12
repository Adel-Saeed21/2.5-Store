import 'package:flutter/material.dart';
import 'package:storeapp/Widgets/productOutAPI.dart';
import 'package:storeapp/Widgets/salesCard.dart';
import 'package:storeapp/data/Images.dart';
import 'package:storeapp/data/searchData.dart';

//0xffECDFCC
Color maincolor = const Color(0xff3A3960);
Color secondcolor = Colors.white;
Color iconColor = const Color(0xffffffff);
Color backColor = const Color(0xff5E686D);
Color tcolor = const Color(0xffFAFFC5);

// ignore: non_constant_identifier_names
Color ContaierColor = const Color(0xff2C3E50);
Color backgroundColor = const Color(0xff2D2D2D);
Color textIconColor = const Color(0xffffffff);
String? tprofileHeading;
String? tprofileEmail;
String? tProfilePicture;

List<SalesCard> salescards = [
  SalesCard(
    prince: 250,
    sales: 100,
    imagess: "images/shirt_sports/Picsart_25-01-01_16-08-03-905.png",
    nameofobj: "Alahly Tshirt",
    details: ahlyList,
  ),
  SalesCard(
      details: arsenalList,
      prince: 250,
      sales: 100,
      imagess: "images/shirt_sports/Picsart_25-01-01_16-09-23-321.png",
      nameofobj: "Arsenal Tshirt"),
  SalesCard(
      details: RealmadridImage,
      prince: 250,
      sales: 100,
      imagess: "images/shirt_sports/Picsart_25-01-01_16-10-06-335.png",
      nameofobj: "Real Tshirt"),
];

// ignore: non_constant_identifier_names
List<String> RealmadridImage = [
  Imagee.Realmadried1,
  Imagee.Realmadried2,
  Imagee.Realmadried3
];
List<String> ahlyList = [Imagee.Ahly1, Imagee.Ahly2, Imagee.Ahly3];
List<String> arsenalList = [Imagee.Arsenal1, Imagee.Arsenal2];

TextEditingController emailControler = TextEditingController();

// tech list
List<Productoutapi> techList = const [
  Productoutapi(
    name: "head phone",
    img: "images/techImages/BlackHeadphone.png",
  ),
  Productoutapi(name: "SmartWatch", img: "images/techImages/SmartWatch.png")
];

TextEditingController passwordValidate = TextEditingController();

final TextEditingController emailController = TextEditingController();
TextEditingController search_controler = TextEditingController();

//search List
List<Searchdata> popularItem = [
  Searchdata(Imagee.Realmadried1, 200, "Realmadried"),
  Searchdata(Imagee.Ahly1, 200, "Alahly"),
  Searchdata(Imagee.Realmadried3, 250, "Realmadried"),
  Searchdata("images/techImages/SmartWatch.png", 200, "smart Watch"),
  Searchdata("images/womanImage/woman1.png", 200, "dress"),
  Searchdata("images/womanImage/woman2.png", 200, "dress"),
  Searchdata("images/womanImage/woman3.png", 200, "dress"),
  Searchdata("images/womanImage/woman4.png", 200, "dress"),
  Searchdata("images/techImages/BlackHeadphone.png", 200, "Headphone"),
];

List<Searchdata> searchedItem = [];
