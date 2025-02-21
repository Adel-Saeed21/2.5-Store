// ignore_for_file: file_names

import 'package:flutter/material.dart';

void ShowMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: const Duration(seconds:1),
  ));
}
