import 'dart:io';

import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/controllers/add_vehicle_provider.dart';
import 'package:easy_ride/controllers/onboarding_provider.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/common/text_with_icons.dart';
import 'package:easy_ride/views/ui/onboarding/onboarding_screen.dart';
import 'package:easy_ride/views/ui/profile/add_vehicle.dart';
import 'package:easy_ride/views/ui/profile/edit_personal_detail.dart';
import 'package:easy_ride/views/ui/profile/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../profile/edit_mini_bio.dart';
import '../profile/verify_user_id.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    bool isIdVerified = false;
    String?
        emailId; //todo : get the email id from database OR from shared preference
    String?
        phoneNumber; // todo : get the phone number id from database OR from shared preference
    File? profileImage;
    String? miniBio;
    List<String> travelPreferences = [];
    var onBoardingProvider = Provider.of<OnBoardingProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReuseableText(
                            text: "Arun",
                            style: roundFont(
                                28, Color(darkHeading.value), FontWeight.bold)),
                        const HeightSpacer(size: 10),
                        ReuseableText(
                            text: "Newcomer",
                            style: roundFont(
                                18, Color(textColor.value), FontWeight.w100))
                      ],
                    ),
                    const Expanded(child: SizedBox(width: 5)),
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      backgroundImage: profileImage == null
                          ? const AssetImage("assets/icons/person.png")
                              as ImageProvider
                          : FileImage(profileImage),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Color(darkHeading.value),
                    )
                  ],
                ),
                const HeightSpacer(size: 20),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const ProfilePicture(),
                            transition: Transition.rightToLeft)
                        ?.then((result) {
                      // user came back with some result
                      if (result != null && result is bool) {
                        //result !=null this will handle the error , in case user came back using device's back button
                        // todo :  get the user's profile image from database, and store it in the 'profileImage';
                        setState(() {});
                      }
                    });
                  },
                  child: ReuseableText(
                      text: "Edit profile picture",
                      style: roundFont(17, loginPageColor, FontWeight.bold)),
                ),
                const HeightSpacer(size: 25),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const EditPersonalDetail(),
                        transition: Transition.downToUp);
                  },
                  child: ReuseableText(
                      text: "Edit personal details",
                      style: roundFont(17, loginPageColor, FontWeight.bold)),
                ),
                const HeightSpacer(size: 20),
                Divider(
                  color: Color(backGroundLight.value),
                  thickness: 2,
                ),
                const HeightSpacer(size: 22),
                ReuseableText(
                    text: "Verify your profile",
                    style: roundFont(
                        24, Color(darkHeading.value), FontWeight.bold)),
                const HeightSpacer(size: 22),
                GestureDetector(
                  onTap: () {
                    if (!isIdVerified) {
                      // todo : verify user identity here
                    }
                  },
                  child: TextWithIcons(
                    onWidgetTap: () {
                      Get.to(() => const VerifyUserId(),
                          transition: Transition.rightToLeft);
                    },
                    text: isIdVerified ? "Id Verified" : "Verify my ID",
                    containerWidth: width,
                    textStyle: roundFont(17, loginPageColor, FontWeight.bold),
                    preFixIcon: isIdVerified
                        ? Icons.check_circle
                        : Icons.add_circle_outline_outlined,
                    iconColor: isIdVerified
                        ? Colors.green
                        : Color(loginPageColor.value),
                  ),
                ),
                const HeightSpacer(size: 32),
                TextWithIcons(
                  text: emailId ?? "Confirm email ID",
                  containerWidth: width,
                  textStyle: roundFont(
                      17,
                      emailId == null ? loginPageColor : Colors.black45,
                      FontWeight.bold),
                  preFixIcon: emailId == null
                      ? Icons.add_circle_outline_outlined
                      : Icons.check_circle,
                  iconColor: emailId == null ? loginPageColor : Colors.green,
                ),
                const HeightSpacer(size: 32),
                TextWithIcons(
                  text: phoneNumber ?? "Confirm phone number",
                  containerWidth: width,
                  textStyle: roundFont(
                      17,
                      phoneNumber == null ? loginPageColor : Colors.black45,
                      FontWeight.bold),
                  preFixIcon: phoneNumber == null
                      ? Icons.add_circle_outline_outlined
                      : Icons.check_circle,
                  iconColor:
                      phoneNumber == null ? loginPageColor : Colors.green,
                ),
                const HeightSpacer(size: 15),
                Divider(
                  color: Color(backGroundLight.value),
                  thickness: 2,
                ),
                const HeightSpacer(size: 22),
                ReuseableText(
                    text: "About",
                    style: roundFont(
                        24, Color(darkHeading.value), FontWeight.bold)),
                const HeightSpacer(size: 22),
                TextWithIcons(
                  onWidgetTap: () {
                    Get.to(() => EditMiniBio(),
                        transition: Transition.downToUp);
                  },
                  text: miniBio ?? "Add mini bio",
                  containerWidth: width,
                  textStyle: roundFont(
                      17,
                      miniBio == null ? loginPageColor : Colors.black45,
                      FontWeight.bold),
                  preFixIcon: miniBio == null
                      ? Icons.add_circle_outline_outlined
                      : Icons.check_circle,
                  iconColor: miniBio == null
                      ? Color(loginPageColor.value)
                      : Colors.green,
                ),
                // const HeightSpacer(size: 32),
                // // todo : Create a list view builder to show all the travel preferences
                // GestureDetector(
                //   onTap: () {},
                //   child: TextWithIcons(
                //     text:
                //         "${travelPreferences.isEmpty ? "Add" : "Edit"} travel preferences",
                //     containerWidth: width,
                //     textStyle: roundFont(17, loginPageColor, FontWeight.bold),
                //     preFixIcon: Icons.add_circle_outline_outlined,
                //     iconColor: loginPageColor,
                //   ),
                // ),
                const HeightSpacer(size: 15),
                Divider(
                  color: Color(backGroundLight.value),
                  thickness: 2,
                ),
                const HeightSpacer(size: 22),
                ReuseableText(
                    text: "Vehicles",
                    style: roundFont(
                        24, Color(darkHeading.value), FontWeight.bold)),
                const HeightSpacer(size: 22),
                TextWithIcons(
                  onWidgetTap: () {
                    // todo : go to add vehicle page
                    Get.to(() => const AddVehiclePage(),
                        transition: Transition.rightToLeft);
                  },
                  text: "Add Vehicle",
                  containerWidth: width,
                  textStyle: roundFont(17, loginPageColor, FontWeight.bold),
                  preFixIcon: Icons.add_circle_outline_outlined,
                  iconColor: Color(loginPageColor.value),
                ),
                const HeightSpacer(size: 20),
                // todo : here create a list view to get the all the vehicles from the database, user added till now,

                Divider(
                  color: Color(backGroundLight.value),
                  thickness: 2,
                ),
                const HeightSpacer(size: 18),
                TextWithIcons(
                  onWidgetTap: () async {
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setBool('loggedIn', false);
                    prefs.setBool('entrypoint', false);

                    onBoardingProvider.setLastPage(false);

                    Get.offAll(() => const OnBoardingScreen(),
                        transition: Transition.fade);
                  },
                  text: "Logout",
                  containerWidth: width,
                  textStyle: roundFont(17, loginPageColor, FontWeight.bold),
                  preFixIcon: Icons.logout,
                  iconColor: Color(loginPageColor.value),
                ),
                const HeightSpacer(size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
