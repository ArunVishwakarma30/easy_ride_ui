import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/common/text_with_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YourRidesContainer extends StatelessWidget {
  const YourRidesContainer(
      {Key? key,
      required this.dateString,
      required this.timeString,
      required this.departureAddress,
      required this.destinationAddress,
      required this.status,
      required this.statusColor,
      required this.onTap,
      required this.requests})
      : super(key: key);
  final String dateString;
  final String timeString;
  final String departureAddress;
  final String destinationAddress;
  final String status;
  final Color statusColor;
  final VoidCallback onTap;
  final List<dynamic> requests;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 13, right: 13, top: 15),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              requests.isNotEmpty
                  ? TextWithIcons(
                      preFixIcon: Icons.notification_add_outlined,
                      iconColor: Colors.redAccent,
                      text: "${requests.length} new request",
                      textStyle:
                          roundFont(18, Colors.redAccent, FontWeight.bold),
                      containerWidth: 100)
                  : const SizedBox.shrink(),
              requests.isNotEmpty
                  ? const HeightSpacer(size: 10)
                  : const SizedBox.shrink(),
              ReuseableText(
                  text: dateString,
                  style: roundFont(18, Colors.black45, FontWeight.bold)),
              const HeightSpacer(size: 7),
              ReuseableText(
                  text: timeString,
                  style: roundFont(18, Colors.black, FontWeight.bold)),
              const HeightSpacer(size: 7),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    'assets/icons/arrow_down.png',
                    height: 50,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(departureAddress,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style:
                                roundFont(19, darkHeading, FontWeight.normal)),
                        const HeightSpacer(size: 10),
                        Text(destinationAddress,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style:
                                roundFont(19, darkHeading, FontWeight.normal)),
                      ],
                    ),
                  ),
                ],
              ),
              const HeightSpacer(size: 10),
              status.isEmpty
                  ? const SizedBox.shrink()
                  : Text(status.toUpperCase(),
                      style: roundFont(16, statusColor, FontWeight.normal)
                          .copyWith()),
            ],
          ),
        ),
      ),
    );
  }
}
