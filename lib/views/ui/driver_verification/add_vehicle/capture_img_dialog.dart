import 'dart:io';

import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../service.dart';

// Tofix : here create widget instead of function , because we want to return image file onTap..
Future<void> CaptureImageDialog(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      File? vehicleImage;
      return AlertDialog(
          title: ReuseableText(
              text: "Upload your formal picture",
              style: roundFont(20, Color(darkHeading.value), FontWeight.bold)),
          content: SizedBox(
            width: width * 0.8,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    print("hehe");
                    vehicleImage = await captureImage(isImageSourceGallery: false);
                  },
                  child: ReuseableText(
                      text: "Take photo",
                      style: roundFont(
                          18, Color(darkHeading.value), FontWeight.normal)),
                ),
                GestureDetector(
                  onTap: () {
                    print("yohohohoho");
                    // Navigator.of(context).pop();
                  },
                  child: ReuseableText(
                      text: "Choose from Gallery",
                      style: roundFont(
                          18, Color(darkHeading.value), FontWeight.normal)),
                ),
              ],
            ),
          ));
    },
  );
}
