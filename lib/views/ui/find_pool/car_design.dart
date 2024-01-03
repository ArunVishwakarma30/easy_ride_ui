import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/driver_verification/add_vehicle/custom_radio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/add_vehicle_provider.dart';

class CarDesign extends StatelessWidget {
  const CarDesign({super.key});

  @override
  Widget build(BuildContext context) {
    final addVehicleProvider = Provider.of<AddVehicle>(context);
    int numOfSeatsSelected = addVehicleProvider.numOfSeatSelected;
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
          width: width * 0.8,
          height: 470,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              const HeightSpacer(size: 20),
              Stack(
                children: [
                  Image.asset(
                    "assets/images/car_seats.jpeg",
                    height: 250,
                  ),
                  Positioned(
                      left: 40,
                      top: 40,
                      child: Container(
                        padding: const EdgeInsets.only(top: 7),
                        width: 70,
                        height: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.check_box_rounded,
                                  color: numOfSeatsSelected >= 4
                                      ? Color(seatColor.value)
                                      : Color(transparent.value),
                                ),
                                Icon(
                                  Icons.check_box_rounded,
                                  color: numOfSeatsSelected >= 5
                                      ? Color(seatColor.value)
                                      : Color(transparent.value),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.check_box_rounded,
                                    color: numOfSeatsSelected >= 2
                                        ? Color(seatColor.value)
                                        : Color(transparent.value),
                                  ),
                                  Icon(
                                    Icons.check_box_rounded,
                                    color: numOfSeatsSelected >= 3
                                        ? Color(seatColor.value)
                                        : Color(transparent.value),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.check_box_rounded,
                              color: numOfSeatsSelected >= 1
                                  ? Color(seatColor.value)
                                  : Color(transparent.value),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
              const HeightSpacer(size: 10),
              ReuseableText(
                  text: "Number of Seats",
                  style: roundFont(20, Colors.grey, FontWeight.bold)),
              const HeightSpacer(size: 15),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    CustomRadio(index: 1, selectedSeat: numOfSeatsSelected),
                    CustomRadio(index: 2, selectedSeat: numOfSeatsSelected),
                    CustomRadio(index: 3, selectedSeat: numOfSeatsSelected),
                    CustomRadio(index: 4, selectedSeat: numOfSeatsSelected),
                    CustomRadio(index: 5, selectedSeat: numOfSeatsSelected),
                  ],
                ),
              ),
              const HeightSpacer(size: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(width * 0.4, 50)),
                  backgroundColor:
                      MaterialStateProperty.all(Color(loginPageColor.value)),
                  // Set the button's background color to blue

                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                child: ReuseableText(
                  text: "Confirm",
                  style: roundFont(20, Colors.white, FontWeight.w500),
                ),
              ),
              const HeightSpacer(size: 10),
              ReuseableText(
                  text: "* Selection is not for seat position",
                  style: roundFont(16, Colors.black, FontWeight.normal))
            ],
          )),
    );
  }
}
