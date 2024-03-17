import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/models/request/accept_or_deny_req.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/common/text_with_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controllers/your_rides_provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, this.userDetail, this.rideId}) : super(key: key);
  final userDetail;
  final rideId;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  late String args;

  String formatDateTimeString(DateTime dateTime) {
    // Parse the input string to a DateTime object
    // DateTime dateTime = DateTime.parse(dateTimeString);
    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('d MMMM y').format(dateTime);
    return formattedDate;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    args = Get.arguments ?? "";
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;
    var userData = widget.userDetail;
    return Scaffold(
        backgroundColor: CupertinoColors.white,
        appBar: AppBar(
          backgroundColor: CupertinoColors.white,
          iconTheme: const IconThemeData(color: loginPageColor),
        ),
        body: Stack(children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ReuseableText(
                              text: userData.firstName,
                              style:
                              roundFont(25, darkHeading, FontWeight.bold)),
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            backgroundImage: userData.profile.isNotEmpty
                                ? NetworkImage(userData.profile)
                                : const AssetImage('assets/icons/person.png')
                            as ImageProvider,
                          ),
                        ],
                      ),
                      const HeightSpacer(size: 20),
                      TextWithIcons(
                        onWidgetTap: () {
                          print("Redirect user to user ratings page");
                        },
                        text: "4/4 - 5 ratings",
                        textStyle: roundFont(18, darkHeading, FontWeight.bold),
                        containerWidth: width - 20,
                        preFixIcon: Icons.star,
                        iconColor: Colors.grey,
                        postFixIcon: Icons.arrow_forward_ios,
                        postFixIconColor: Colors.grey.shade700,
                        postFixIconSize: 20,
                      ),
                      const HeightSpacer(size: 32),
                      TextWithIcons(
                        text: userData.email,
                        containerWidth: width,
                        textStyle:
                        roundFont(17, Colors.black45, FontWeight.bold),
                        preFixIcon: Icons.check_circle,
                        iconColor: Colors.green,
                      ),
                      const HeightSpacer(size: 32),
                      TextWithIcons(
                        text: userData.phoneNumber,
                        containerWidth: width,
                        textStyle:
                        roundFont(17, Colors.black45, FontWeight.bold),
                        preFixIcon: Icons.check_circle,
                        iconColor: Colors.green,
                      ),
                      const HeightSpacer(size: 30),
                      ReuseableText(
                        text: "About ${userData.firstName}",
                        style: roundFont(25, darkHeading, FontWeight.bold),
                      ),
                      const HeightSpacer(size: 20),
                      TextWithIcons(
                        text: "I talk depending on my mood",
                        containerWidth: width,
                        textStyle: roundFont(18, Colors.grey, FontWeight.bold),
                        preFixIcon: Icons.chat,
                        iconColor: Colors.grey.shade700,
                      ),
                    ]),
              ),
              const HeightSpacer(size: 14),
              Divider(
                color: Colors.grey.shade300,
                thickness: 10,
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ReuseableText(
                    text:
                    "Member since ${formatDateTimeString(userData.createdAt)}",
                    style: roundFont(18, Colors.grey, FontWeight.bold)),
              ),
              Divider(
                color: Colors.grey.shade300,
                thickness: 10,
              ),
              HeightSpacer(size: 14),
            ],
          ),
          args == "passengerRequest"
              ? Positioned(
              bottom: 20.0,
              left: 20,
              child: Container(
                width: width - 40,
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            AcceptOrDenyReq model = AcceptOrDenyReq(
                                isAccepted: false);
                            YourRidesProvider provider = Provider.of<
                                YourRidesProvider>(context, listen: false);
                            provider.acceptOrDeclineUserRideReq(
                                model, widget.rideId);
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                  color: CupertinoColors.systemGrey2,
                                  width: 1)),
                          child: Text(
                            "Decline",
                            style: roundFont(
                                18, loginPageColor, FontWeight.bold),
                          )),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {
                            AcceptOrDenyReq model = AcceptOrDenyReq(
                                isAccepted: true);
                            YourRidesProvider provider = Provider.of<
                                YourRidesProvider>(context, listen: false);
                            provider.acceptOrDeclineUserRideReq(
                                model, widget.rideId);
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor: loginPageColor,
                              side: const BorderSide(
                                  color: Colors.grey, width: 0)),
                          child: Text(
                            "Accept",
                            style: roundFont(
                                18, Colors.white, FontWeight.bold),
                          )),
                    )
                  ],
                ),
              ))
              : const SizedBox.shrink()
        ]));
  }
}
