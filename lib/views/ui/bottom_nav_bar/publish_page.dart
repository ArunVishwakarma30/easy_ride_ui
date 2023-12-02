import 'package:easy_ride/views/ui/driver_verification/driver_verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublishPage extends StatefulWidget {
  const PublishPage({super.key});

  @override
  State<PublishPage> createState() => _PublishPageState();
}

class _PublishPageState extends State<PublishPage> {

  void getPrefValue() async {
    var prefs = await SharedPreferences.getInstance();
    bool isTrue = prefs.getBool("isDriverVerified") ?? false;
    if(!isTrue){
      Get.to(DriverVerification());
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefValue();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("PublishPage")),
    );
  }
}
