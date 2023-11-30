import 'dart:io';

import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/controllers/add_vehicle_provider.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/driver_verification/add_vehicle/custom_radio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'capture_img_dialog.dart';

class AddCar extends StatefulWidget {
  const AddCar(
      {Key? key,
      required this.vehicleRegistrationNumber,
      required this.exception,
      required this.makeCategory,
      required this.features,
      required this.onCarSelected,
      required this.onImageUploaded})
      : super(key: key);
  final TextEditingController vehicleRegistrationNumber;
  final TextEditingController exception;
  final TextEditingController makeCategory;
  final TextEditingController features;
  final Function(Map<String, String>) onCarSelected;
  final Function(File?) onImageUploaded;

  @override
  State<AddCar> createState() => _AddCarState();
}

class _AddCarState extends State<AddCar> {
  // getting the details of car(Car type and image path) from constant file
  Map<String, String> selectedCar = carTypeAndImg[0];
  File? capturedImage = File('');

// get the data from the capturedImage
  void getCapturedImage(File? value) {
    capturedImage = value;
    print("printing captured image value :::: $capturedImage");
    widget.onImageUploaded(capturedImage);
    setState(() {});
  }

  // List of DropdownMenuItem widgets for the DropdownButton
  List<DropdownMenuItem<String>> dropdownItems = carTypeAndImg
      .map((car) => DropdownMenuItem<String>(
            value: car['Name'],
            child: Text(car['Name'] ?? ''),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final addVehicleProvider = Provider.of<AddVehicle>(context);
    int numOfSeatsSelected = addVehicleProvider.numOfSeatSelected;
    bool defaultVehicle = addVehicleProvider.isDefaultVehicle;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              // Todo : Write a code to get the vehicle picture from gallery OR from camera
              showDialog(
                context: context,
                builder: (context) {
                  return CaptureImageAlertDialog(
                    capturedImage: getCapturedImage,
                  );
                },
              );
            },
            child: Column(
              children: [
                SizedBox(
                  height: width * 0.5,
                  child: capturedImage?.path == '' || capturedImage == null
                      ? Image.asset(selectedCar["Img"] ?? '')
                      : ClipOval(child: Image.file(capturedImage!)),
                ),
                Center(
                  child: ReuseableText(
                      text: "Update Picture",
                      style: roundFont(
                          16, Color(loginPageColor.value), FontWeight.bold)),
                )
              ],
            ),
          ),
          const HeightSpacer(size: 6),
          DropdownButton(
              style: roundFont(19, Colors.black, FontWeight.normal),
              isExpanded: true,
              items: dropdownItems,
              value: selectedCar['Name'],
              onChanged: (String? value) {
                setState(() {
                  // Update the selectedCar when an item is selected
                  selectedCar = carTypeAndImg.firstWhere(
                    (car) => car['Name'] == value,
                    orElse: () => carTypeAndImg[
                        0], // Default to the first car if not found
                  );
                  widget.onCarSelected(selectedCar);
                });
              }),
          TextField(
            controller: widget.vehicleRegistrationNumber,
            maxLines: 1,
            enableSuggestions: false,
            keyboardType: TextInputType.text,
            style: roundFont(19, Colors.black, FontWeight.normal),
            decoration: const InputDecoration(
                hintText: "Registration No. (DL 9C AB 6297)",
                hintStyle: TextStyle(fontSize: 16)),
          ),
          const HeightSpacer(size: 10),
          ReuseableText(
              text: "Offering Seats",
              style: roundFont(15, Colors.black45, FontWeight.w500)),
          const HeightSpacer(size: 5),
          Row(
            children: [
              CustomRadio(index: 1, selectedSeat: numOfSeatsSelected),
              CustomRadio(index: 2, selectedSeat: numOfSeatsSelected),
              CustomRadio(index: 3, selectedSeat: numOfSeatsSelected),
              CustomRadio(index: 4, selectedSeat: numOfSeatsSelected),
              CustomRadio(index: 5, selectedSeat: numOfSeatsSelected),
              CustomRadio(index: 6, selectedSeat: numOfSeatsSelected),
              CustomRadio(index: 7, selectedSeat: numOfSeatsSelected),
            ],
          ),
          const HeightSpacer(size: 8),
          TextField(
            controller: widget.makeCategory,
            maxLines: 1,
            enableSuggestions: false,
            keyboardType: TextInputType.text,
            style: roundFont(19, Colors.black, FontWeight.normal),
            decoration: const InputDecoration(
                hintText: "Make & Category (Ex. Red Swift)",
                hintStyle: TextStyle(fontSize: 16)),
          ),
          const HeightSpacer(size: 8),
          TextField(
            controller: widget.features,
            maxLines: 1,
            enableSuggestions: false,
            keyboardType: TextInputType.text,
            style: roundFont(19, Colors.black, FontWeight.normal),
            decoration: const InputDecoration(
                hintText: "Features (Ex. AC, Music, Wifi)",
                hintStyle: TextStyle(fontSize: 16)),
          ),
          const HeightSpacer(size: 8),
          TextField(
            controller: widget.exception,
            maxLines: 1,
            enableSuggestions: false,
            keyboardType: TextInputType.text,
            style: roundFont(19, Colors.black, FontWeight.normal),
            decoration: const InputDecoration(
                hintText: "Exception (Ex. No Smoking, No Pet)",
                hintStyle: TextStyle(fontSize: 16)),
          ),
          const HeightSpacer(size: 8),
          CheckboxListTile(
            value: defaultVehicle,
            onChanged: (value) {
              addVehicleProvider.makeVehicleDefault(value!);
            },
            title: const Text(
              "Mark as default vehicle",
            ),
            controlAffinity: ListTileControlAffinity.leading,
          )
        ],
      ),
    );
  }
}
