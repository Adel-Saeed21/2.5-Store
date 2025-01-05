import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../data/constant.dart';

class ItemsProfile extends StatelessWidget {
  const ItemsProfile({
    super.key,
    required this.title,
    required this.icon,
    required this.onpress,
    required this.endIcon,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onpress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var tcolor = isDark ? Secondcolor : textColor;
    if (isDark && endIcon == false) {
      tcolor = textColor;
    }
    return ListTile(
      onTap: onpress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: maincolor.withOpacity(0.1)),
        child: Icon(
          icon,
          size: 30,
          color: maincolor,
        ),
      ),
      title: Text(
        title,
        style:
            TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: tcolor),
      ),
      trailing: endIcon
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.grey.withOpacity(0.1)),
              child: Icon(
                LineAwesomeIcons.angle_right_solid,
                size: 18.0,
                color: Colors.grey,
              ),
            )
          : null,
    );
  }
}
