import 'dart:io';

import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/auth_provider.dart';
import '../../../controllers/image_uploader.dart';
import '../../../models/request/update_identity_req_model.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();

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
    final imageProvider = Provider.of<ImageUploader>(context);
    final authProvider = Provider.of<AuthProvider>(context);

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
                onPressed: () async {
                  authProvider.setWaiting(true);
                  String? documentImage =
                      await imageProvider.imageUpload(selectedImage);
                  UploadIdentityModel identityModel = UploadIdentityModel(firstName: _firstNameController.text.toString(), lastName: _lastNameController.text.toString(), identityDocument: IdentityDocument(documentType: selectedDocument.toString(), documentImg: documentImage!));
                  authProvider.uploadIdentity(identityModel);
                  Get.to(()=>const MainPage());
                },
                child: authProvider.waiting ? const CircularProgressIndicator() : Text(
                   "Upload",
                  style: roundFont(width * 0.06, Colors.white, FontWeight.bold),
                )),
          ]),
    );
  }
}
