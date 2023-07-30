import 'package:flutter/material.dart';
import 'package:easy_ride/constants/app_constants.dart';

class ShadowBtn extends StatelessWidget {
  const ShadowBtn({
    Key? key,
    this.child,
    required this.size,
    this.width = 200.0,
    this.height = 60.0,
    this.onTap,
    this.gradientColor1 = lightShade, // Default gradient color 1
    this.gradientColor2 = const Color.fromARGB(255, 123, 136, 170),
  }) : super(key: key);

  final Widget? child;
  final double size;
  final double width;
  final double height;
  final VoidCallback? onTap;
  final Color gradientColor1;
  final Color gradientColor2;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientColor2, gradientColor1],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(25.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 10,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Center(
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    );
  }
}
