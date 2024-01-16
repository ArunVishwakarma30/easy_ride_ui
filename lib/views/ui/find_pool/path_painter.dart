import 'package:easy_ride/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = darkHeading
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final path = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 6),
          radius: size.width / 4))
      ..moveTo(size.width / 2, size.height / 4.5)
      ..lineTo(size.width / 2, (size.height / 6.5) * 5)
      ..addOval(Rect.fromCircle(
          center: Offset(size.width / 2, (size.height / 6) * 5),
          radius: size.width / 4));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
