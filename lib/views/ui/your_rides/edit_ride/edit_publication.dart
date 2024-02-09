import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/ui/your_rides/edit_ride/edit_ride_tile.dart';
import 'package:easy_ride/views/ui/your_rides/edit_ride/itinerary_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_constants.dart';
import '../../../common/app_style.dart';
import '../../../common/reuseable_text_widget.dart';

class EditPublication extends StatelessWidget {
  const EditPublication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: loginPageColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ReuseableText(
                text: "Edit your publication",
                style: roundFont(22, darkHeading, FontWeight.bold)),
            const HeightSpacer(size: 20),
            EditRideTile(
                title: "Itinerary detail",
                onTap: () {
                  Get.to(() => const ItineraryDetails(),
                      transition: Transition.rightToLeft);
                }),
            EditRideTile(
                title: "Price",
                subTitle: "Passengers will pay in cash",
                onTap: () {}),
            EditRideTile(title: "Seats and options", onTap: () {}),
            const Divider(
              thickness: 1,
              color: Colors.black38,
            ),
            const HeightSpacer(size: 20),
            GestureDetector(
                onTap: () {
                  // TODO : write code to cancel the ride
                },
                child: ReuseableText(
                    text: "Cancel your ride",
                    style: roundFont(18, loginPageColor, FontWeight.bold)))
          ],
        ),
      ),
    );
  }
}
