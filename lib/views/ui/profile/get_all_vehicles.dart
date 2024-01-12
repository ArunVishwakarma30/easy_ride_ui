import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/controllers/add_vehicle_provider.dart';
import 'package:easy_ride/models/request/update_is_default_req_model.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/profile/popup_menu_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'my_vehicles_list_tile.dart';

class MyAllVehicles extends StatefulWidget {
  const MyAllVehicles({Key? key}) : super(key: key);

  @override
  State<MyAllVehicles> createState() => _MyAllVehiclesState();
}

class _MyAllVehiclesState extends State<MyAllVehicles> {
  String? userId = "";

  void getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
  }

  @override
  Widget build(BuildContext context) {
    getPrefs();
    var vehicleProvider = Provider.of<AddVehicle>(context);

    // on popup menu item selected
    void handleMenuItemSelected(
        String value, String vehicleId, UpdateIsDefaultReq model) {
      // todo : -->
      if (value == "set default") {
        vehicleProvider.updateIsDefault(model, vehicleId);
      } else {
        print(vehicleId);
        vehicleProvider.deleteVehicle(vehicleId);
      }
    }

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
                  padding: const EdgeInsets.all(15),
                  itemCount: vehicleData!.length,
                  itemBuilder: (context, index) {
                    var vehicleAtCurrentIndex = vehicleData[index];
                    String? vehicleImage = "";
                    bool isImageEmpty = false;
                    if (vehicleAtCurrentIndex.image.isEmpty) {
                      isImageEmpty = true;
                      if (vehicleAtCurrentIndex.type == 'Auto Rickshaw' ||
                          vehicleAtCurrentIndex.type == 'Car') {
                        Map<String, String>? selectedCarImg =
                            carTypeAndImg.firstWhere((car) =>
                                car['Name'] == vehicleAtCurrentIndex.model);

                        vehicleImage = selectedCarImg['Img'].toString();
                      } else {
                        Map<String, String>? selectedBikeImg =
                            bikeTypeAndImg.firstWhere((car) =>
                                car['Name'] == vehicleAtCurrentIndex.model);

                        vehicleImage = selectedBikeImg['Img'].toString();
                      }
                    }

                    UpdateIsDefaultReq model =
                        UpdateIsDefaultReq(userId: userId!, isDefault: true);
                    return MyVehiclesListTile(
                      modelName: vehicleAtCurrentIndex.model,
                      registrationNumber:
                          vehicleAtCurrentIndex.registrationNumber,
                      isDefault: vehicleAtCurrentIndex.isDefault,
                      popupMenuButton: CustomPopupMenuButton(
                        isDefault: vehicleAtCurrentIndex.isDefault,
                        onMenuItemSelected: handleMenuItemSelected,
                        vehicleId: vehicleAtCurrentIndex.id,
                        updateIsDefaultModel: model,
                      ),
                      vehicleImage: isImageEmpty
                          ? vehicleImage
                          : vehicleAtCurrentIndex.image,
                      exception: vehicleAtCurrentIndex.exception,
                      makeAndCategory: vehicleAtCurrentIndex.makeAndCategory,
                      numberOfSeats: vehicleAtCurrentIndex.offeringSeat,
                      onTap: () {
                        print("Go to vehicle update page");
                      },
                      isImageEmpty: isImageEmpty,
                    );
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
