import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import 'app_style.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {Key? key,
      required this.heading,
      required this.value,
      required this.onTap, this.valueColor})
      : super(key: key);
  final String heading;
  final Color? valueColor;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ReuseableText(
            text: heading,
            style: roundFont(17, textColor, FontWeight.normal),
          ),
          Text(
            value,
            style: roundFont(21, valueColor ?? loginPageColor, FontWeight.normal),
          ),
        ],
      ),
    );
  }
}
