import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/your_rides/edit_ride/edit_ride_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/map_provider.dart';
import '../../../models/map/direction_model.dart';
import '../../../models/response/your_rides_res_model.dart';
import '../../common/height_spacer.dart';
import '../find_pool/get_ride_detail_page.dart';
import '../find_pool/map_locaiton_page.dart';
import 'edit_ride/edit_publication.dart';

class RidePlan extends StatefulWidget {
  const RidePlan({Key? key, required this.rideDetail}) : super(key: key);
  final YourCreatedRidesResModel rideDetail;

  @override
  State<RidePlan> createState() => _RidePlanState();
}

class _RidePlanState extends State<RidePlan> {
  late List<StopBy> stopBy;
  late String date;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stopBy = widget.rideDetail.stopBy;
    date = formatDateTimeString(widget.rideDetail.schedule);
  }

  String formatDateTimeString(DateTime dateTime) {
    // Parse the input string to a DateTime object
    // DateTime dateTime = DateTime.parse(dateTimeString);
    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('EEE d MMMM').format(dateTime);
    return formattedDate;
  }

  Future<List<dynamic>> getRouteDetails(
      YourCreatedRidesResModel searchResult) async {
    // at index [0] it will contain the List<LatLng> coordinates
    // at index [1] there is a String which is for polyLine
    // at index [2] there is a List<int> hrs
    // at index [3] there is a List<int> mins
    List<dynamic> routeRes = [];
    var mapProvider = Provider.of<MapProvider>(context, listen: false);
    List<LatLng> coordinates = [];

    for (StopBy stop in searchResult.stopBy) {
      String? placeId = stop.gMapAddressId;

      Directions? coordinatesDetails =
          await MapProvider().getPlaceDirectionDetails(placeId);

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
    routeRes.add(coordinates);
    var directionDetailInfo =
        await mapProvider.getOriginToDestinationDirectionDetails(coordinates);
    routeRes.add(directionDetailInfo![0]!.ePoints!);

    // Extracting hours and minutes from each DirectionDetailsInfo
    List<int> hrs = [];
    List<int> mins = [];

    for (int i = 0; i < directionDetailInfo.length; i++) {
      int durationInSeconds = directionDetailInfo[i]!.durationValue!;
      int hour = durationInSeconds ~/ 3600; // 1 hour = 3600 seconds
      int minute = (durationInSeconds % 3600) ~/ 60;

      // Adding hours and minutes to the respective lists
      hrs.add(hour);
      mins.add(minute);
    }

    // Adding hours and minutes lists to the result
    routeRes.add(hrs);
    routeRes.add(mins);

    return routeRes;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ReuseableText(
            text: "Ride Plan",
            style: roundFont(22, darkHeading, FontWeight.bold)),
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: loginPageColor),
      ),
      body: FutureBuilder(
        future: getRouteDetails(widget.rideDetail),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display CircularProgressIndicator while waiting
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.withOpacity(0.25),
                highlightColor: Colors.white.withOpacity(0.6),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Colors.grey.withOpacity(0.9),
                          ),
                        ),
                        const HeightSpacer(size: 20),
                        Container(
                          width: width - 30,
                          height: 100 * stopBy.length.toDouble(),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.withOpacity(0.9),
                          ),
                        ),
                        const HeightSpacer(size: 20),
                        Container(
                          width: width - 70,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Colors.grey.withOpacity(0.9),
                          ),
                        ),
                        const HeightSpacer(size: 20),
                        Container(
                          width: width - 40,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Colors.grey.withOpacity(0.9),
                          ),
                        ),
                        const HeightSpacer(size: 20),
                        Container(
                          width: 150,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Colors.grey.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            // Handle error
            return Text(snapshot.error.toString());
          } else {
            var routeInfo = snapshot.data;
            // NOTE : route info contain this elements
            // index[0] ==> list of Lat Long
            // index[1] ==> PolyLineDetails to show the route inside map
            // index[2] ==> List of int which is for hrs
            // index[3] ==> List of int which is for min
            // List<LatLng> directions = routeInfo![0];
            // String polyLineString = routeInfo[1];
            List<int> hrs = routeInfo![2];
            List<int> mins = routeInfo[3];

            return ListView(
              padding: const EdgeInsets.all(15),
              children: [
                // TODO : Create a ListView.builder for all the ride request getting from other users
                // TODO : also create divider
                ReuseableText(
                    text: date,
                    style: roundFont(22, darkHeading, FontWeight.bold)),
                const HeightSpacer(size: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: stopBy.length,
                  itemBuilder: (context, index) {
                    late String travelDurationString;
                    // Calculating next location time
                    DateTime travelTime = widget.rideDetail.schedule;
                    String travelTimeString =
                        "${travelTime.hour.toString()}:${travelTime.minute.toString()}${travelTime.minute.toString().length == 1 ? '0' : ""}";
                    if (index > 0 && index < stopBy.length) {
                      DateTime newTravelTime = travelTime.add(Duration(
                          hours: hrs[index - 1], minutes: mins[index - 1]));
                      travelTimeString =
                          "${newTravelTime.hour.toString()}:${newTravelTime.minute.toString()}${newTravelTime.minute.toString().length == 1 ? "0" : ""}";
                    }
                    if (index < stopBy.length - 1) {
                      travelDurationString = hrs[index] == 0
                          ? "${mins[index].toString()}${mins[index].toString().length == 1 ? "0" : ""}min"
                          : "${hrs[index].toString()}h${mins[index].toString()}${mins[index].toString().length == 1 ? "0" : ""}";
                    } else {
                      travelDurationString = "";
                    }

                    return GestureDetector(
                      onTap: () async {
                        Get.to(() => RouteScreen(
                              places: routeInfo[0],
                              polyLinePoints: routeInfo[1],
                            ));
                      },
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Text(stopBy[index].address,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 5,
                                                style: roundFont(
                                                    17,
                                                    darkHeading,
                                                    FontWeight.normal))),
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
                    );
                  },
                ),
                const HeightSpacer(size: 10),
                const Divider(thickness: 1, color: Colors.black38),

                const HeightSpacer(size: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeightSpacer(size: 10),
                    widget.rideDetail.passangersId.isNotEmpty
                        ? ReuseableText(
                            text: "Passengers",
                            style: roundFont(22, darkHeading, FontWeight.bold))
                        : Text(
                            "No passengers for this ride",
                            style:
                                roundFont(17, darkHeading, FontWeight.normal),
                          ),
                    const HeightSpacer(size: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.rideDetail.passangersId.length,
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
                                    text: widget.rideDetail.passangersId[index]
                                        .firstName,
                                    style: roundFont(
                                        17, darkHeading, FontWeight.normal),
                                  ),
                                  const Expanded(
                                      child: SizedBox(
                                    width: 1,
                                  )),
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundColor: Colors.white,
                                    backgroundImage: widget
                                            .rideDetail
                                            .passangersId[index]
                                            .profile
                                            .isNotEmpty
                                        ? NetworkImage(widget.rideDetail
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
                            index < widget.rideDetail.passangersId.length - 1
                                ? const Divider()
                                : const SizedBox.shrink(),
                          ],
                        );
                      },
                    )
                  ],
                ),
                const HeightSpacer(size: 10),
                const Divider(thickness: 1, color: Colors.black38),
                const HeightSpacer(size: 30),

                EditRideTile(title: "See your publication online", onTap: () {
                Get.to(
                () => RideDetailsPage(
                rideDetail: widget.rideDetail,
                routeInfo: routeInfo),
                transition: Transition.rightToLeft,
                arguments: 'CreateRide');
                }),
                EditRideTile(title: "Edit your publication", onTap: (){
                  Get.to(()=>const EditPublication(), transition: Transition.rightToLeft);
                })
              ],
            );
          }
        },
      ),
    );
  }
}
