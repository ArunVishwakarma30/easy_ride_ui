import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GetAllRidesContainer extends StatelessWidget {
  const GetAllRidesContainer(
      {Key? key,
      required this.startTime,
      required this.travelingHrs,
      required this.travelingMin,
      required this.departureName,
      required this.departDisFromPassLoc,
      required this.destDisFromPassLoc,
      required this.destinationName,
      required this.driverName,
      this.profileImage,
      this.driverRating,
      this.urgentBooking,
      required this.pricePerSeat,
      required this.onCardTap})
      : super(key: key);

  final DateTime startTime;
  final int travelingHrs;
  final int travelingMin;
  final String departureName;
  final int
      departDisFromPassLoc; // 0 : near from passenger loc. , 1 : far from passenger loc. , 2 : too far from passenger loc.
  final int destDisFromPassLoc;
  final String destinationName;
  final String driverName;
  final String? profileImage;
  final double? driverRating;
  final bool? urgentBooking;
  final int pricePerSeat;
  final VoidCallback onCardTap;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // Add hours and minutes to the end time
    DateTime endTime =
        startTime.add(Duration(hours: travelingHrs, minutes: travelingMin));

    return Padding(
      padding: const EdgeInsets.only(top: 10.0, right: 15, left: 15),
      child: Card(
        surfaceTintColor: Colors.transparent,
        color: Colors.white,
        elevation: 4,
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: onCardTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                                "${startTime.hour.toString()}:${startTime.minute.toString()}",
                            style: roundFont(17, darkHeading, FontWeight.bold)),
                        ReuseableText(
                            text: travelingHrs == 0
                                ? "${travelingMin}min"
                                : "${travelingHrs}h$travelingMin",
                            style:
                                roundFont(17, darkHeading, FontWeight.normal)),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: width * 0.65,
                      height: 45,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(departureName,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: roundFont(
                                          18, darkHeading, FontWeight.bold))),
                              ReuseableText(
                                  text: "\u20B9 $pricePerSeat",
                                  style: roundFont(
                                      19, darkHeading, FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(left: 70, bottom: 10),
                  child: Image.asset(
                    "assets/icons/route.png",
                    width: 40,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ReuseableText(
                            text:
                                "${endTime.hour.toString()}:${endTime.minute.toString()}",
                            style: roundFont(17, darkHeading, FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: width * 0.6,
                      height: 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Text(destinationName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: roundFont(
                                      18, darkHeading, FontWeight.bold))),

                        ],
                      ),
                    ),
                  ],
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundImage: profileImage != null
                        ? NetworkImage(profileImage!)
                        : const AssetImage('assets/icons/person.png')
                            as ImageProvider,
                    backgroundColor: Colors.white,
                  ),
                  title: ReuseableText(
                    text: driverName,
                    style: roundFont(17, darkHeading, FontWeight.bold),
                  ),
                  subtitle: driverRating != null
                      ? Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 20,
                            ),
                            ReuseableText(
                              text: " $driverRating",
                              style:
                                  roundFont(17, darkHeading, FontWeight.bold),
                            ),
                          ],
                        )
                      : null,
                  trailing: urgentBooking == true
                      ? const Padding(
                          padding: EdgeInsets.only(top: 23),
                          child: Icon(
                            Icons.electric_bolt,
                            size: 20,
                          ))
                      : null,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
