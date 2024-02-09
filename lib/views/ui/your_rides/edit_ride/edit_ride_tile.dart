import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditRideTile extends StatelessWidget {
  const EditRideTile(
      {Key? key, required this.title, this.subTitle, required this.onTap, this.subTitleSize})
      : super(key: key);
  final String title;
  final String? subTitle;
  final VoidCallback onTap;
  final double? subTitleSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onTap: onTap,
        title: ReuseableText(
            text: title, style: roundFont(17, lightHeading, FontWeight.bold)),
        subtitle: subTitle != null
            ? Text(subTitle!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: roundFont(subTitleSize ?? 16, Colors.black45, FontWeight.bold))
            : null,
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 21,
          color: Colors.black45,
        ),
      ),
    );
  }
}
