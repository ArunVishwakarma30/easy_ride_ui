import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';

class RecentSearch extends StatelessWidget {
  const RecentSearch(
      {Key? key,
      required this.onTap,
      required this.date,
      required this.numOfPassengers,
      required this.pickUpLocation,
      required this.destinationLocation})
      : super(key: key);
  final VoidCallback onTap;
  final String pickUpLocation;
  final String destinationLocation;
  final String date;
  final String numOfPassengers;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.02),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.access_time,
                size: width * 0.06,
                color: Colors.black45,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        maxLines: 5,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(children: [
                          TextSpan(
                              text: pickUpLocation,
                              style: roundFont(
                                  15, Color(darkHeading.value), FontWeight.w500)),
                          WidgetSpan(
                            child: Icon(
                              Icons.arrow_forward,
                              size: width * 0.04,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                              text: destinationLocation,
                              style: roundFont(
                                  15, Color(darkHeading.value), FontWeight.w500)),
                        ]),
                      ),
                      ReuseableText(
                          text: "$date, $numOfPassengers",
                          style: roundFont(15, Colors.black45, FontWeight.w500))
                    ],
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: width * 0.06,
                color: Colors.black45,
              )
            ],
          ),
        ),
      ),
    );
  }
}
