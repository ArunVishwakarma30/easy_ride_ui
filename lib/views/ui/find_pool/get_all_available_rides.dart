import 'package:easy_ride/controllers/map_provider.dart';
import 'package:easy_ride/models/request/search_rides_req_model.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/ui/find_pool/get_all_rides_container.dart';
import 'package:easy_ride/views/ui/find_pool/get_ride_detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constants/app_constants.dart';
import '../../../controllers/add_vehicle_provider.dart';
import '../../../controllers/find_pool_provider.dart';
import '../../../models/map/direction_model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

import '../../../models/response/search_ride_res_model.dart';

class GetAllAvailableRides extends StatefulWidget {
  const GetAllAvailableRides({Key? key}) : super(key: key);

  @override
  State<GetAllAvailableRides> createState() => _GetAllAvailableRidesState();
}

class _GetAllAvailableRidesState extends State<GetAllAvailableRides> {
  late Directions? myLocation;
  late Directions? destination;

// Function to convert IST to UTC
  tz.TZDateTime convertISTtoUTC(DateTime istDateTime) {
    tz.TZDateTime utcDateTime = tz.TZDateTime.from(istDateTime, tz.UTC);
    return utcDateTime;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tzdata.initializeTimeZones();
  }

  Future<List<dynamic>> getRouteDetails(
      SearchRidesResModel searchResult) async {
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
    double height = MediaQuery.of(context).size.height;

    final findPoolProvider = Provider.of<FindPoolProvider>(context);
    final addVehicleProvider = Provider.of<AddVehicle>(context);
    DateTime? dateTime = findPoolProvider.travelDateTime!;

    int? seatsSelected = addVehicleProvider.numOfSeatSelected;
    return Consumer<MapProvider>(
      builder: (context, mapProvider, child) {
        myLocation = mapProvider.myLocationDirection;
        destination = mapProvider.destinationDirection;
        String destinationDescription =
            destination!.locationDescription!.substring(0, 20);
        String? myState = findPoolProvider
            .getStateFromAddress(myLocation!.locationDescription!);
        String? desState = findPoolProvider
            .getStateFromAddress(destination!.locationDescription!);
        SearchRidesReqModel model = SearchRidesReqModel(
            departure: myState,
            destination: desState,
            seatsRequired: seatsSelected!,
            schedule: dateTime!);

        findPoolProvider.getSearchResult(model);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Center(
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: AppBar().preferredSize.width,
                  height: AppBar().preferredSize.height,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: lightHeading),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Icon(Icons.arrow_back_ios, size: 20),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${myLocation!.locationDescription!.substring(0, 20)} ... ",
                                style:
                                    roundFont(14, darkHeading, FontWeight.bold),
                              ),
                              const Icon(
                                Icons.arrow_forward_outlined,
                                size: 18,
                              ),
                              Text(
                                "$destinationDescription... ",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style:
                                    roundFont(14, darkHeading, FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${dateTime.day}/${dateTime.month}/${dateTime.year}, ${dateTime.hour}:${dateTime.minute},   ",
                                style: roundFont(
                                    14, darkHeading, FontWeight.normal),
                              ),
                              Text(
                                "$seatsSelected ${seatsSelected > 1 ? "Passengers" : "Passenger"}",
                                style: roundFont(
                                    14, darkHeading, FontWeight.normal),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: FutureBuilder(
            future: findPoolProvider.searchResult,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                    style: roundFont(16, darkHeading, FontWeight.bold),
                  ),
                );
              } else if (snapshot.data!.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HeightSpacer(
                      size: height * 0.18,
                    ),
                    Image.asset(
                      'assets/images/no_rides_found.png',
                      width: 150,
                    ),
                    const HeightSpacer(
                      size: 30,
                    ),
                    Center(
                      child: Text(
                        "Not rides yet. Drivers usually \npublish their ride 2-3 days \nbefore departure.",
                        textAlign: TextAlign.center,
                        style: roundFont(25, darkHeading, FontWeight.bold),
                      ),
                    ),
                  ],
                );
              } else {
                var availableRide = snapshot.data;
                return ListView.builder(
                  itemCount: availableRide!.length,
                  itemBuilder: (context, index) {
                    var rideAtCurrentIndex = availableRide[index];
                    return FutureBuilder(
                      // Execute getRouteDetails for each item in the list
                      future: getRouteDetails(
                          rideAtCurrentIndex),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Display CircularProgressIndicator while waiting
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SizedBox(
                              width: 200.0,
                              height: 200.0,
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.25),
                                highlightColor: Colors.white.withOpacity(0.6),
                                child: Container(
                                  width: MediaQuery.of(context).size.width - 40,
                                  height: 400,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.grey.withOpacity(0.9),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          // Handle error
                          return Text(snapshot.error.toString());
                        }
                        else {
                          var routeInfo = snapshot.data;
                          // NOTE : route info contain this elements
                          // index[0] ==> list of Lat Long
                          // index[1] ==> PolyLineDetails to show the route inside map
                          // index[2] ==> List of int which is for hrs
                          // index[3] ==> List of int which is for min
                          // List<LatLng> directions = routeInfo![0];
                          // String polyLineString = routeInfo[1];
                          List<int> hrs = routeInfo![2];
                          print(hrs);
                          List<int> mins = routeInfo[3];
                          print(mins);

                          String? departVal =
                              findPoolProvider.extractAddressPart(
                                  rideAtCurrentIndex.stopBy[0].address);
                          String? destVal = findPoolProvider.extractAddressPart(
                              rideAtCurrentIndex
                                  .stopBy[rideAtCurrentIndex.stopBy.length - 1]
                                  .address);
                          return GetAllRidesContainer(
                            onCardTap: () {
                              Get.to(
                                  () => RideDetailsPage(
                                      rideDetail: rideAtCurrentIndex,
                                      routeInfo: routeInfo),
                                  transition: Transition.rightToLeft,
                                  arguments: 'SearchRide');
                            },
                            startTime: rideAtCurrentIndex.schedule,
                            travelingHrs: hrs[hrs.length - 1],
                            // todo : calculate traveling hrs and minutes
                            travelingMin: mins[mins.length - 1],
                            departureName: departVal,
                            departDisFromPassLoc: 0,
                            // todo : set this value dynamically after calculating km dis between user entered and available rides
                            destDisFromPassLoc: 2,
                            destinationName: destVal,
                            driverName: rideAtCurrentIndex.driverId.firstName,
                            pricePerSeat: rideAtCurrentIndex.pricePerPass,
                            driverRating: null,
                            urgentBooking: rideAtCurrentIndex.directBooking,
                            profileImage: rideAtCurrentIndex.driverId.profile,
                          );
                        }
                      },
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
