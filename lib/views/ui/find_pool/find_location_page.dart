import 'package:easy_ride/controllers/map_provider.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/common/toast_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../models/map/direction_model.dart';
import '../../common/app_style.dart';

class FindLocationPage extends StatefulWidget {
  const FindLocationPage({Key? key}) : super(key: key);

  @override
  State<FindLocationPage> createState() => _FindLocationPageState();
}

class _FindLocationPageState extends State<FindLocationPage> {
  late TextEditingController _searchLocationController;
  String dataFromPrevPage = Get.arguments;

  @override
  void initState() {
    // TODO: write a code to, for allow user permission (already written in map_screen)
    super.initState();
    _searchLocationController = TextEditingController();

    // Using Future.delayed to wait for the build process to complete
    Future.delayed(Duration.zero, () {
      if (context.read<MapProvider>().myLocationDirection != null &&
          Get.arguments == "myLocation") {
        _searchLocationController.text = context
                .read<MapProvider>()
                .myLocationDirection!
                .locationDescription ??
            '';
      } else if (context.read<MapProvider>().destinationDirection != null &&
          Get.arguments == "destination") {
        _searchLocationController.text = context
                .read<MapProvider>()
                .destinationDirection!
                .locationDescription ??
            '';
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchLocationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<MapProvider>(
      builder: (context, mapProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: Center(
              child: Container(
                width: width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(backgroundGrey.value)),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.arrow_back_ios, size: 20)),
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          mapProvider.findPlaceAutoCompleteSearch(value);
                          if (_searchLocationController.text.isEmpty) {
                            mapProvider.setPredictListToEmpty();
                          }
                        },
                        cursorColor: Color(loginPageColor.value),
                        style: roundFont(
                            16, Color(darkHeading.value), FontWeight.bold),
                        maxLines: 1,
                        keyboardType: TextInputType.multiline,
                        controller: _searchLocationController,
                        decoration: InputDecoration(
                          hintStyle:
                              roundFont(15, Colors.black45, FontWeight.bold),
                          hintText: 'Station, Road or The Bridge Cafe ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                color: Color(backgroundGrey.value),
                                width: 1,
                                style: BorderStyle.solid),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),

                            borderSide: BorderSide(
                                width: 1,
                                color: Color(backgroundGrey.value)), //
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),

                            borderSide: BorderSide(
                                width: 1,
                                color: Color(backgroundGrey
                                    .value)), // Custom border color
                          ),
                        ),
                      ),
                    ),
                    _searchLocationController.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              _searchLocationController.text = "";
                              mapProvider.setPredictListToEmpty();
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.close,
                                size: 20,
                              ),
                            ),
                          )
                        : const SizedBox.shrink()
                  ],
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 8.0, right: 8.0),
              child: Column(children: [
                Get.arguments == "stopOver"
                    ? const SizedBox.shrink()
                    : ListTile(
                        onTap: () async {
                          mapProvider.setWaiting(true);
                          mapProvider
                              .searchAddressForGeoGraphicCoOrdination()
                              .then((value) async {
                            if (value != null) {
                              if (Get.arguments == "myLocation") {
                                mapProvider.myLocationDirection =
                                    await mapProvider
                                        .getPlaceDirectionDetails(value);
                                mapProvider.setWaiting(false);

                                Get.back(
                                    result: mapProvider.myLocationDirection);
                              } else if (Get.arguments == "destination") {
                                mapProvider.destinationDirection =
                                    await mapProvider
                                        .getPlaceDirectionDetails(value);
                                mapProvider.setWaiting(false);
                                Get.back(
                                    result: mapProvider.destinationDirection);
                              }
                              // Get.back(result: mapProvider.myLocationDirection);
                            } else {
                              ShowSnackbar(
                                  title: "Something went wrong!",
                                  message: "Please type location in field!",
                                  icon: Icons.error_outline_outlined);
                            }
                          });
                        },
                        leading: const Icon(
                          Icons.my_location,
                          color: Colors.grey,
                        ),
                        title: ReuseableText(
                          text: "Use current location",
                          style: roundFont(18, darkHeading, FontWeight.normal),
                        ),
                        trailing: mapProvider.waiting
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.grey,
                                ))
                            : const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              ),
                      ),
                mapProvider.predictPlacesList.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: mapProvider.predictPlacesList.length,
                          itemBuilder: (context, index) {
                            var locationAtCurrentIndex =
                                mapProvider.predictPlacesList[index];
                            return ListTile(
                                onTap: () async {
                                  if (Get.arguments == "myLocation") {
                                    mapProvider.myLocationDirection =
                                        await mapProvider
                                            .getPlaceDirectionDetails(
                                                locationAtCurrentIndex
                                                    .place_id);

                                    Get.back(
                                        result:
                                            mapProvider.myLocationDirection);
                                  } else if (Get.arguments == "destination") {
                                    mapProvider.destinationDirection =
                                        await mapProvider
                                            .getPlaceDirectionDetails(
                                                locationAtCurrentIndex
                                                    .place_id);

                                    Get.back(
                                        result:
                                            mapProvider.destinationDirection);
                                  } else if (Get.arguments == "stopOver") {
                                    Directions? stopOver = await mapProvider
                                        .getPlaceDirectionDetails(
                                            locationAtCurrentIndex.place_id);
                                    mapProvider.stopOver.add(stopOver!);
                                    Get.back();
                                  }
                                  mapProvider.setPredictListToEmpty();
                                },
                                leading: const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.grey,
                                ),
                                title: Text(
                                  locationAtCurrentIndex.description!,
                                  style: roundFont(
                                      18, darkHeading, FontWeight.normal),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                ));
                          },
                        ),
                      )
                    : const SizedBox.shrink()
              ]),
            ),
          ),
        );
      },
    );
  }
}
