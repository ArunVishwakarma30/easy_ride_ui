import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/cutom_list_title.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/profile/edit_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_constants.dart';
import '../../common/text_with_icons.dart';
import 'edit_mini_bio.dart';

class EditPersonalDetail extends StatefulWidget {
  const EditPersonalDetail({Key? key}) : super(key: key);

  @override
  State<EditPersonalDetail> createState() => _EditPersonalDetailState();
}

class _EditPersonalDetailState extends State<EditPersonalDetail> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: ListView(
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.close_outlined,
                  color: Color(loginPageColor.value),
                  size: 30,
                ),
              ),
            ),
            const HeightSpacer(size: 25),
            ReuseableText(
                text: "Personal Details",
                style: roundFont(25, darkHeading, FontWeight.bold)),
            const HeightSpacer(size: 30),
            CustomListTile(
                heading: "First Name",
                value: "Arun",
                onTap: () {
                  Get.to(
                      () =>
                          const EditText(heading: 'First Name', value: "Arun"),
                      transition: Transition.downToUp);
                }),
            const HeightSpacer(size: 30),
            CustomListTile(
                heading: "Last Name",
                value: "Vishwakarma",
                onTap: () {
                  Get.to(
                      () => const EditText(
                          heading: 'Last Name', value: "Vishwakarma"),
                      transition: Transition.downToUp);
                }),
            const HeightSpacer(size: 30),
            CustomListTile(
                heading: "Email Address",
                value: "arunvishwakarma3009@gmail.com",
                onTap: () {
                  Get.to(
                      () => const EditText(
                          heading: 'Email Address',
                          value: "arunvishwakarma@gmail.com",
                          keyBoardType: TextInputType.emailAddress),
                      transition: Transition.downToUp);
                }),
            const HeightSpacer(size: 30),
            CustomListTile(
                heading: "Phone Number",
                value: "9867559183",
                onTap: () {
                  Get.to(
                      () => const EditText(
                          heading: 'Phone Number',
                          value: "9867559183",
                          keyBoardType: TextInputType.number),
                      transition: Transition.downToUp);
                }),
            const HeightSpacer(size: 20),
            Divider(
              color: Color(backGroundLight.value),
              height: 2,
            ),
            const HeightSpacer(size: 20),

            // todo : here First get mini bio from data base , check if it is empty or not, if it is empty then show  "TextWithIcons" else get the mini bio from the database and show "CustomListTile"
            CustomListTile(
                heading: "Bio",
                value:
                    "Get the data from database and show here or make it invisible",
                onTap: () {
                  Get.to(() => const EditMiniBio(),
                      transition: Transition.downToUp);
                }),
            TextWithIcons(
              onWidgetTap: () {
                Get.to(() => EditMiniBio(), transition: Transition.downToUp);
              },
              text: "Add mini bio",
              containerWidth: width,
              textStyle: roundFont(17, loginPageColor, FontWeight.bold),
              preFixIcon: Icons.add_circle_outline_outlined,
              iconColor: Color(loginPageColor.value),
            ),
          ],
        ),
      )),
    );
  }
}
