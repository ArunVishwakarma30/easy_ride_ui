import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/controllers/onboarding_provider.dart';
import 'package:easy_ride/controllers/profile_page_provider.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/common/text_with_icons.dart';
import 'package:easy_ride/views/ui/onboarding/onboarding_screen.dart';
import 'package:easy_ride/views/ui/profile/add_vehicle.dart';
import 'package:easy_ride/views/ui/profile/get_all_vehicles.dart';
import 'package:easy_ride/views/ui/profile/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../profile/edit_mini_bio.dart';
import '../profile/user_profile_page.dart';
import '../profile/verify_user_id.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? token;

  void getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    late String miniBio;
    List<String> travelPreferences = [];
    var onBoardingProvider = Provider.of<OnBoardingProvider>(context);
    int vehicleCount = 0;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white, // Change this to the desired color
      ),
    );
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Consumer<ProfileProvider>(
            builder: (context, profileNotifier, child) {
              profileNotifier.getUser();

              return FutureBuilder(
                  future: profileNotifier.getUserRes,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString(),
                            style:
                                appStyle(20, Colors.black45, FontWeight.bold)),
                      );
                    } else {
                      var userData = snapshot.data;
                      vehicleCount = userData!.vehicles.length;
                      miniBio = userData.miniBio;
                      print(userData.oneSignalId);
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(
                                          () =>
                                              UserProfile(userDetail: userData),
                                          transition: Transition.rightToLeft,
                                          arguments: "myProfile");
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ReuseableText(
                                            text: userData.firstName,
                                            style: roundFont(
                                                28,
                                                Color(darkHeading.value),
                                                FontWeight.bold)),
                                        const HeightSpacer(size: 10),
                                        ReuseableText(
                                            text: "Newcomer",
                                            style: roundFont(
                                                18,
                                                Color(textColor.value),
                                                FontWeight.w100))
                                      ],
                                    ),
                                  ),
                                  const Expanded(child: SizedBox(width: 5)),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => const ProfilePicture(),
                                          transition: Transition.rightToLeft);
                                    },
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor: Colors.white,
                                      backgroundImage: userData.profile.isEmpty
                                          ? const AssetImage(
                                                  "assets/icons/person.png")
                                              as ImageProvider
                                          : NetworkImage(userData.profile),
                                    ),
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
                              const HeightSpacer(size: 14),

                              Divider(
                                color: Color(backGroundLight.value),
                                thickness: 2,
                              ),
                              const HeightSpacer(size: 22),
                              ReuseableText(
                                  text: "Verify your profile",
                                  style: roundFont(24, Color(darkHeading.value),
                                      FontWeight.bold)),
                              const HeightSpacer(size: 22),
                              GestureDetector(
                                onTap: () {
                                  // if (userData.identityDocument.documentImg.isNotEmpty) {
                                  //   // todo : verify user identity here
                                  // }
                                },
                                child: TextWithIcons(
                                  onWidgetTap: () {
                                    // send data if already verified
                                    Get.to(() => const VerifyUserId(),
                                        transition: Transition.rightToLeft);
                                  },
                                  text: userData.identityDocument.documentImg.isNotEmpty
                                      ? "Id Verified"
                                      : "Verify my ID",
                                  containerWidth: width,
                                  textStyle: roundFont(
                                      17, userData.identityDocument.documentImg.isNotEmpty?Colors.black45: loginPageColor, FontWeight.bold),
                                  preFixIcon: userData.identityDocument.documentImg.isNotEmpty
                                      ? Icons.check_circle
                                      : Icons.add_circle_outline_outlined,
                                  iconColor: userData.identityDocument.documentImg.isNotEmpty
                                      ? Colors.green
                                      : Color(loginPageColor.value),
                                ),
                              ),
                              const HeightSpacer(size: 32),
                              TextWithIcons(
                                onWidgetTap: () {
                                  getPrefs();
                                },
                                text: userData.email,
                                containerWidth: width,
                                textStyle: roundFont(
                                    17, Colors.black45, FontWeight.bold),
                                preFixIcon: Icons.check_circle,
                                iconColor: Colors.green,
                              ),
                              const HeightSpacer(size: 32),
                              TextWithIcons(
                                text: userData.phoneNumber,
                                containerWidth: width,
                                textStyle: roundFont(
                                    17, Colors.black45, FontWeight.bold),
                                preFixIcon: Icons.check_circle,
                                iconColor: Colors.green,
                              ),
                              const HeightSpacer(size: 15),
                              Divider(
                                color: Color(backGroundLight.value),
                                thickness: 2,
                              ),
                              const HeightSpacer(size: 22),
                              ReuseableText(
                                  text: "Bio",
                                  style: roundFont(24, Color(darkHeading.value),
                                      FontWeight.bold)),
                              const HeightSpacer(size: 15),
                              miniBio.isNotEmpty
                                  ? InkWell(
                                      onTap: () {
                                        Get.to(() => const EditMiniBio(),
                                            transition: Transition.downToUp,
                                            arguments: userData);
                                      },
                                      child: Text(
                                        miniBio,
                                        style: roundFont(17, Colors.black45,
                                            FontWeight.bold),
                                      ),
                                    )
                                  : TextWithIcons(
                                      onWidgetTap: () {
                                        Get.to(() => const EditMiniBio(),
                                            transition: Transition.downToUp,
                                            arguments: userData);
                                      },
                                      text: "Add mini bio",
                                      containerWidth: width,
                                      textStyle: roundFont(
                                          17, loginPageColor, FontWeight.bold),
                                      preFixIcon:
                                          Icons.add_circle_outline_outlined,
                                      iconColor: Color(loginPageColor.value),
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
                                  style: roundFont(24, Color(darkHeading.value),
                                      FontWeight.bold)),
                              const HeightSpacer(size: 22),

                              TextWithIcons(
                                onWidgetTap: () {
                                  Get.to(() => const AddVehiclePage(),
                                      transition: Transition.rightToLeft);
                                },
                                text: "Add Vehicle",
                                containerWidth: width,
                                textStyle: roundFont(
                                    17, loginPageColor, FontWeight.bold),
                                preFixIcon: Icons.add_circle_outline_outlined,
                                iconColor: Color(loginPageColor.value),
                              ),

                              HeightSpacer(size: vehicleCount > 0 ? 22 : 0),
                              vehicleCount > 0
                                  ? TextWithIcons(
                                      onWidgetTap: () {
                                        Get.to(() => const MyAllVehicles(),
                                            transition: Transition.rightToLeft);
                                      },
                                      text: "My Vehicles",
                                      containerWidth: width,
                                      textStyle: roundFont(
                                          17, loginPageColor, FontWeight.bold),
                                      preFixIcon: Icons.menu,
                                      iconColor: Color(loginPageColor.value),
                                    )
                                  : const SizedBox.shrink(),
                              const HeightSpacer(size: 20),
                              Divider(
                                color: Color(backGroundLight.value),
                                thickness: 2,
                              ),
                              const HeightSpacer(size: 18),
                              TextWithIcons(
                                onWidgetTap: () async {
                                  var prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.setBool('loggedIn', false);
                                  prefs.setBool('entrypoint', false);

                                  onBoardingProvider.setLastPage(false);

                                  Get.offAll(() => const OnBoardingScreen(),
                                      transition: Transition.fade);
                                },
                                text: "Logout",
                                containerWidth: width,
                                textStyle: roundFont(
                                    17, loginPageColor, FontWeight.bold),
                                preFixIcon: Icons.logout,
                                iconColor: Color(loginPageColor.value),
                              ),
                              const HeightSpacer(size: 20),
                            ],
                          ),
                        ),
                      );
                    }
                  });
            },
          )),
    );
  }
}
