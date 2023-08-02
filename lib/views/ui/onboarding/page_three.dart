import 'package:easy_ride/views/common/shadow_btn.dart';
import 'package:easy_ride/views/ui/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_constants.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: width,
        height: height * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HeightSpacer(size: 25.0),
            Image.asset("assets/images/car_3.jpeg"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ReuseableText(
                      text: "Personalized Travel Experience",
                      style: appStyle(
                          30, Color(textColor.value), FontWeight.bold)),
                  const HeightSpacer(size: 30.0),
                  Text(
                    "Choose from a range of vehicle options to suit your preferences and group size.Your comfort matters to us. Sit back, relax, and enjoy the ride",
                    style: GoogleFonts.roboto(
                        fontSize: 19,
                        color: const Color.fromARGB(255, 127, 117, 117),
                        fontWeight: FontWeight.normal,
                        height: 1.5),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
            HeightSpacer(size: height * 0.08),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ShadowBtn(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  gradientColor1: const Color.fromARGB(255, 123, 136, 170),
                  gradientColor2: Color(lightShade.value),
                  size: 18.0,
                  height: 55,
                  width: 135.0,
                  child: Text(
                    'Login',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                ShadowBtn(
                  size: 18.0,
                  height: 55,
                  width: 135.0,
                  child: Text(
                    'Register',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
