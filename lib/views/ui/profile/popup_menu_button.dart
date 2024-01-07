import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/app_style.dart';
import '../../common/reuseable_text_widget.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({Key? key, required this.onMenuItemSelected})
      : super(key: key);
  final Function(String) onMenuItemSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        iconSize: 25,
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: "set default",
                  child: ReuseableText(
                    text: "Set as default",
                    style: roundFont(14, Colors.black45, FontWeight.normal),
                  )),
              PopupMenuItem(
                value: "remove",
                child: ReuseableText(
                  text: "Remove",
                  style: roundFont(14, Colors.black45, FontWeight.normal),
                ),
              ),
            ],
        onSelected: (value) {
          onMenuItemSelected(value);
        });
  }
}
