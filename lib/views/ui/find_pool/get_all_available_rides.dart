import 'package:easy_ride/controllers/map_provider.dart';
import 'package:easy_ride/models/request/search_rides_req_model.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/ui/find_pool/get_all_rides_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/add_vehicle_provider.dart';
import '../../../controllers/find_pool_provider.dart';
import '../../../models/map/direction_model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzdata;

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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    final findPoolProvider = Provider.of<FindPoolProvider>(context);
    final addVehicleProvider = Provider.of<AddVehicle>(context);
    DateTime? dateTime = findPoolProvider.travelDateTime!;
    DateTime? istDateTime =
        DateTime(dateTime!.year, dateTime.month, dateTime.day, 0, 0);


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
            schedule: dateTime);

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
                   HeightSpacer(size: height*0.18,),
                    Image.asset('assets/images/no_rides_found.png', width: 150,),
                    const HeightSpacer(size: 30,),
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
                    String? departVal = findPoolProvider
                        .extractAddressPart(rideAtCurrentIndex.stopBy[0].address);
                    String? destVal = findPoolProvider.extractAddressPart(
                        rideAtCurrentIndex
                            .stopBy[rideAtCurrentIndex.stopBy.length - 1].address);
                    return GetAllRidesContainer(
                      onCardTap: () {
                        print("Working");
                      },
                      startTime: rideAtCurrentIndex.schedule,
                      travelingHrs: 2,
                      // todo : calculate traveling hrs and minutes
                      travelingMin: 40,
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
