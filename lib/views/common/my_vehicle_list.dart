import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';
import '../../controllers/add_vehicle_provider.dart';
import '../../models/request/update_is_default_req_model.dart';
import '../ui/profile/my_vehicles_list_tile.dart';
import '../ui/profile/popup_menu_button.dart';
import 'app_style.dart';

class MyVehicleList extends StatefulWidget {
  const MyVehicleList({Key? key, this.userId, this.selectingVehicle = false})
      : super(key: key);
  final bool selectingVehicle;
  final String? userId;

  @override
  State<MyVehicleList> createState() => _MyVehicleListState();
}

class _MyVehicleListState extends State<MyVehicleList> {
  @override
  Widget build(BuildContext context) {
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

    return Consumer<AddVehicle>(

      builder: (context, vehicleProvider, child) {
        vehicleProvider.getAllVehicles();

        return FutureBuilder(
          future: vehicleProvider.allVehicles,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              print("Userid : :::::::::::::${widget.userId}");

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
              print("Userid : :::::::::::::${widget.userId}");

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
                  print("Userid : :::::::::::::${widget.userId}");

                  UpdateIsDefaultReq model = UpdateIsDefaultReq(
                      userId: widget.userId!, isDefault: true);
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
                    selectingVehicle: widget.selectingVehicle, vehicleId: vehicleAtCurrentIndex.id,
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
