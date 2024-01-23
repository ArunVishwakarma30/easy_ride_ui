import 'package:easy_ride/models/map/direction_model.dart';
import 'package:easy_ride/models/request/create_ride_req_model.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/add_vehicle_provider.dart';
import '../../../controllers/find_pool_provider.dart';
import '../../../controllers/map_provider.dart';
import '../../common/height_spacer.dart';

class AddAboutYourRide extends StatefulWidget {
  const AddAboutYourRide({Key? key}) : super(key: key);

  @override
  State<AddAboutYourRide> createState() => _AddAboutYourRideState();
}

class _AddAboutYourRideState extends State<AddAboutYourRide> {
  late TextEditingController _aboutRideController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _aboutRideController = TextEditingController();
  }

  DateTime convertToCustomFormat(String inputDateTimeString) {
    // Parse the input date-time string
    DateTime inputDateTime = DateTime.parse(inputDateTimeString);

    // Create a new DateTime object with the desired format
    DateTime formattedDateTime = DateTime.utc(
      inputDateTime.year,
      inputDateTime.month,
      inputDateTime.day,
      inputDateTime.hour,
      0,
      // Set the minute to 0
      0,
      // Set the second to 0
      0, // Set the millisecond to 0
    );

    return formattedDateTime;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _aboutRideController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mapProvider = Provider.of<MapProvider>(context);
    var findPoolProvider = Provider.of<FindPoolProvider>(context);
    var addVehicleProvider = Provider.of<AddVehicle>(context);
    mapProvider.getPrefs();
    print(" driver id : ${mapProvider.driverId}");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: loginPageColor, size: 25),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Anything to add about your ride?",
                style: roundFont(25, darkHeading, FontWeight.bold)),
            const HeightSpacer(size: 20),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(backgroundGrey.value)),
              child: TextFormField(
                cursorColor: Color(loginPageColor.value),
                style: roundFont(17, Color(darkHeading.value), FontWeight.bold),
                maxLines: 13,
                minLines: 5,
                keyboardType: TextInputType.multiline,
                controller: _aboutRideController,
                decoration: InputDecoration(
                  hintStyle: roundFont(16, Colors.black45, FontWeight.bold),
                  hintText:
                      'Flexible about where and when to meet? Not taking the motorway? Got limited space in your boot? Keep passengers in the loop.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                        color: Color(backgroundGrey.value),
                        width: 1,
                        style: BorderStyle.solid),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),

                    borderSide: BorderSide(
                        width: 1, color: Color(backgroundGrey.value)), //
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),

                    borderSide: BorderSide(
                        width: 1,
                        color:
                            Color(backgroundGrey.value)), // Custom border color
                  ),
                ),
              ),
            ),
            const Expanded(child: HeightSpacer(size: 1)),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  onPressed: () {
                    mapProvider.setWaiting(true);
                    mapProvider.insertLocationAndDestinationToStopOver();
                    if (_aboutRideController.text.trim().isNotEmpty) {
                      mapProvider.aboutRide = _aboutRideController.text;
                    }
                    List<StopBy> stopBy = [];
                    for (Directions direction in mapProvider.stopOver) {
                      StopBy stopByInstance = StopBy(
                        gMapAddressId: direction.locationId ?? "",
                        address: direction.locationDescription ?? "",
                      );

                      // Add the created StopBy instance to the stopBy list
                      stopBy.add(stopByInstance);
                    }

                    CreateRideReqModel model = CreateRideReqModel(
                        departure: mapProvider
                            .myLocationDirection!.locationDescription!,
                        destination: mapProvider
                            .destinationDirection!.locationDescription!,
                        schedule: convertToCustomFormat(
                            findPoolProvider.travelDateTime.toString()),
                        aboutRide: mapProvider.aboutRide,
                        directBooking: mapProvider.instantBooking,
                        stopBy: stopBy,
                        seatsOffering: addVehicleProvider.numOfSeatSelected,
                        seatsAvailable: addVehicleProvider.numOfSeatSelected,
                        driverId: mapProvider.driverId!,
                        vehicleId: mapProvider.vehicleId!,
                        pricePerPass: mapProvider.pricePerSeat);

                    mapProvider.publishRide(model);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: loginPageColor),
                  child: mapProvider.waiting ? const CircularProgressIndicator(color: Colors.white,) : ReuseableText(
                    text: "Publish",
                    style: roundFont(18, Colors.white, FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
