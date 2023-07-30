// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HeightSpacer extends StatelessWidget {
  const HeightSpacer({
    Key? key,
    required this.size,
  }) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
    );
  }
}
