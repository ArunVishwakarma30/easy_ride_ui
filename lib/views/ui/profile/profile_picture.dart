import 'dart:io';

import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/common/service.dart';
import 'package:easy_ride/views/common/shadow_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                GestureDetector(
                  onTap: () {
                    Get.back(result: false); // going back without saving the image into database
                  },
                  child: Icon(
                    Icons.arrow_back_outlined,
                    color: Color(loginPageColor.value),
                    size: 30,
                  ),
                ),
                _image == null
                    ? const SizedBox.shrink()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0, backgroundColor: backgroundGrey),
                        onPressed: () {
                          // todo : save the image into database
                          Get.back(result: true); // going back with capturing the image and saving it into database;
                        },
                        child: ReuseableText(
                          text: "Save",
                          style: roundFont(18, loginPageColor, FontWeight.bold),
                        ))
              ]),
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Color(backGroundLight.value),
                  backgroundImage: _image == null
                      ? AssetImage("assets/images/profile_person.png")
                          as ImageProvider
                      : FileImage(_image!),
                ),
              ),
              const HeightSpacer(size: 20),
              Text(
                "Don't wear sunglasses, look straight ahead and make sure you're alone ",
                style: roundFont(27, Color(darkHeading.value), FontWeight.bold),
              ),
              const Expanded(child: HeightSpacer(size: 10)),
              ElevatedButton(
                  onPressed: () async {
                    _image = await captureImage(isImageSourceGallery: false);
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: loginPageColor,
                      minimumSize: Size(width, 50)),
                  child: ReuseableText(
                    text: "Take a picture",
                    style: roundFont(18, Colors.white, FontWeight.normal),
                  )),
              const HeightSpacer(size: 10),
              ElevatedButton(
                  onPressed: () async {
                    _image = await captureImage(isImageSourceGallery: true);
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: backgroundGrey,
                      minimumSize: Size(width, 50)),
                  child: ReuseableText(
                    text: "Choose from gallery",
                    style: roundFont(18, loginPageColor, FontWeight.normal),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
