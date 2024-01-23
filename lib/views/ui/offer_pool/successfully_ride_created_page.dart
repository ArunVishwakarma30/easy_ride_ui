import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RideCreated extends StatelessWidget {
  const RideCreated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // status bar color
    ));
    return PopScope(
      canPop: false,
      onPopInvoked: (value) {
        Get.offAll(() => const MainPage(), transition: Transition.leftToRight);
      },
      child: Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          backgroundColor: Colors.green,
          iconTheme: const IconThemeData(color: darkHeading),
          leading: IconButton(
              onPressed: () {
                Get.offAll(() => const MainPage());
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const HeightSpacer(size: 50),
              CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 85,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Image.asset("assets/icons/ride_created.png"),
                  )),
              const HeightSpacer(size: 20),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Your ride has been successfully created.",
                  style: roundFont(28, darkHeading, FontWeight.bold),
                ),
              ),
              const HeightSpacer(size: 50),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Sit back and relax while we search for the perfect ride to match your needs",
                  style: roundFont(20, darkHeading, FontWeight.bold),
                ),
              ),
              const Expanded(child: HeightSpacer(size: 1)),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(elevation: 6),
                  child: ReuseableText(
                      text: "See my ride offer",
                      style: roundFont(17, loginPageColor, FontWeight.bold)))
            ],
          ),
        ),
      ),
    );
  }
}
