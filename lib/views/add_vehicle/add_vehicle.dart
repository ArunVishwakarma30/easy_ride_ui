import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddVehicle extends StatefulWidget {
  const AddVehicle({Key? key}) : super(key: key);

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  // getting the details of car(Car type and image path) from constant file
  Map<String, String> selectedCar = carTypeAndImg[0];

  // List of DropdownMenuItem widgets for the DropdownButton
  List<DropdownMenuItem<String>> dropdownItems = carTypeAndImg
      .map((car) => DropdownMenuItem<String>(
            value: car['Name'],
            child: Text(car['Name'] ?? ''),
          ))
      .toList();

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        GestureDetector(
          onTap: () {
            // Todo : Write a code to get the vehicle picture from gallery OR from camera
            print("Add Code to get the image from gallery or camera");
          },
          child: Column(
            children: [
              SizedBox(
                height: width * 0.5,
                child: Image.asset(selectedCar["Img"] ?? ''),
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
        DropdownButton(
            isExpanded: true,
            items: dropdownItems,
            value: selectedCar['Name'],
            onChanged: (String? value) {
              setState(() {
                // Update the selectedCar when an item is selected
                selectedCar = carTypeAndImg.firstWhere(
                  (car) => car['Name'] == value,
                  orElse: () =>
                      carTypeAndImg[0], // Default to the first car if not found
                );
              });
            })
      ],
    );
  }
}
