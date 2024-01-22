import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/controllers/map_provider.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/offer_pool/set_price_per_seat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class InstantBooking extends StatelessWidget {
  const InstantBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mapProvider = Provider.of<MapProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: loginPageColor, size: 25),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SvgPicture.string(instantBookingSvg),
            Text(
              "Enable Instant Booking for your passengers",
              style: roundFont(25, darkHeading, FontWeight.bold),
            ),
            const HeightSpacer(size: 15),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.add_alert_outlined),
              title: ReuseableText(
                  text: "More convenience",
                  style: roundFont(17, darkHeading, FontWeight.bold)),
              subtitle: Text(
                "No need to review every passenger’s request before it expires",
                style: roundFont(17, darkHeading, FontWeight.normal),
              ),
            ),
            const HeightSpacer(size: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.electric_bolt),
              title: ReuseableText(
                  text: "Get more passengers",
                  style: roundFont(17, darkHeading, FontWeight.bold)),
              subtitle: Text(
                "They prefer to get an instant answer",
                style: roundFont(17, darkHeading, FontWeight.normal),
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                mapProvider.instantBooking = true;
                Get.to(() => const SetPricePerSeatPage(),
                    transition: Transition.rightToLeft);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReuseableText(
                        text: "Enable Instant Booking",
                        style: roundFont(20, loginPageColor, FontWeight.bold)),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.black45,
                    )
                  ],
                ),
              ),
            ),
            const Divider(),
            InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                mapProvider.instantBooking = false;
                Get.to(() => const SetPricePerSeatPage(),
                    transition: Transition.rightToLeft);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ReuseableText(
                        text: "Review every request before it expires",
                        style: roundFont(17, Colors.black45, FontWeight.bold)),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: Colors.black45,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
