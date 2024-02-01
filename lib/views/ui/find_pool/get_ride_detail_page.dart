import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/models/response/search_ride_res_model.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/common/text_with_icons.dart';
import 'package:easy_ride/views/ui/offer_pool/map_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../controllers/add_vehicle_provider.dart';
import '../../../controllers/map_provider.dart';
import '../../../models/map/direction_model.dart';
import '../../common/walk_icon.dart';
import '../profile/my_vehicles_list_tile.dart';
import 'map_locaiton_page.dart';

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
    var vehicleProvider = Provider.of<AddVehicle>(context);

    argument = args ?? "";
    String? schedule = formatDateTimeString(searchResult.schedule);
    var stopBy = searchResult.stopBy;

    String? vehicleImage = "";
    bool isImageEmpty = false;
    if (searchResult.vehicleId.image.isEmpty) {
      isImageEmpty = true;
      if (searchResult.vehicleId.type == 'Auto Rickshaw' ||
          searchResult.vehicleId.type == 'Car') {
        Map<String, String>? selectedCarImg = carTypeAndImg
            .firstWhere((car) => car['Name'] == searchResult.vehicleId.model);

        vehicleImage = selectedCarImg['Img'].toString();
      } else {
        Map<String, String>? selectedBikeImg = bikeTypeAndImg
            .firstWhere((car) => car['Name'] == searchResult.vehicleId.model);

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
                    return GestureDetector(
                      onTap: () async {
                        List<LatLng> coordinates = [];

                        // Assuming stopBy is a List<StopBy> in your rideDetails
                        for (StopBy stop in searchResult.stopBy) {
                          String? placeId = stop.gMapAddressId;

                          // Call the getPlaceDirectionDetails method to get coordinates
                          Directions? coordinatesDetails = await MapProvider().getPlaceDirectionDetails(placeId);

                          // Add coordinates to the list if available
                          if (coordinatesDetails != null &&
                              coordinatesDetails.locationLatitude != null &&
                              coordinatesDetails.locationLongitude != null) {
                            coordinates.add(
                              LatLng(
                                coordinatesDetails.locationLatitude!,
                                coordinatesDetails.locationLongitude!,
                              ),
                            );
                          }
                        }

                    Get.to(()=>RouteScreen(places : coordinates));

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
                                text: searchResult.driverId.firstName,
                                style: roundFont(
                                    17, darkHeading, FontWeight.bold)),
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
                      ),
                      const HeightSpacer(size: 10),
                      const Divider(),
                      const HeightSpacer(size: 10),
                      Text(
                        searchResult.aboutRide,
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
                                  "Contact ${searchResult.driverId.firstName}",
                              style: roundFont(
                                  18, loginPageColor, FontWeight.bold))),
                      const HeightSpacer(size: 10),
                      const Divider(),
                      const HeightSpacer(size: 20),
                      TextWithIcons(
                        text: searchResult.directBooking
                            ? "Your booking will be confirmed instantly."
                            : "Your booking won't be confirmed until the driver approves your request",
                        maxLines: 3,
                        textStyle:
                            roundFont(18, darkHeading, FontWeight.normal),
                        containerWidth: MediaQuery.of(context).size.width - 100,
                        preFixIcon: searchResult.directBooking
                            ? Icons.electric_bolt_outlined
                            : Icons.time_to_leave_outlined,
                        iconColor: Colors.black45,
                      ),
                      const HeightSpacer(size: 20),
                      const Divider(),
                      const HeightSpacer(size: 10),
                      MyVehiclesListTile(
                        modelName: searchResult.vehicleId.model,
                        registrationNumber:
                            searchResult.vehicleId.registrationNumber,
                        isDefault: false,
                        viewVehicleDetails: true,
                        vehicleImage: isImageEmpty
                            ? vehicleImage
                            : searchResult.vehicleId.image,
                        exception: searchResult.vehicleId.exception,
                        makeAndCategory: searchResult.vehicleId.makeAndCategory,
                        numberOfSeats: vehicleProvider.numOfSeatSelected,
                        onTap: () {},
                        isImageEmpty: searchResult.vehicleId.image.isEmpty,
                        selectingVehicle: true,
                        vehicleId: searchResult.vehicleId.id,
                      ),
                      const Divider(),
                      const HeightSpacer(size: 10),
                      searchResult.vehicleId.features.isNotEmpty
                          ? TextWithIcons(
                              text: searchResult.vehicleId.features,
                              maxLines: 3,
                              textStyle:
                                  roundFont(18, darkHeading, FontWeight.normal),
                              containerWidth:
                                  MediaQuery.of(context).size.width - 100,
                              iconColor: Colors.black45,
                              preFixIcon: Icons.star_border_purple500,
                            )
                          : const SizedBox.shrink(),
                      searchResult.vehicleId.features.isNotEmpty
                          ? const HeightSpacer(size: 15)
                          : const SizedBox.shrink(),
                      searchResult.vehicleId.exception.isNotEmpty
                          ? TextWithIcons(
                              text: searchResult.vehicleId.exception,
                              maxLines: 3,
                              textStyle:
                                  roundFont(18, darkHeading, FontWeight.normal),
                              containerWidth:
                                  MediaQuery.of(context).size.width - 100,
                              iconColor: Colors.black45,
                              preFixIcon: Icons.not_interested,
                            )
                          : const SizedBox.shrink(),
                      (searchResult.vehicleId.type == 'Bike' ||
                              searchResult.vehicleId.type == 'Scooter')
                          ? const HeightSpacer(size: 15)
                          : const SizedBox.shrink(),
                      (searchResult.vehicleId.type == 'Bike' ||
                              searchResult.vehicleId.type == 'Scooter')
                          ? TextWithIcons(
                              text: searchResult.vehicleId.requiredHelmet
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
                searchResult.passangersId.isNotEmpty
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
                      searchResult.passangersId.isNotEmpty
                          ? ReuseableText(
                              text: "Passengers",
                              style:
                                  roundFont(22, darkHeading, FontWeight.bold))
                          : const SizedBox.shrink(),
                      const HeightSpacer(size: 10),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchResult.passangersId.length,
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
                                        text: searchResult
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
                                      backgroundImage: searchResult
                                              .passangersId[index]
                                              .profile
                                              .isNotEmpty
                                          ? NetworkImage(searchResult
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
                              index < searchResult.passangersId.length - 1
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
                    searchResult.directBooking
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
                        text: searchResult.directBooking
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
