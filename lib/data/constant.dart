import 'package:flutter/material.dart';
import 'package:storeapp/Widgets/salesCard.dart';
import 'package:storeapp/data/Images.dart';

Color maincolor = const Color(0xff3A3960);
Color Secondcolor = Colors.white;
Color IconColor = const Color(0xffECDFCC);
Color BackColor = const Color(0xff5E686D);
Color Tcolor = const Color(0xffFAFFC5);

// ignore: non_constant_identifier_names
Color ContaierColor = const Color(0xffE16A54);
Color BackgroundColor = const Color(0xff9F5255);
Color TextIconColor = const Color(0xffF39E60);
String tprofileHeading = "Adel saeed";
String tprofileEmail = "";

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

class Containercolor {
  int? num;
  String? image;
  Containercolor(String img, int x) {
    this.num = x;
    this.image = img;
  }
}

List<Containercolor> alahly = [
  Containercolor(Imagee.Ahly1, 1),
  Containercolor(Imagee.Ahly2, 2),
  Containercolor(Imagee.Ahly3, 3)
];
