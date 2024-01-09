import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyVehiclesListTile extends StatelessWidget {
  const MyVehiclesListTile(
      {Key? key,
      required this.modelName,
      required this.registrationNumber,
      this.makeAndCategory,
      this.exception,
      required this.isDefault,
      this.numberOfSeats,
      required this.popupMenuButton,
      required this.vehicleImage,
      required this.onTap,
      required this.isImageEmpty})
      : super(key: key);
  final String modelName;
  final String registrationNumber;
  final String? makeAndCategory;
  final String? exception;
  final bool isDefault;
  final int? numberOfSeats;
  final Widget popupMenuButton;
  final String vehicleImage;
  final bool isImageEmpty;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: isImageEmpty
                  ? AssetImage(vehicleImage)
                  : NetworkImage(vehicleImage) as ImageProvider,
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ReuseableText(
                    text: modelName,
                    style: roundFont(21, darkHeading, FontWeight.bold)),
                ReuseableText(
                  text: registrationNumber,
                  style: roundFont(16, Colors.black45, FontWeight.normal),
                ),
                makeAndCategory != null
                    ? Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: ReuseableText(
                          text: makeAndCategory!,
                          style:
                              roundFont(16, Colors.black45, FontWeight.normal),
                        ),
                      )
                    : const SizedBox.shrink(),
                isDefault
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.orange),
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.orange),
                        child: ReuseableText(
                          text: "  Default  ",
                          style: roundFont(13, Colors.white, FontWeight.normal),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const Expanded(child: SizedBox()),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                popupMenuButton,
                (modelName == 'Bike') || modelName == ('Scooter')
                    ? const SizedBox.shrink()
                    : ReuseableText(
                        text: "$numberOfSeats Seats",
                        style: roundFont(13, darkHeading, FontWeight.normal),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
