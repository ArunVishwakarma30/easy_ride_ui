import 'package:easy_ride/views/common/app_style.dart';
import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.label,
      this.suffixIcon,
      this.validator,
      this.controller,
      required this.keyType,
      required this.textSce,
      this.prefixIcon});
  final String label;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType keyType;
  final bool textSce;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: roundFont(19, Colors.black, FontWeight.w400),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1, style: BorderStyle.solid), // Custom border color
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: 1,
              color: Color(loginPageColor.value)), // Custom border color
        ),
      ),
      validator: validator,
      keyboardType: keyType,
      obscureText: textSce,
    );
  }
}
