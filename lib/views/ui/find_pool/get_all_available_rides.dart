import 'package:easy_ride/controllers/map_provider.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/get_all_rides_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/add_vehicle_provider.dart';
import '../../../controllers/find_pool_provider.dart';
import '../../../models/map/direction_model.dart';

class GetAllAvailableRides extends StatefulWidget {
  const GetAllAvailableRides({Key? key}) : super(key: key);

  @override
  State<GetAllAvailableRides> createState() => _GetAllAvailableRidesState();
}

class _GetAllAvailableRidesState extends State<GetAllAvailableRides> {
  late Directions? myLocation;
  late Directions? destination;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final findPoolProvider = Provider.of<FindPoolProvider>(context);
    final addVehicleProvider = Provider.of<AddVehicle>(context);
    DateTime? dateTime = findPoolProvider.travelDateTime!;
    int? seatsSelected = addVehicleProvider.numOfSeatSelected;
    return Consumer<MapProvider>(
      builder: (context, mapProvider, child) {
        myLocation = mapProvider.myLocationDirection;
        destination = mapProvider.destinationDirection;
        String destinationDescription = destination!.locationDescription!.substring(0, 20);

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
                                "${dateTime!.day}/${dateTime.month}/${dateTime.year}, ${dateTime.hour}:${dateTime.minute},   ",
                                style: roundFont(
                                    14, darkHeading, FontWeight.normal),
                              ),
                              Text(
                                "$seatsSelected ${seatsSelected! > 1 ? "Passengers" : "Passenger"}",
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
          body: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return GetAllRidesContainer();
            },
          ),
        );
      },
    );
  }
}
