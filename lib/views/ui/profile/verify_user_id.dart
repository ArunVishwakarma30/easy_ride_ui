import 'dart:io';

import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_constants.dart';
import '../driver_verification/step_two_widget.dart';

class VerifyUserId extends StatefulWidget {
  const VerifyUserId({Key? key}) : super(key: key);

  @override
  State<VerifyUserId> createState() => _VerifyUserIdState();
}

class _VerifyUserIdState extends State<VerifyUserId> {
  String selectedDocument = '';
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  var selectedImage = File('');

  //Callback function to handle the selected image of users Identity proof
  void handleImageSelected(File img) {
    selectedImage = img;
  }

  //Callback function to handle the selected document
  void handleDocumentSelected(String value) {
    selectedDocument = value;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: ReuseableText(
          text: "Verify Identity",
          style: roundFont(18, Colors.black, FontWeight.bold),
        ),
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          children: [
            Step2(
              onImageSelected: handleImageSelected,
              onDocumentSelected: handleDocumentSelected,
              firstNameController: _firstNameController,
              lastNameController: _lastNameController,
            ),
            const HeightSpacer(size: 12),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(loginPageColor.value),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  minimumSize: Size(width, 55),
                ),
                onPressed: () {},
                child: Text(
                  "Continue",
                  style: roundFont(width * 0.06, Colors.white, FontWeight.bold),
                )),
          ]),
    );
  }
}
