import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/controllers/add_vehicle_provider.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomRadio extends StatelessWidget {
  const CustomRadio({Key? key, required this.index, required this.selectedSeat})
      : super(key: key);
  final int index;
  final int selectedSeat;

  @override
  Widget build(BuildContext context) {
    final addVehicleProvider = Provider.of<AddVehicle>(context);
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        child: OutlinedButton(
          onPressed: () {
            addVehicleProvider.updateSelectedSeats(index);
          },
          style: OutlinedButton.styleFrom(
              backgroundColor: addVehicleProvider.numOfSeatSelected == index
                  ? Colors.black45
                  : Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0))),
          child: Center(
              child: ReuseableText(
            text: index.toString(),
            style: roundFont(
                20,
                addVehicleProvider.numOfSeatSelected == index
                    ? Colors.white
                    : Color(loginPageColor.value),
                FontWeight.normal),
          )),
        ),
      ),
    );
  }
}
