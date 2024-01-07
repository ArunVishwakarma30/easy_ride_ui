import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/controllers/add_vehicle_provider.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/profile/popup_menu_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'my_vehicles_list_tile.dart';

class MyAllVehicles extends StatefulWidget {
  const MyAllVehicles({Key? key}) : super(key: key);

  @override
  State<MyAllVehicles> createState() => _MyAllVehiclesState();
}

class _MyAllVehiclesState extends State<MyAllVehicles> {
  // on popup menu item selected
  void handleMenuItemSelected(String value) {
    // todo : -->
    if (value == "set default") {
      print("Here set the vehicle to default");
    } else {
      print("Remove vehicle from the database");
      // and refresh the page using set state or changeNotifier(provider)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ReuseableText(
          text: "My Vehicles",
          style: roundFont(20, darkHeading, FontWeight.bold),
        ),
      ),
      body: Consumer<AddVehicle>(
        builder: (context, vehicleProvider, child) {
          vehicleProvider.getAllVehicles();
          return FutureBuilder(
            future: vehicleProvider.allVehicles,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error : ${snapshot.error}",
                    style: roundFont(14, darkHeading, FontWeight.normal),
                  ),
                );
              } else if (snapshot.data!.isEmpty) {
                return const SizedBox.shrink();
              } else {
                var vehicleData = snapshot.data;
                return ListView.builder(
                  padding: EdgeInsets.all(15),
                  itemCount: vehicleData!.length,
                  itemBuilder: (context, index) {
                    var vehicleAtCurrentIndex = vehicleData[index];
                    return MyVehiclesListTile(
                        modelName: vehicleAtCurrentIndex.model,
                        registrationNumber:
                            vehicleAtCurrentIndex.registrationNumber,
                        isDefault: vehicleAtCurrentIndex.isDefault,
                        popupMenuButton: CustomPopupMenuButton(
                            onMenuItemSelected: handleMenuItemSelected),
                        vehicleImage: vehicleAtCurrentIndex.image,
                        exception: vehicleAtCurrentIndex.exception,
                        makeAndCategory: vehicleAtCurrentIndex.makeAndCategory,
                        numberOfSeats: vehicleAtCurrentIndex.offeringSeat,
                        onTap: () {
                          print("Go to vehicle update page");
                        });
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
