import 'package:easy_ride/controllers/find_pool_provider.dart';
import 'package:easy_ride/controllers/your_rides_provider.dart';
import 'package:easy_ride/models/response/your_rides_res_model.dart';
import 'package:easy_ride/views/ui/your_rides/ride_plan.dart';
import 'package:easy_ride/views/ui/your_rides/your_rides_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class YourRidesListView extends StatefulWidget {
  const YourRidesListView({Key? key, required this.rideCreatedListView})
      : super(key: key);
  final bool rideCreatedListView;

  @override
  State<YourRidesListView> createState() => _YourRidesListViewState();
}

class _YourRidesListViewState extends State<YourRidesListView> {
  late ScrollController _scrollController;

  String formatDateString(DateTime dateTime) {
    // Parse the input string to a DateTime object
    // DateTime dateTime = DateTime.parse(dateTimeString);
    // Format the DateTime object to the desired format
    String formattedDate = DateFormat('EEE d MMMM').format(dateTime);
    return formattedDate;
  }

  String formatTime(DateTime dateTime) {
    // Format the time to "h:mm a" format (e.g., "5:00 PM")
    String formattedTime = DateFormat.jm().format(dateTime);
    return formattedTime;
  }

  List<dynamic>? checkStatus(
      bool isCanceled, bool isFinished, DateTime dateTime) {
    if (isFinished) {
      return ["Completed", Colors.green];
    } else if (isCanceled) {
      return ["Cancelled", Colors.red];
    } else if (dateTime.isAfter(DateTime.now())) {
      return ["Upcoming ride", Colors.orange];
    } else {
      return ["", Colors.green]; // Return "Start Ride" for current ride
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final findPoolProvider = Provider.of<FindPoolProvider>(context);

    return Consumer<YourRidesProvider>(
      builder: (context, yourRidesProvider, child) {
        yourRidesProvider.getAllCreatedRides();
        return FutureBuilder(
          future: yourRidesProvider.allCreatedRides,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No Rides Created yet"),
              );
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _scrollController.animateTo(
                  _scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
              var allCreatedRides = snapshot.data;
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var createdRideAtCurrentIndex = allCreatedRides![index];
                    String? date =
                        formatDateString(createdRideAtCurrentIndex.schedule);
                    String? time =
                        formatTime(createdRideAtCurrentIndex.schedule);

                    // in status list , first index will be the string status, and 2nd will be the color
                    List<dynamic>? status = checkStatus(
                        createdRideAtCurrentIndex.isCanceled,
                        createdRideAtCurrentIndex.isFinished,
                        createdRideAtCurrentIndex.schedule);

                    String departAddress = findPoolProvider.extractAddressPart(
                        createdRideAtCurrentIndex.departure);
                    String destinationAddress =
                        findPoolProvider.extractAddressPart(
                            createdRideAtCurrentIndex.destination);

                    return YourRidesContainer(
                      onTap: () {
                        yourRidesProvider.createdRide =
                            createdRideAtCurrentIndex;
                        Get.to(() => RidePlan(
                              rideDetail: createdRideAtCurrentIndex,
                            ));
                      },
                      dateString:
                          widget.rideCreatedListView ? date : "fasfadsf",
                      timeString: time,
                      departureAddress: departAddress,
                      destinationAddress: destinationAddress,
                      status: status![0],
                      statusColor: status[1],
                    );
                  },
                ),
              );
            }
          },
        );
      },
    );
  }
}
