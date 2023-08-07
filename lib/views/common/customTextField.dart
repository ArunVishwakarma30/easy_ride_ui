import 'package:easy_ride/views/common/app_style.dart';
import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.label,
      this.validator,
      this.controller,
      required this.keyType,
      required this.textSce, required this.prefixIcon});
  final String label;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType keyType;
  final bool textSce;
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: roundFont(19, Colors.black, FontWeight.w400),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black), // Custom border color
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Color(loginPageColor.value)), // Custom border color
        ),
      ),
      validator: validator,
      controller: controller,
      keyboardType: keyType,
      obscureText: textSce,
    );
  }
}
