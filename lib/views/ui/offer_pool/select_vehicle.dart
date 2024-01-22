import 'package:easy_ride/controllers/map_provider.dart';
import 'package:easy_ride/views/common/my_vehicle_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/app_constants.dart';
import '../../common/app_style.dart';

class SelectVehicle extends StatelessWidget {
  SelectVehicle({Key? key}) : super(key: key);
  String? userId = "";

  Future<String> getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    print("UserID : $userId");
    return userId!;
  }

  @override
  Widget build(BuildContext context) {
    getPrefs();
    var mapProvider = Provider.of<MapProvider>(context);
    mapProvider.driverId = userId;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: loginPageColor),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Which vehicle are you driving?",
                style: roundFont(28, darkHeading, FontWeight.bold),
              ),
            ),
            Expanded(
                child: MyVehicleList(
              userId: userId,
              selectingVehicle: true,
            ))
          ],
        ),
      ),
    );
  }
}
