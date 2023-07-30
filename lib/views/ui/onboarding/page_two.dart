import 'package:easy_ride/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/app_style.dart';
import '../../common/height_spacer.dart';
import '../../common/reuseable_text_widget.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

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
              const HeightSpacer(size: 15.0),

              Image.asset("assets/images/car_2.png"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ReuseableText(
                        text: "Reliable and Secure Rides",
                        style: appStyle(
                            30, Color(textColor.value), FontWeight.bold)),
                    const HeightSpacer(size: 30.0),
                    Text(
                      "Track your ride in real-time and share your trip details with loved ones for added security.Your safety and comfort are our top priorities, every step of the way",
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
