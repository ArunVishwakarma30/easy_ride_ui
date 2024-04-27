import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/controllers/find_pool_provider.dart';
import 'package:easy_ride/models/request/chat/create_chat_req.dart';
import 'package:easy_ride/models/request/req_ride_model.dart';
import 'package:easy_ride/models/request/send_notification_req_model.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/common/text_with_icons.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controllers/add_vehicle_provider.dart';
import '../../../controllers/bottom_navigation_provider.dart';
import '../../../controllers/chat_provider.dart';
import '../profile/my_vehicles_list_tile.dart';
import 'map_locaiton_page.dart';

class RideDetailsPage extends StatefulWidget {
  RideDetailsPage({Key? key, required this.rideDetail, required this.routeInfo})
      : super(key: key);
  var rideDetail;
  final List<dynamic> routeInfo;

  @override
  State<RideDetailsPage> createState() => _RideDetailsPageState();
}

class _RideDetailsPageState extends State<RideDetailsPage> {
  String? userId;
  String? argument = "";
  var args = Get.arguments;

  getPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    print(userId);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }

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
    var findPoolProvider = Provider.of<FindPoolProvider>(context);
    List<LatLng> directions = widget.routeInfo[0];
    String polyLines = widget.routeInfo[1];
    List<int> hrs = widget.routeInfo[2];
    List<int> mins = widget.routeInfo[3];

    argument = args ?? "";
    String? schedule = formatDateTimeString(widget.rideDetail.schedule);
    var stopBy = widget.rideDetail.stopBy;

    String? vehicleImage = "";
    bool isImageEmpty = false;
    if (widget.rideDetail.vehicleId.image.isEmpty) {
      isImageEmpty = true;
      if (widget.rideDetail.vehicleId.type == 'Auto Rickshaw' ||
          widget.rideDetail.vehicleId.type == 'Car') {
        Map<String, String>? selectedCarImg = carTypeAndImg.firstWhere(
            (car) => car['Name'] == widget.rideDetail.vehicleId.model);

        vehicleImage = selectedCarImg['Img'].toString();
      } else {
        Map<String, String>? selectedBikeImg = bikeTypeAndImg.firstWhere(
            (car) => car['Name'] == widget.rideDetail.vehicleId.model);

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
                    // TODO(FIX logic) : something wrong in duration calculation.
                    DateTime travelTime = widget.rideDetail.schedule;
                    String travelTimeString =
                        "${travelTime.hour.toString()}:${travelTime.minute.toString()}${travelTime.minute.toString().length == 1 ? '0' : ""}";
                    if (index > 0 && index < widget.rideDetail.stopBy.length) {
                      DateTime newTravelTime = travelTime.add(Duration(
                          hours: hrs[index - 1], minutes: mins[index - 1]));
                      travelTimeString =
                          "${newTravelTime.hour.toString()}:${newTravelTime.minute.toString()}${newTravelTime.minute.toString().length == 1 ? "0" : ""}";
                    }
                    if (index < widget.rideDetail.stopBy.length - 1) {
                      travelDurationString = hrs[index] == 0
                          ? "${mins[index].toString()}${mins[index].toString().length == 1 ? "0" : ""}min"
                          : "${hrs[index].toString()}h${mins[index].toString()}${mins[index].toString().length == 1 ? "0" : ""}";
                    } else {
                      travelDurationString = "";
                    }

                    return GestureDetector(
                      onTap: () async {
                        Get.to(() => RouteScreen(
                              places: directions,
                              polyLinePoints: polyLines,
                          stopBy: stopBy,
                            ));
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
                          text: "\u20B9${widget.rideDetail.pricePerPass}.00",
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
                                text: widget.rideDetail.driverId.firstName,
                                style: roundFont(
                                    17, darkHeading, FontWeight.bold)),
                            const Expanded(
                                child: SizedBox(
                              width: 1,
                            )),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              backgroundImage: widget
                                      .rideDetail.driverId.profile.isNotEmpty
                                  ? NetworkImage(
                                      widget.rideDetail.driverId.profile)
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
                        widget.rideDetail.aboutRide,
                        style: roundFont(18, darkHeading, FontWeight.normal),
                      ),
                      const HeightSpacer(size: 20),
                      GestureDetector(
                          onTap: () {
                            var notifier = Provider.of<ChatNotifier>(context, listen: false);
                            var navNotifier = Provider.of<BottomNavNotifier>(context, listen: false);
                            CreateChat model = CreateChat(senderId: userId!, receiverId: widget.rideDetail.driverId.id);
                            navNotifier.setCurrentIndex(0);
                            notifier.createChat(model);

                            Get.offAll(()=>MainPage());
                          },
                          child: ReuseableText(
                              text:
                                  "Contact ${widget.rideDetail.driverId.firstName}",
                              style: roundFont(
                                  18, loginPageColor, FontWeight.bold))),
                      const HeightSpacer(size: 10),
                      const Divider(),
                      const HeightSpacer(size: 20),
                      TextWithIcons(
                        text: widget.rideDetail.directBooking
                            ? "Your booking will be confirmed instantly."
                            : "Your booking won't be confirmed until the driver approves your request",
                        maxLines: 3,
                        textStyle:
                            roundFont(18, darkHeading, FontWeight.normal),
                        containerWidth: MediaQuery.of(context).size.width - 100,
                        preFixIcon: widget.rideDetail.directBooking
                            ? Icons.electric_bolt_outlined
                            : Icons.time_to_leave_outlined,
                        iconColor: Colors.black45,
                      ),
                      const HeightSpacer(size: 20),
                      const Divider(),
                      const HeightSpacer(size: 10),
                      MyVehiclesListTile(
                        modelName: widget.rideDetail.vehicleId.model,
                        registrationNumber:
                            widget.rideDetail.vehicleId.registrationNumber,
                        isDefault: false,
                        viewVehicleDetails: true,
                        vehicleImage: isImageEmpty
                            ? vehicleImage
                            : widget.rideDetail.vehicleId.image,
                        exception: widget.rideDetail.vehicleId.exception,
                        makeAndCategory:
                            widget.rideDetail.vehicleId.makeAndCategory,
                        numberOfSeats: vehicleProvider.numOfSeatSelected,
                        onTap: () {},
                        isImageEmpty: widget.rideDetail.vehicleId.image.isEmpty,
                        selectingVehicle: true,
                        vehicleId: widget.rideDetail.vehicleId.id,
                      ),
                      const Divider(),
                      const HeightSpacer(size: 10),
                      widget.rideDetail.vehicleId.features.isNotEmpty
                          ? TextWithIcons(
                              text: widget.rideDetail.vehicleId.features,
                              maxLines: 3,
                              textStyle:
                                  roundFont(18, darkHeading, FontWeight.normal),
                              containerWidth:
                                  MediaQuery.of(context).size.width - 100,
                              iconColor: Colors.black45,
                              preFixIcon: Icons.star_border_purple500,
                            )
                          : const SizedBox.shrink(),
                      widget.rideDetail.vehicleId.features.isNotEmpty
                          ? const HeightSpacer(size: 15)
                          : const SizedBox.shrink(),
                      widget.rideDetail.vehicleId.exception.isNotEmpty
                          ? TextWithIcons(
                              text: widget.rideDetail.vehicleId.exception,
                              maxLines: 3,
                              textStyle:
                                  roundFont(18, darkHeading, FontWeight.normal),
                              containerWidth:
                                  MediaQuery.of(context).size.width - 100,
                              iconColor: Colors.black45,
                              preFixIcon: Icons.not_interested,
                            )
                          : const SizedBox.shrink(),
                      (widget.rideDetail.vehicleId.type == 'Bike' ||
                              widget.rideDetail.vehicleId.type == 'Scooter')
                          ? const HeightSpacer(size: 15)
                          : const SizedBox.shrink(),
                      (widget.rideDetail.vehicleId.type == 'Bike' ||
                              widget.rideDetail.vehicleId.type == 'Scooter')
                          ? TextWithIcons(
                              text: widget.rideDetail.vehicleId.requiredHelmet
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
                widget.rideDetail.passangersId.isNotEmpty
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
                      widget.rideDetail.passangersId.isNotEmpty
                          ? ReuseableText(
                              text: "Passengers",
                              style:
                                  roundFont(22, darkHeading, FontWeight.bold))
                          : const SizedBox.shrink(),
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
                                        text: widget.rideDetail
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
                  findPoolProvider.setWaiting(true);
                  print(widget.rideDetail.id);
                  print(widget.rideDetail.driverId.id);
                  print(vehicleProvider.numOfSeatSelected);
                  print(widget.rideDetail.directBooking);
                  SendNotificationReqModel notificationModel =
                      SendNotificationReqModel(devices: [
                    widget.rideDetail.driverId.oneSignalId
                  ], content: "New passenger booked your ride of date : $schedule");
                  RequestRideReqModel model;
                  print(
                      "Driver onesignal id : ${widget.rideDetail.driverId.oneSignalId}");
                  if (widget.rideDetail.directBooking) {
                    model = RequestRideReqModel(
                        rideId: widget.rideDetail.id,
                        userId: userId!,
                        seatsRequired: vehicleProvider.numOfSeatSelected,
                        isAccepted: true);
                  } else {
                    model = RequestRideReqModel(
                        rideId: widget.rideDetail.id,
                        userId: userId!,
                        seatsRequired: vehicleProvider.numOfSeatSelected);
                    print("Else part running : ${model.isAccepted}");
                  }
                  findPoolProvider.requestRide(model, notificationModel);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: loginPageColor,
                    minimumSize:
                        Size(MediaQuery.of(context).size.width - 40, 45)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.rideDetail.directBooking
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
                        text: widget.rideDetail.directBooking
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
