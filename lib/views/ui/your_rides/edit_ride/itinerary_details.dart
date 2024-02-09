import 'package:easy_ride/controllers/map_provider.dart';
import 'package:easy_ride/controllers/your_rides_provider.dart';
import 'package:easy_ride/models/map/direction_model.dart';
import 'package:easy_ride/models/response/your_rides_res_model.dart';
import 'package:easy_ride/views/ui/find_pool/find_location_page.dart';
import 'package:easy_ride/views/ui/your_rides/edit_ride/edit_ride_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../../../constants/app_constants.dart';
import '../../../../controllers/find_pool_provider.dart';
import '../../../common/app_style.dart';
import '../../../common/height_spacer.dart';
import '../../../common/reuseable_text_widget.dart';

class ItineraryDetails extends StatefulWidget {
  const ItineraryDetails({Key? key}) : super(key: key);

  @override
  State<ItineraryDetails> createState() => _ItineraryDetailsState();
}

class _ItineraryDetailsState extends State<ItineraryDetails> {
  late YourCreatedRidesResModel model;

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM y, HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final findPoolProvider = Provider.of<FindPoolProvider>(context);
    final yourRidesProvider = Provider.of<YourRidesProvider>(context);

    return Consumer<MapProvider>(builder: (context, mapProvider, child) {
      print("object2");
      model = yourRidesProvider.createdRide;
      if (model.stopBy.length > 2) {
        mapProvider.stopOver.clear();
        for (int i = 1; i < model.stopBy.length - 1; i++) {
          StopBy stop = model.stopBy[i];

          Directions direction = Directions(
            locationDescription: stop.address,
            locationId: stop.gMapAddressId,
          );

          // Add the Directions object to the list
          mapProvider.stopOver.add(direction);
        }
      }
      return PopScope(
        onPopInvoked: (value) {
          mapProvider.stopOver.clear();
        },
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              scrolledUnderElevation: 0.0,
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: loginPageColor),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReuseableText(
                          text: "Edit your publication",
                          style: roundFont(22, darkHeading, FontWeight.bold)),
                      const HeightSpacer(size: 30),
                      EditRideTile(
                          title: "DateTime",
                          subTitle: formatDateTime(model.schedule),
                          onTap: () {
                            print(model.schedule);
                          }),
                      Row(
                        children: [
                          Image.asset(
                            'assets/icons/arrow_down.png',
                            height: 70,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                EditRideTile(
                                    title: findPoolProvider
                                        .extractAddressPart(model.departure),
                                    subTitle: model.departure,
                                    subTitleSize: 14,
                                    onTap: () {}),
                                EditRideTile(
                                    title: findPoolProvider
                                        .extractAddressPart(model.destination),
                                    subTitle: model.destination,
                                    subTitleSize: 14,
                                    onTap: () {}),
                              ],
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.black38,
                      ),
                      const HeightSpacer(size: 10),
                      ReuseableText(
                          text: "Manage Stopovers",
                          style:
                              roundFont(16, loginPageColor, FontWeight.bold)),
                    ],
                  ),
                  mapProvider.stopOver.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: mapProvider.stopOver.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                    contentPadding:
                                        const EdgeInsets.only(right: 10),
                                    title: Text(
                                      mapProvider
                                          .stopOver[index].locationDescription!,
                                      style: roundFont(
                                          18, darkHeading, FontWeight.normal),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        mapProvider.removeStopOver(index);
                                        model.stopBy.removeAt(index + 1);
                                        print(model.stopBy[0].address);
                                        print(model
                                            .stopBy[model.stopBy.length - 1]
                                            .address);
                                      },
                                      icon: const Icon(Icons.delete),
                                    )),
                                const Divider()
                              ],
                            );
                          },
                        )
                      : SizedBox.shrink(),
                  GestureDetector(
                    onTap: (){
                      Get.to(()=>const FindLocationPage(), arguments: "stopOverEdit");
                    },
                      child: ReuseableText(
                          text: "Add City",
                          style:
                              roundFont(20, loginPageColor, FontWeight.bold)))
                ],
              ),
            )),
      );
    });
  }
}
