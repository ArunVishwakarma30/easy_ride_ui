import 'package:easy_ride/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextWithIcons extends StatelessWidget {
  const TextWithIcons(
      {Key? key,
      this.preFixIcon,
      this.postFixIcon,
      required this.text,
      this.textStyle,
      this.onTextTap,
      this.onPostFixTap,
      this.iconColor = Colors.black,
      required this.containerWidth, this.onWidgetTap, this.maxLines = 1})
      : super(key: key);

  final IconData? preFixIcon;
  final double containerWidth;
  final IconData? postFixIcon;
  final String text;
  final TextStyle? textStyle;
  final VoidCallback? onTextTap;
  final VoidCallback? onPostFixTap;
  final Color? iconColor;
  final VoidCallback? onWidgetTap;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    double iconSize = containerWidth < 600 ? 24 : 30;
    return GestureDetector(
      onTap: onWidgetTap,
      child: Row(
        children: [
          if (preFixIcon != null)
            SizedBox(
              child: GestureDetector(
                onTap: onTextTap,
                child: Icon(
                  preFixIcon,
                  size: iconSize,
                  color: iconColor,
                ),
              ),
            ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 13),
              child: GestureDetector(
                onTap: onTextTap,
                child: Text(
                  text,
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle ?? const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
          if (postFixIcon != null)
            SizedBox(
              child: GestureDetector(
                onTap: onPostFixTap,
                child: Icon(
                  postFixIcon,
                  size: 30,
                  color: Color(loginPageColor.value),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
