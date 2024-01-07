import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/app_style.dart';
import '../../common/reuseable_text_widget.dart';

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({
    Key? key,
    required this.onMenuItemSelected,
    required this.isDefault,
  }) : super(key: key);

  final Function(String) onMenuItemSelected;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      iconSize: 25,
      itemBuilder: (context) {
        // Create a list to hold the PopupMenuItems
        List<PopupMenuEntry<String>> menuItems = [];

        // Add the "Remove" item
        menuItems.add(
          PopupMenuItem(
            value: "remove",
            child: ReuseableText(
              text: "Remove",
              style: roundFont(14, Colors.black45, FontWeight.normal),
            ),
          ),
        );

        // Add the "Set as default" item only if isDefault is false
        if (!isDefault) {
          menuItems.add(
            PopupMenuItem(
              value: "set default",
              child: ReuseableText(
                text: "Set as default",
                style: roundFont(14, Colors.black45, FontWeight.normal),
              ),
            ),
          );
        }

        // Return the list of PopupMenuItems
        return menuItems;
      },
      onSelected: (value) {
        onMenuItemSelected(value);
      },
    );
  }
}
