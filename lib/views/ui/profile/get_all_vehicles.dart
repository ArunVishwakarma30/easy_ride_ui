import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/my_vehicle_list.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ReuseableText(
          text: "My Vehicles",
          style: roundFont(20, darkHeading, FontWeight.bold),
        ),
      ),
      body: MyVehicleList(userId: userId),
    );
  }
}
