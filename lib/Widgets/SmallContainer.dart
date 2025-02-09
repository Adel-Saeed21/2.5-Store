// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SmallContainerHome extends StatelessWidget {
  SmallContainerHome({
    super.key,
    this.child,
    required this.padding,
    this.color = Colors.white,
  });

  final Widget? child;
  final double padding;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(padding),
      width: 20,
      height: 4,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
      child: child,
    );
  }
}
