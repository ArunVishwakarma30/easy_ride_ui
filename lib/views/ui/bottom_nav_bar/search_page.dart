import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/departure_info_pages/add_location_page.dart';
import 'package:easy_ride/views/ui/departure_info_pages/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../common/text_with_icons.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String leaveFrom = "Leaving From";
  String goingTo = "Going To";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white, // Background color for the status bar
      statusBarIconBrightness:
          Brightness.dark, // Dark icons for better visibility
    ));
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    double fontSize = width < 600 ? 19 : 22;
    double iconSize = width < 600 ? 24 : 30;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                height: height * 0.46,
                width: width,
                child:
                    Image.asset("assets/images/search.jpg", fit: BoxFit.fill),
              ),
            ],
          ),
          Positioned(
            top: height * 0.1,
            left: width * 0.15,
            child: Center(
                child: ReuseableText(
              text: "Your pick of rides at low prices",
              style: roundFont(width * 0.06, Colors.white, FontWeight.bold),
            )),
          ),
          Positioned(
              top: height * 0.32,
              left: width * 0.06,
              child: Container(
                width: width * 0.87,
                height: height * 0.32,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 3),
                        blurRadius: 6,
                        spreadRadius: 0,
                      )
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // in below there will be main three widgets,
                    // 1. Leaving from text field
                    // 2. Going tp text field
                    // 3. Departure date and number of seats
                    Padding(
                      padding: EdgeInsets.all(height * 0.03),
                      child: Column(
                        children: [
                          TextWithIcons(
                            preFixIcon: Icons.my_location,
                            text: leaveFrom,
                            postFixIcon: leaveFrom != "Leaving From"
                                ? Icons.swap_vert_sharp
                                : null,
                            containerWidth: width * 0.87,
                            textStyle: roundFont(
                                fontSize,
                                leaveFrom != "Leaving From"
                                    ? Colors.black
                                    : Colors.black45,
                                leaveFrom != "Leaving From"
                                    ? FontWeight.w500
                                    : FontWeight.bold),
                            onTextTap: () {
                              print("Leaving from text  pressed");
                              Get.to(const AddLocationPage(),
                                  transition: Transition.downToUp,
                                  duration: const Duration(milliseconds: 600),
                                  arguments: leaveFrom);
                            },
                            onPostFixTap: () {
                              print("swap icon pressed");
                            },
                          ),
                          Container(
                            padding:
                                EdgeInsets.symmetric(vertical: height * 0.01),
                            child: const Divider(
                              color: Colors.black45,
                              thickness: 1, // Adjust the thickness as needed
                            ),
                          ),
                          TextWithIcons(
                            preFixIcon: Icons.edit_location_alt,
                            text: goingTo,
                            containerWidth: width * 0.87,
                            textStyle: roundFont(
                                fontSize,
                                goingTo != "Going To"
                                    ? Colors.black
                                    : Colors.black45,
                                goingTo != "Going To"
                                    ? FontWeight.w500
                                    : FontWeight.bold),
                            onTextTap: () {
                              print("Going to text  pressed");
                              Get.to(const AddLocationPage(),
                                  transition: Transition.downToUp,
                                  duration: const Duration(milliseconds: 600),
                                  arguments: goingTo);
                            },
                          ),
                          Container(
                            padding:
                                EdgeInsets.symmetric(vertical: height * 0.013),
                            child: const Divider(
                              color: Colors.black45,
                              thickness: 1, // Adjust the thickness as needed
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () {
                                    print("Calendar icon pressed");
                                    Get.to(Calendar());
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        size: iconSize,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: ReuseableText(
                                          text: "Today",
                                          style: roundFont(fontSize,
                                              Colors.black, FontWeight.w500),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    print("Person Icon pressed");
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 1,
                                        color: Colors.black45,
                                      ),
                                      const Expanded(
                                          flex: 2,
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.black45,
                                          )),
                                      Expanded(
                                        flex: 1,
                                        child: ReuseableText(
                                          text: "1", // Your number here
                                          style: roundFont(fontSize,
                                              Colors.black, FontWeight.w500),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // ----------three widgets ends

                    // --> submit button code
                    ElevatedButton(
                      onPressed: () {
                        print("Elevated button pressed");
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 50)),
                        backgroundColor: MaterialStateProperty.all(
                            Color(loginPageColor.value)),
                        // Set the button's background color to blue

                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              // Adjust the radius as needed
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      child: ReuseableText(
                        text: "Search",
                        style:
                            roundFont(fontSize, Colors.white, FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
