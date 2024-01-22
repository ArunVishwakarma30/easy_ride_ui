import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/controllers/map_provider.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/find_pool/find_location_page.dart';
import 'package:easy_ride/views/ui/offer_pool/select_vehicle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddStopOverPage extends StatelessWidget {
  const AddStopOverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MapProvider>(
      builder: (context, mapProvider, child) {
        mapProvider.getPrefs();
        print(" driver id : ${mapProvider.driverId}");
        return PopScope(
          onPopInvoked: (value) {
            mapProvider.stopOver = [];
          },
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: loginPageColor),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add stopovers to get more passengers",
                      style: roundFont(28, darkHeading, FontWeight.bold),
                    ),
                    mapProvider.stopOver.isNotEmpty
                        ? Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: mapProvider.stopOver.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                        contentPadding:
                                            const EdgeInsets.only(right: 10),
                                        title: Text(
                                          mapProvider.stopOver[index]
                                              .locationDescription!,
                                          style: roundFont(18, darkHeading,
                                              FontWeight.normal),
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {
                                            mapProvider.removeStopOver(index);
                                          },
                                          icon: const Icon(Icons.delete),
                                        )),
                                    const Divider()
                                  ],
                                );
                              },
                            ),
                          )
                        : SizedBox.shrink(),
                    const HeightSpacer(size: 10),
                    GestureDetector(
                      onTap: () {
                        print("Send to add city page");
                        Get.to(() => const FindLocationPage(),
                            arguments: "stopOver");
                      },
                      child: ReuseableText(
                          text: "Add City",
                          style:
                              roundFont(20, loginPageColor, FontWeight.normal)),
                    )
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Get.to(() => SelectVehicle(),
                      transition: Transition.rightToLeft);
                },
                backgroundColor: loginPageColor,
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.arrow_forward_outlined,
                  size: 30,
                  color: Colors.white,
                ),
              )),
        );
      },
    );
  }
}
