import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';
import '../../common/app_style.dart';
import '../../common/height_spacer.dart';
import '../../common/reuseable_text_widget.dart';

class Step1 extends StatelessWidget {
  const Step1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.7,
      child: Column(
        children: [
          Image.asset(
            "assets/images/T&C.jpeg",
            width: 80,
            height: 80,
          ),
          HeightSpacer(size: height * 0.025),
          ReuseableText(
              text: "To Continue, we need to ",
              style: roundFont(
                  width * 0.07, Color(darkHeading.value), FontWeight.w500)),
          ReuseableText(
              text: "verify your identity ",
              style: roundFont(
                  width * 0.07, Color(darkHeading.value), FontWeight.bold)),
          HeightSpacer(size: height * 0.03),
          Row(
            children: [
              Icon(
                Icons.electric_bolt,
                color: Color(darkHeading.value),
                size: width * 0.05,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: ReuseableText(
                    text: "Secure and Fast",
                    style: roundFont(width * 0.05, Color(darkHeading.value),
                        FontWeight.bold)),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 30),
            child: Text(
                "Verification usually takes less than a day and is encrypted.",
                style: roundFont(
                    width * 0.05, Color(darkHeading.value), FontWeight.w500)),
          ),
          HeightSpacer(size: height * 0.03),
          Row(
            children: [
              Icon(
                Icons.lock,
                color: Color(darkHeading.value),
                size: width * 0.05,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: ReuseableText(
                    text: "How we verify you",
                    style: roundFont(width * 0.05, Color(darkHeading.value),
                        FontWeight.bold)),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 30),
            child: Text(
                "To learn how we uses data you provide and device data, see our Privacy Policy",
                style: roundFont(
                    width * 0.05, Color(darkHeading.value), FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
