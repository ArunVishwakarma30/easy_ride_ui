import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/models/response/search_ride_res_model.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/common/text_with_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../controllers/add_vehicle_provider.dart';
import '../profile/my_vehicles_list_tile.dart';
import 'map_locaiton_page.dart';

class RideDetailsPage extends StatelessWidget {
  RideDetailsPage(
      {Key? key, required this.rideDetail, required this.routeInfo})
      : super(key: key);
  var rideDetail;   
  final List<dynamic> routeInfo;
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
    print("objectkjnbkjnkheheeeeeeeeeee");

    var vehicleProvider = Provider.of<AddVehicle>(context);
    List<LatLng> directions = routeInfo[0];
    String polyLines = routeInfo[1];
    List<int> hrs = routeInfo[2];
    List<int> mins = routeInfo[3];

    argument = args ?? "";
    String? schedule = formatDateTimeString(rideDetail.schedule);
    var stopBy = rideDetail.stopBy;

    String? vehicleImage = "";
    bool isImageEmpty = false;
    if (rideDetail.vehicleId.image.isEmpty) {
      isImageEmpty = true;
      if (rideDetail.vehicleId.type == 'Auto Rickshaw' ||
          rideDetail.vehicleId.type == 'Car') {
        Map<String, String>? selectedCarImg = carTypeAndImg
            .firstWhere((car) => car['Name'] == rideDetail.vehicleId.model);

        vehicleImage = selectedCarImg['Img'].toString();
      } else {
        Map<String, String>? selectedBikeImg = bikeTypeAndImg
            .firstWhere((car) => car['Name'] == rideDetail.vehicleId.model);

        vehicleImage = selectedBikeImg['Img'].toString();
      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: loginPageColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(fit: StackFit.expand, children: [
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
                    late String travelDurationString;
                    // Calculating next location time
                    DateTime travelTime = rideDetail.schedule;
                    String travelTimeString =
                        "${travelTime.hour.toString()}:${travelTime.minute.toString()}";
                    if (index > 0 && index < rideDetail.stopBy.length) {
                      DateTime newTravelTime = travelTime.add(Duration(
                          hours: hrs[index - 1], minutes: mins[index - 1]));
                      travelTimeString =
                          "${newTravelTime.hour.toString()}:${newTravelTime.minute.toString()}";
                    }
                    if (index < rideDetail.stopBy.length - 1) {
                      travelDurationString = hrs[index] == 0
                          ? "${mins[index].toString()}m"
                          : "${hrs[index].toString()}h${mins[index].toString()}";
                    } else {
                      travelDurationString = "";
                    }

                    return GestureDetector(
                      onTap: () async {
                        Get.to(() => RouteScreen(
                              places: directions,
                              polyLinePoints: polyLines,
                            ));

                        // Navigate to RouteScreen with coordinates
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => RouteScreen(coordinates: coordinates)),
                        // );
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
                                        text: travelTimeString,
                                        style: roundFont(
                                            17, darkHeading, FontWeight.bold)),
                                    ReuseableText(
                                        text: travelDurationString,
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
                          text: "\u20B9${rideDetail.pricePerPass}.00",
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
                      InkWell(
                        radius: 0,
                        onTap: () {
                          print(
                              "Go to the drivers page and show required personal details to the passenger");
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ReuseableText(
                                text: rideDetail.driverId.firstName,
                                style: roundFont(
                                    17, darkHeading, FontWeight.bold)),
                            const Expanded(
                                child: SizedBox(
                              width: 1,
                            )),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              backgroundImage: rideDetail
                                      .driverId.profile.isNotEmpty
                                  ? NetworkImage(rideDetail.driverId.profile)
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
                      ),
                      const HeightSpacer(size: 10),
                      const Divider(),
                      const HeightSpacer(size: 10),
                      Text(
                        rideDetail.aboutRide,
                        style: roundFont(18, darkHeading, FontWeight.normal),
                      ),
                      const HeightSpacer(size: 20),
                      GestureDetector(
                          onTap: () {
                            print(
                                "Send to the chat page and initiate the chat between users");
                          },
                          child: ReuseableText(
                              text:
                                  "Contact ${rideDetail.driverId.firstName}",
                              style: roundFont(
                                  18, loginPageColor, FontWeight.bold))),
                      const HeightSpacer(size: 10),
                      const Divider(),
                      const HeightSpacer(size: 20),
                      TextWithIcons(
                        text: rideDetail.directBooking
                            ? "Your booking will be confirmed instantly."
                            : "Your booking won't be confirmed until the driver approves your request",
                        maxLines: 3,
                        textStyle:
                            roundFont(18, darkHeading, FontWeight.normal),
                        containerWidth: MediaQuery.of(context).size.width - 100,
                        preFixIcon: rideDetail.directBooking
                            ? Icons.electric_bolt_outlined
                            : Icons.time_to_leave_outlined,
                        iconColor: Colors.black45,
                      ),
                      const HeightSpacer(size: 20),
                      const Divider(),
                      const HeightSpacer(size: 10),
                      MyVehiclesListTile(
                        modelName: rideDetail.vehicleId.model,
                        registrationNumber:
                            rideDetail.vehicleId.registrationNumber,
                        isDefault: false,
                        viewVehicleDetails: true,
                        vehicleImage: isImageEmpty
                            ? vehicleImage
                            : rideDetail.vehicleId.image,
                        exception: rideDetail.vehicleId.exception,
                        makeAndCategory: rideDetail.vehicleId.makeAndCategory,
                        numberOfSeats: vehicleProvider.numOfSeatSelected,
                        onTap: () {},
                        isImageEmpty: rideDetail.vehicleId.image.isEmpty,
                        selectingVehicle: true,
                        vehicleId: rideDetail.vehicleId.id,
                      ),
                      const Divider(),
                      const HeightSpacer(size: 10),
                      rideDetail.vehicleId.features.isNotEmpty
                          ? TextWithIcons(
                              text: rideDetail.vehicleId.features,
                              maxLines: 3,
                              textStyle:
                                  roundFont(18, darkHeading, FontWeight.normal),
                              containerWidth:
                                  MediaQuery.of(context).size.width - 100,
                              iconColor: Colors.black45,
                              preFixIcon: Icons.star_border_purple500,
                            )
                          : const SizedBox.shrink(),
                      rideDetail.vehicleId.features.isNotEmpty
                          ? const HeightSpacer(size: 15)
                          : const SizedBox.shrink(),
                      rideDetail.vehicleId.exception.isNotEmpty
                          ? TextWithIcons(
                              text: rideDetail.vehicleId.exception,
                              maxLines: 3,
                              textStyle:
                                  roundFont(18, darkHeading, FontWeight.normal),
                              containerWidth:
                                  MediaQuery.of(context).size.width - 100,
                              iconColor: Colors.black45,
                              preFixIcon: Icons.not_interested,
                            )
                          : const SizedBox.shrink(),
                      (rideDetail.vehicleId.type == 'Bike' ||
                              rideDetail.vehicleId.type == 'Scooter')
                          ? const HeightSpacer(size: 15)
                          : const SizedBox.shrink(),
                      (rideDetail.vehicleId.type == 'Bike' ||
                              rideDetail.vehicleId.type == 'Scooter')
                          ? TextWithIcons(
                              text: rideDetail.vehicleId.requiredHelmet
                                  ? "You have to carry helmet"
                                  : "You don't have to carry helmet",
                              maxLines: 3,
                              textStyle:
                                  roundFont(18, darkHeading, FontWeight.normal),
                              containerWidth:
                                  MediaQuery.of(context).size.width - 100,
                              iconColor: Colors.black45,
                              preFixIcon: Icons.label_important,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                rideDetail.passangersId.isNotEmpty
                    ? const Divider(
                        thickness: 10,
                        color: Colors.black12,
                      )
                    : const SizedBox.shrink(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeightSpacer(size: 10),
                      rideDetail.passangersId.isNotEmpty
                          ? ReuseableText(
                              text: "Passengers",
                              style:
                                  roundFont(22, darkHeading, FontWeight.bold))
                          : const SizedBox.shrink(),
                      const HeightSpacer(size: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: rideDetail.passangersId.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              InkWell(
                                radius: 0,
                                onTap: () {
                                  print(
                                      "Go to the passengers page and show required personal details to the passenger");
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ReuseableText(
                                        text: rideDetail
                                            .passangersId[index].firstName,
                                        style: roundFont(
                                            17, darkHeading, FontWeight.bold)),
                                    const Expanded(
                                        child: SizedBox(
                                      width: 1,
                                    )),
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundColor: Colors.white,
                                      backgroundImage: rideDetail
                                              .passangersId[index]
                                              .profile
                                              .isNotEmpty
                                          ? NetworkImage(rideDetail
                                              .passangersId[index].profile)
                                          : const AssetImage(
                                                  'assets/icons/person.png')
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
                              ),
                              const HeightSpacer(size: 5),
                              index < rideDetail.passangersId.length - 1
                                  ? const Divider()
                                  : const SizedBox.shrink(),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
                const HeightSpacer(size: 50)
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
                    rideDetail.directBooking
                        ? const Icon(
                            Icons.electric_bolt_outlined,
                            color: Colors.white,
                            size: 17,
                          )
                        : Image.asset(
                            "assets/icons/event.png",
                            height: 20,
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    ReuseableText(
                        text: rideDetail.directBooking
                            ? "Book"
                            : "Request to book",
                        style: roundFont(19, Colors.white, FontWeight.normal))
                  ],
                ),
              )),
        ]),
      ),
    );
  }
}
