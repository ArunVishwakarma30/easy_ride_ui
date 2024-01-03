import 'dart:io';

import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/driver_verification/step_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({Key? key}) : super(key: key);

  @override
  State<AddVehiclePage> createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  // data from the step 3
  int _isBikeTabSelected = 0;
  final _vehicleRegistrationNumber =
      TextEditingController(); // common for car and bike
  final _makeCategory = TextEditingController(); //  common for car and bike
  final _features = TextEditingController(); //  common for car and bike
  final _exception = TextEditingController();
  Map<String, String> selectedCar = {};
  Map<String, String> selectedBike = {};
  File? uploadedCarImage;
  File? uploadedBikeImage;

  // Callback function to set the selected vehicle value from the drop down
  void onCarSelected(Map<String, String> car) {
    selectedCar = car;
  }

  // Callback function to set the selectedBike value from the drop down
  void onBikeSelected(Map<String, String> bike) {
    selectedBike = bike;
  }

  //Callback function to get the tab index value of, after the tab index changed
  void onTabIndexChanged(int value) {
    _isBikeTabSelected = value;
  }

  // callback function to get the image of the car after its uploaded
  void onCarImageUploaded(File? value) {
    uploadedCarImage = value;
    print("uploadedImage :::::: $uploadedCarImage");
  }

  // callback function to get the image of the bike after its uploaded
  void onBikeImageUploaded(File? value) {
    uploadedBikeImage = value;
    print("uploadedImage :::::: $uploadedBikeImage");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.white, // Background color for the status bar
      statusBarIconBrightness:
          Brightness.dark, // Dark icons for better visibility
    ));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        title: ReuseableText(
            text: "Add Vehicle",
            style: roundFont(18, Colors.black, FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Step3(
                  vehicleRegistrationNumber: _vehicleRegistrationNumber,
                  exceptionController: _exception,
                  featuresController: _features,
                  makeCategoryController: _makeCategory,
                  onTabIndexChanged: onTabIndexChanged,
                  onCarSelected: onCarSelected,
                  onBikeSelected: onBikeSelected,
                  onCarImageUploaded: onCarImageUploaded,
                  onBikeImageUploaded: onBikeImageUploaded),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(loginPageColor.value),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  minimumSize: Size(width, 55),
                ),
                onPressed: () {},
                child: Text(
                  "Continue",
                  style: roundFont(width * 0.06, Colors.white, FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
