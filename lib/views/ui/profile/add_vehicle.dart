import 'dart:io';

import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/models/request/add_vehicle_req_model.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/driver_verification/step_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/add_vehicle_provider.dart';
import '../../../controllers/image_uploader.dart';
import '../../common/toast_msg.dart';

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
  String? userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }

  void getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
  }

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
    final addVehicleProvider = Provider.of<AddVehicle>(context);
    final imageProvider = Provider.of<ImageUploader>(context);

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
                onPressed: () async {
                  String vehicleRegistrationNumber =
                      _vehicleRegistrationNumber.text.toString();
                  print(_isBikeTabSelected == 0
                      ? "Car Details Uploading..."
                      : "Bike Details Uploading...");
                  if (_isBikeTabSelected == 0) {
                    if ((selectedCar['Name'] == null) ||
                        (selectedCar['Name'] == 'Select Type') ||
                        vehicleRegistrationNumber.isEmpty) {
                      ShowSnackbar(
                          title: "Failed",
                          message: "Please enter all fields!",
                          icon: Icons.error_outline_outlined);
                    } else {
                      addVehicleProvider.setWaiting(true);

                      print(
                          "Name : ${selectedCar['Name']} /n Image Path : ${selectedCar['Img']}");
                      print(selectedCar['Name'] == null
                          ? carTypeAndImg[0]
                          : selectedCar);
                      print(selectedCar['Name'] == "Passenger Auto Rickshaw"
                          ? "Auto"
                          : "Car");

                      String? imageUrl = "";
                      if (uploadedCarImage != null) {
                        // Now you can safely access properties and methods of uploadedCarImage
                        imageUrl =
                            await imageProvider.imageUpload(uploadedCarImage!);
                      } // heck if it is null or not , before uploading

                      AddVehicleReqModel model = AddVehicleReqModel(
                          userId: userId!,
                          type: selectedCar['Name'] == "Passenger Auto Rickshaw"
                              ? "Auto Rickshaw"
                              : "Car",
                          image: imageUrl!,
                          model: selectedCar['Name']!,
                          registrationNumber: vehicleRegistrationNumber,
                          offeringSeat: addVehicleProvider.numOfSeatSelected,
                          makeAndCategory: _makeCategory.text,
                          features: _features.text,
                          exception: _exception.text,
                          isDefault: addVehicleProvider.isDefaultVehicle,
                          requiredHelmet: false);

                      addVehicleProvider.addVehicle(model);
                    }
                  } else {
                    if ((selectedBike['Name'] == null) ||
                        (selectedBike['Name'] == 'Select Type') ||
                        (vehicleRegistrationNumber.isEmpty) ||
                        (addVehicleProvider.carryHelmet == 0)) {
                      ShowSnackbar(
                          title: "Failed",
                          message: "Please enter all fields!",
                          icon: Icons.error_outline_outlined);
                    } else {
                      addVehicleProvider.setWaiting(true);
                      print(
                          "Helmet Required (1 : Required, 2:Optional ) : ${addVehicleProvider.carryHelmet}");
                      print(
                          "Name : ${selectedBike['Name']} /n Image Path : ${selectedBike['Img']}");
                      String? imageUrl = "";
                      if (uploadedBikeImage != null) {
                        imageUrl =
                            await imageProvider.imageUpload(uploadedBikeImage!);
                      }
                      AddVehicleReqModel model = AddVehicleReqModel(
                          userId: userId!,
                          type: selectedBike['Name'] == "Bike"
                              ? "Bike"
                              : "Scooter",
                          image: imageUrl!,
                          model: selectedBike['Name']!,
                          registrationNumber: vehicleRegistrationNumber,
                          offeringSeat: 0,
                          makeAndCategory: _makeCategory.text,
                          features: _features.text,
                          exception: "",
                          isDefault: addVehicleProvider.isDefaultVehicle,
                          requiredHelmet: addVehicleProvider.carryHelmet == 1
                              ? true
                              : false);

                      addVehicleProvider.addVehicle(model);
                    }
                  }
                },
                child: addVehicleProvider.waiting
                    ? const CircularProgressIndicator(color: Colors.white,)
                    : Text(
                        "Add",
                        style: roundFont(
                            width * 0.06, Colors.white, FontWeight.bold),
                      )),
          ],
        ),
      ),
    );
  }
}
