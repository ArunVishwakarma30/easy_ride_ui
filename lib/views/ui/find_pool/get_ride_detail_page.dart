import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/models/response/search_ride_res_model.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common/walk_icon.dart';

class RideDetailsPage extends StatelessWidget {
  RideDetailsPage({Key? key, required this.searchResult}) : super(key: key);
  final SearchRidesResModel searchResult;
  String? argument = "";
  var args = Get.arguments;

  String formatDateTimeString(DateTime dateTime) {
    // Parse the input string to a DateTime object
    // DateTime dateTime = DateTime.parse(dateTimeString);
    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('EEE d MMMM').format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    argument = args ?? "";
    String? schedule = formatDateTimeString(searchResult.schedule);
    var stopBy = searchResult.stopBy;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: loginPageColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
            fit: StackFit.expand,
            children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ReuseableText(
                      text: schedule,
                      style: roundFont(25, darkHeading, FontWeight.bold)),
                ),
                const HeightSpacer(size: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: stopBy.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print("Show address in map");
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ReuseableText(
                                        text:
                                            "${searchResult.schedule.hour.toString()}:${searchResult.schedule.minute.toString()}",
                                        style: roundFont(
                                            17, darkHeading, FontWeight.bold)),
                                    ReuseableText(
                                        text: "${2}h${30}",
                                        style: roundFont(
                                            17,
                                            stopBy.length - 1 == index
                                                ? Colors.white
                                                : darkHeading,
                                            FontWeight.normal)),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Text(stopBy[index].address,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 5,
                                                  style: roundFont(
                                                      17,
                                                      darkHeading,
                                                      FontWeight.bold))),
                                        ],
                                      ),
                                      (argument!.isNotEmpty &&
                                              ((index == 0) ||
                                                  (index == stopBy.length - 1)))
                                          ? Row(
                                              children: [
                                                const WalkIcon(
                                                    radius: 10,
                                                    col: Colors.greenAccent),
                                                Text(
                                                  "3 km from your departure/arrival",
                                                  style: roundFont(
                                                      14,
                                                      Colors.green,
                                                      FontWeight.normal),
                                                )
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10, left: 5),
                                  child: Icon(Icons.arrow_forward_ios,
                                      size: 18, color: darkHeading),
                                )
                              ],
                            ),
                            index == stopBy.length - 1
                                ? const SizedBox.shrink()
                                : Container(
                                    margin: const EdgeInsets.only(
                                        left: 70, bottom: 10),
                                    child: Image.asset(
                                      "assets/icons/route.png",
                                      width: 40,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const HeightSpacer(size: 10),
                const Divider(
                  thickness: 10,
                  color: Colors.black12,
                ),
                const HeightSpacer(size: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReuseableText(
                          text: "Total price for 1 passenger",
                          style: roundFont(17, lightHeading, FontWeight.bold)),
                      ReuseableText(
                          text: "\u20B9${searchResult.pricePerPass}.00",
                          style: roundFont(22, darkHeading, FontWeight.bold))
                    ],
                  ),
                ),
                const HeightSpacer(size: 10),
                const Divider(
                  thickness: 10,
                  color: Colors.black12,
                ),
                const HeightSpacer(size: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ReuseableText(
                              text: searchResult.driverId.firstName,
                              style:
                                  roundFont(17, darkHeading, FontWeight.bold)),
                          const Expanded(
                              child: SizedBox(
                            width: 1,
                          )),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            backgroundImage: searchResult
                                    .driverId.profile.isNotEmpty
                                ? NetworkImage(searchResult.driverId.profile)
                                : const AssetImage('assets/icons/person.png')
                                    as ImageProvider,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: darkHeading,
                          )
                        ],
                      ),
                      const HeightSpacer(size: 10),
                      const Divider(),
                      const HeightSpacer(size: 10),
                      Text(
                        searchResult.aboutRide,
                        style: roundFont(18, darkHeading, FontWeight.normal),
                      ),
                      const HeightSpacer(size: 20),
                      GestureDetector(onTap: (){
                        print("Send to the chat page and initiate the chat between users");
                      }, child: ReuseableText(text: "Contact ${searchResult.driverId.firstName}", style: roundFont(18, loginPageColor, FontWeight.bold))),
                      const HeightSpacer(size: 10),
                      const Divider(),

                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
              bottom: 1,
              left: 20,
              child: ElevatedButton(
                onPressed: () {
                  print("Send a request to the driver for booking this ride ");
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: loginPageColor,
                    minimumSize:
                        Size(MediaQuery.of(context).size.width - 40, 45)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/event.png",
                      height: 20,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ReuseableText(
                        text: "Request to book",
                        style: roundFont(19, Colors.white, FontWeight.normal))
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
