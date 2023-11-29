import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/app_constants.dart';
import '../../../../controllers/add_vehicle_provider.dart';
import '../../../common/app_style.dart';
import '../../../common/height_spacer.dart';
import '../../../common/reuseable_text_widget.dart';

class AddBike extends StatefulWidget {
  const AddBike(
      {Key? key,
      required this.vehicleRegistrationNumber,
      required this.makeCategory,
      required this.features})
      : super(key: key);
  final TextEditingController vehicleRegistrationNumber;
  final TextEditingController makeCategory;
  final TextEditingController features;

  @override
  State<AddBike> createState() => _AddBikeState();
}

class _AddBikeState extends State<AddBike> {
  // getting the details of bike(bike type and image path) from constant file
  Map<String, String> selectedBike = bikeTypeAndImg[0];

  // List of DropdownMenuItem widgets for the DropdownButton
  List<DropdownMenuItem<String>> dropdownItems = bikeTypeAndImg
      .map((bike) => DropdownMenuItem<String>(
            value: bike['Name'],
            child: Text(bike['Name'] ?? ''),
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    final addVehicleProvider = Provider.of<AddVehicle>(context);
    bool defaultVehicle = addVehicleProvider.isDefaultVehicle;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              // Todo : Write a code to get the vehicle picture from gallery OR from camera
              print("Add Code to get the image from gallery or camera");
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: width * 0.5,
                  child: Image.asset(selectedBike["Img"] ?? ''),
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
          const HeightSpacer(size: 8),
          DropdownButton(
              style: roundFont(19, Colors.black, FontWeight.normal),
              isExpanded: true,
              items: dropdownItems,
              value: selectedBike['Name'],
              onChanged: (String? value) {
                setState(() {
                  // Update the selected Bike when an item is selected
                  selectedBike = bikeTypeAndImg.firstWhere(
                    (bike) => bike['Name'] == value,
                    orElse: () => bikeTypeAndImg[
                        0], // Default to the first bike if not found
                  );
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
          const HeightSpacer(size: 20),
          ReuseableText(
              text: "Extra Helmet for Pillion Rider",
              style: roundFont(15, Colors.black45, FontWeight.w500)),
          Row(
            children: [
              Radio(
                value: 1,
                groupValue: addVehicleProvider.carryHelmet,
                onChanged: (value) {
                  addVehicleProvider.setCarryHelmet(1);
                },
              ),
              ReuseableText(
                  text: "Pillion rider required to carry helmet.",
                  style: roundFont(16, Colors.black, FontWeight.normal)),
            ],
          ),
          Row(
            children: [
              Radio(
                value: 2,
                groupValue: addVehicleProvider.carryHelmet,
                onChanged: (value) {
                  addVehicleProvider.setCarryHelmet(2);
                },
              ),
              ReuseableText(
                  text: "Pillion rider carrying helmet optional.",
                  style: roundFont(16, Colors.black, FontWeight.normal)),
            ],
          ),
          TextField(
            controller: widget.makeCategory,
            maxLines: 1,
            enableSuggestions: false,
            keyboardType: TextInputType.text,
            style: roundFont(19, Colors.black, FontWeight.normal),
            decoration: const InputDecoration(
                hintText: "Make & Category (Ex. Black CBR)",
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
                hintText: "Features (Ex. Helmet)",
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
          ),
        ],
      ),
    );
  }
}
