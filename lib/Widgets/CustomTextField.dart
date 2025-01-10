import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:storeapp/data/constant.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      this.validator,
      required this.text,
      this.iconData,
      required this.state,
      this.dIcon,
      this.onChanged, this.mycontroller, });
  Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String text;
  final IconData? iconData;
  final bool state;
  final Icon? dIcon;
final TextEditingController? mycontroller;
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}


class _CustomTextFieldState extends State<CustomTextField> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      obscureText: widget.state ? !show : show,
      style: TextStyle(color: textIconColor),
      maxLines: 1,
      validator: widget.validator,
      controller:widget.mycontroller,
      decoration: InputDecoration(
        // Conditional rendering of icon
        suffixIcon: widget.state
            ? IconButton(
                icon: Icon(
                  show ? Icons.visibility_off : Icons.visibility,
                  color: textIconColor,
                ),
                onPressed: () {
                  setState(() {
                    show = !show; // Toggle the `show` variable
                  });
                },
              )
            : Icon(
                widget.iconData,
                color: textIconColor, // Normal icon when state is false
              ),
        prefixIcon: widget.dIcon,
        labelText: widget.text,
        labelStyle: TextStyle(color: textIconColor, fontSize: 18),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ContaierColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ContaierColor),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: ContaierColor),
        ),
        enabled: true,
      ),
    );
  }
}
