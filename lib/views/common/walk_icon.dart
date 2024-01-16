import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalkIcon extends StatelessWidget {
  const WalkIcon({Key? key, required this.radius, required this.col})
      : super(key: key);
  final double radius;
  final Color col;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 3),
      child: CircleAvatar(
          radius: radius,
          backgroundColor: col,
          child: const Icon(
            Icons.directions_walk,
            size: 17,
            color: Colors.white,
          )),
    );
  }
}
