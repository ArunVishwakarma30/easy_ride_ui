import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/controllers/find_pool_provider.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/common/text_with_icons.dart';
import 'package:easy_ride/views/ui/find_pool/car_design.dart';
import 'package:easy_ride/views/ui/find_pool/find_location_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../controllers/add_vehicle_provider.dart';
import '../ui/find_pool/recent_search_page.dart';

class TravelDetails extends StatefulWidget {
  const TravelDetails({
    super.key,
    required this.searchBtnText,
    required this.searchBtnPressed,
    required this.onLeaveFromTextChange,
    required this.onGoingToTextChange,
    this.selectSeats,
    required this.onTapRecentSearchItem,
    required this.heading,
    required this.isOfferPoolPage,
  });

  final bool isOfferPoolPage;
  final String searchBtnText;
  final String heading;
  final VoidCallback searchBtnPressed;
  final VoidCallback? selectSeats;
  final Function(String?) onLeaveFromTextChange;
  final Function(String?) onGoingToTextChange;

  // Tofix : get the data from the database and send the data accordingly
  final Function(String?) onTapRecentSearchItem;

  @override
  State<TravelDetails> createState() => _TravelDetailsState();
}

class _TravelDetailsState extends State<TravelDetails> {
  String leaveFrom = "Leaving From";
  String goingTo = "Going To";

  List<String> recentSearches = [
    "Dummy data 1",
    "Dummy data 2",
    "Dummy data 3",
    "Dummy data 4",
  ];

  @override
  Widget build(BuildContext context) {
    final findPoolProvider = Provider.of<FindPoolProvider>(context);
    final addVehicleProvider = Provider.of<AddVehicle>(context);
    int numOfSeatsSelected = addVehicleProvider.numOfSeatSelected;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white, // Background color for the status bar
      statusBarIconBrightness:
          Brightness.dark, // Dark icons for better visibility
    ));

    DateTime? providerDateTime = findPoolProvider.travelDateTime!;
    String dateTime =
        "${providerDateTime!.day.toString()} ${monthNames[providerDateTime.month - 1]}, ${providerDateTime.hour}:${providerDateTime.minute}";
    widget.onLeaveFromTextChange(leaveFrom);
    widget.onGoingToTextChange(goingTo);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    double fontSize = width < 600 ? 19 : 22;
    double iconSize = width < 600 ? 24 : 30;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width,
            height: height * 0.63,
            child: Stack(
              children: [
                SizedBox(
                  height: height * 0.46,
                  width: width,
                  child:
                      Image.asset("assets/images/search.jpg", fit: BoxFit.fill),
                ),
                Positioned(
                  top: height * 0.1,
                  left: width * 0.15,
                  child: Center(
                      child: Text(
                    widget.heading,
                    textAlign: TextAlign.center,
                    style:
                        roundFont(width * 0.06, Colors.white, FontWeight.bold),
                  )),
                ),
                Positioned(
                    top: height * 0.32,
                    left: width * 0.06,
                    child: Container(
                      width: width * 0.87,
                      // height: height * 0.32,
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
                                  onTextTap: () async {
                                    print("Leaving from text pressed");

                                    // Use Get.to to navigate to FindLocationPage
                                    String result = await Get.to(
                                        const FindLocationPage(),
                                        transition: Transition.downToUp,
                                        duration:
                                            const Duration(milliseconds: 600),
                                        arguments: leaveFrom);

                                    // Handle the result (data sent back from FindLocationPage)
                                    if (result != null) {
                                      // Do something with the result, such as updating a variable
                                      print(
                                          "Data from FindLocationPage: $result");
                                      setState(() {
                                        leaveFrom =
                                            result; // Update the leaveFrom variable with the result
                                      });
                                    }
                                  },
                                  onPostFixTap: () {
                                    if ((leaveFrom != "Leaving From") &&
                                        (goingTo != "Going To")) {
                                      String temp = leaveFrom;
                                      leaveFrom = goingTo;
                                      goingTo = temp;
                                      setState(() {});
                                    }
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.01),
                                  child: const Divider(
                                    color: Colors.black45,
                                    thickness:
                                        1, // Adjust the thickness as needed
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
                                    Get.to(const FindLocationPage(),
                                        transition: Transition.downToUp,
                                        duration:
                                            const Duration(milliseconds: 600),
                                        arguments: goingTo);
                                  },
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.013),
                                  child: const Divider(
                                    color: Colors.black45,
                                    thickness:
                                        1, // Adjust the thickness as needed
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: GestureDetector(
                                        onTap: () {
                                          findPoolProvider
                                              .setTravelDateTime(context);
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
                                                text: dateTime,
                                                style: roundFont(
                                                    fontSize,
                                                    Colors.black,
                                                    FontWeight.w500),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    widget.isOfferPoolPage
                                        ? const SizedBox.shrink()
                                        : Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: widget.selectSeats,
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
                                                        Icons
                                                            .airline_seat_recline_extra,
                                                        color: Colors.black45,
                                                      )),
                                                  Expanded(
                                                    flex: 1,
                                                    child: ReuseableText(
                                                      text: numOfSeatsSelected
                                                          .toString(),
                                                      // Your number here
                                                      style: roundFont(
                                                          fontSize,
                                                          Colors.black,
                                                          FontWeight.w500),
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
                            onPressed: widget.searchBtnPressed,
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  const Size(double.infinity, 50)),
                              backgroundColor: MaterialStateProperty.all(
                                  Color(loginPageColor.value)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
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
                              text: widget.searchBtnText,
                              style: roundFont(
                                  fontSize, Colors.white, FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          Visibility(
              visible: recentSearches.isNotEmpty ? true : false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: width * 0.07, right: width * 0.05, top: 5),
                    child: ReuseableText(
                      text: "Recent Searches",
                      style: roundFont(
                          24, Color(loginPageColor.value), FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                    padding: EdgeInsets.only(
                        left: width * 0.07,
                        right: width * 0.07,
                        top: 5,
                        bottom: 60),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return RecentSearch(
                        onTap: () {
                          widget.onTapRecentSearchItem(recentSearches[index]);
                        },
                        pickUpLocation:
                            "Safed pool, Sakinaka, Shanti nagar, Maharashtra",
                        destinationLocation:
                            "Maharashtra, Ramniranjan Jhunjhunwala college, Ghatkopar East 400086",
                        date: "Mon 13 Nov",
                        numOfPassengers: "2",
                      );
                    },
                  )
                ],
              )),
        ],
      ),
    );
  }
}
