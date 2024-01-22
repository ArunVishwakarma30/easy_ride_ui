import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/offer_pool/add_about_ride.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/map_provider.dart';

class SetPricePerSeatPage extends StatefulWidget {
  const SetPricePerSeatPage({Key? key}) : super(key: key);

  @override
  State<SetPricePerSeatPage> createState() => _SetPricePerSeatPageState();
}

class _SetPricePerSeatPageState extends State<SetPricePerSeatPage> {
  int value = 20;

  @override
  Widget build(BuildContext context) {
    var mapProvider = Provider.of<MapProvider>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: loginPageColor, size: 25),
        ),
        body: Consumer<MapProvider>(
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReuseableText(
                      text: "Set your price per seat",
                      style: roundFont(25, darkHeading, FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: mapProvider.pricePerSeat > 10 ? () {
                            mapProvider.decrement(10);
                          } : null,
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            size: 50,
                          )),
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 8.0, left: 20),
                            child: ReuseableText(
                                text: "\u20B9",
                                style:
                                    appStyle(50, darkHeading, FontWeight.bold)),
                          ),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: TextFormField(
                              controller: TextEditingController(
                                  text: mapProvider.pricePerSeat.toString()),
                              maxLength: 4,
                              cursorHeight: 0,
                              style: appStyle(50, darkHeading, FontWeight.bold),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                String modifiedString =
                                    value.replaceAll(RegExp(r'[^0-9]'), '');

                                if (value.trim().isNotEmpty) {
                                  mapProvider.setPriceOnChange(
                                      int.parse(modifiedString));
                                }
                              },
                              decoration: const InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        disabledColor: Colors.black12,
                          padding: EdgeInsets.zero,
                          onPressed: mapProvider.pricePerSeat < 9990 ? () {
                            mapProvider.increment(10);
                          } : null,
                          icon:const Icon(
                            Icons.add_circle_outline_outlined,
                            size: 50,
                          )),
                    ],
                  ),
                  Text(
                      "Set perfect price for this ride and You'll get passengers in no time!",
                      style: roundFont(18, darkHeading, FontWeight.normal)),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const AddAboutYourRide(),
                transition: Transition.rightToLeft);
          },
          backgroundColor: loginPageColor,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.arrow_forward_outlined,
            size: 30,
            color: Colors.white,
          ),
        ));
  }
}
