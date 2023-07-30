import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_constants.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: width,
          height: height * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const HeightSpacer(size: 12.0),
              Image.asset("assets/images/car_1.jpg"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ReuseableText(
                        text: "Welcome to Easy Ride",
                        style: appStyle(30, Color(textColor.value), FontWeight.bold)),

                    const HeightSpacer(size: 30.0),
                    Text(
                      "Say goodbye to long waits and expensive fares. Welcome to the future of transportation.Discover a seamless and convenient way to travel, right at your fingertips",
                      style: GoogleFonts.roboto(
                          fontSize: 19,
                          color: const Color.fromARGB(255, 127, 117, 117),
                          fontWeight: FontWeight.normal,
                          height: 1.5

                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}