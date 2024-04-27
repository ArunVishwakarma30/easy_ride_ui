import 'dart:io';

import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/controllers/auth_provider.dart';
import 'package:easy_ride/controllers/driver_verification_provider.dart';
import 'package:easy_ride/models/request/update_identity_req_model.dart';
import 'package:easy_ride/services/helper/auth_helper.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/common/toast_msg.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/main_page.dart';
import 'package:easy_ride/views/ui/driver_verification/step_one_widget.dart';
import 'package:easy_ride/views/ui/driver_verification/step_three.dart';
import 'package:easy_ride/views/ui/driver_verification/step_two_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/add_vehicle_provider.dart';
import '../../../controllers/image_uploader.dart';
import '../../../models/request/add_vehicle_req_model.dart';

class DriverVerification extends StatefulWidget {
  const DriverVerification({Key? key}) : super(key: key);

  @override
  State<DriverVerification> createState() => _DriverVerificationState();
}

class _DriverVerificationState extends State<DriverVerification> {
  // data from the step 2
  String selectedDocument = '';
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  var selectedImage = File('');

  // data from the step 3
  int _isBikeTabSelected = 0;
  final _vehicleRegistrationNumber =
      TextEditingController(); // common for car and bike
  final _makeCategory = TextEditingController(); //  common for car and bike
  final _features = TextEditingController(); //  common for car and bike
  final _exception = TextEditingController();
  Map<String, String> selectedCar = {};
  Map<String, String> selectedBike = {};
  File? uploadedCarImage;
  File? uploadedBikeImage;
  String? userId;


  // Callback function to set the selected vehicle value from the drop down
  void onCarSelected(Map<String, String> car) {
    selectedCar = car;
  }

  // Callback function to set the selectedBike value from the drop down
  void onBikeSelected(Map<String, String> bike) {
    selectedBike = bike;
  }

  //Callback function to handle the selected image of users Identity proof
  void handleImageSelected(File img) {
    selectedImage = img;
  }

  //Callback function to handle the selected document
  void handleDocumentSelected(String value) {
    selectedDocument = value;
    setState(() {});
  }

  //Callback function to get the tab index value of, after the tab index changed
  void onTabIndexChanged(int value) {
    _isBikeTabSelected = value;
  }

  // callback function to get the image of the car after its uploaded
  void onCarImageUploaded(File? value) {
    uploadedCarImage = value;
    print("uploadedImage :::::: $uploadedCarImage");
  }

  // callback function to get the image of the bike after its uploaded
  void onBikeImageUploaded(File? value) {
    uploadedBikeImage = value;
    print("uploadedImage :::::: $uploadedBikeImage");
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _vehicleRegistrationNumber.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }
  void getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
  }

  @override
  Widget build(BuildContext context) {
    final addVehicleProvider = Provider.of<AddVehicle>(context);
    final imageProvider = Provider.of<ImageUploader>(context);
    final authProvider = Provider.of<AuthProvider>(context);
    void setDriverVerification() async {
      var prefs = await SharedPreferences.getInstance();
      prefs.setBool("isDriverVerified", true);
      Get.to(const MainPage());
    }

    final driverVerificationProvider =
        Provider.of<DriverVerificationProvider>(context);
    double width = MediaQuery.of(context).size.width;
    List<Step> getSteps() => [
          Step(
              state: driverVerificationProvider.currentStep > 0
                  ? StepState.complete
                  : StepState.indexed,
              isActive: driverVerificationProvider.currentStep == 0,
              title: ReuseableText(
                  text: "Step 1",
                  style:
                      roundFont(16, Color(darkHeading.value), FontWeight.bold)),
              content: const Step1()),
          Step(
              state: driverVerificationProvider.currentStep > 1
                  ? StepState.complete
                  : StepState.indexed,
              isActive: driverVerificationProvider.currentStep == 1,
              title: ReuseableText(
                  text: "Step 2",
                  style:
                      roundFont(16, Color(darkHeading.value), FontWeight.bold)),
              content: Step2(
                onImageSelected: handleImageSelected,
                onDocumentSelected: handleDocumentSelected,
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
              )),
          Step(
              state: driverVerificationProvider.currentStep > 2
                  ? StepState.complete
                  : StepState.indexed,
              isActive: driverVerificationProvider.currentStep == 2,
              title: ReuseableText(
                  text: "Step 3",
                  style:
                      roundFont(16, Color(darkHeading.value), FontWeight.bold)),
              content: Step3(
                vehicleRegistrationNumber: _vehicleRegistrationNumber,
                exceptionController: _exception,
                featuresController: _features,
                makeCategoryController: _makeCategory,
                onTabIndexChanged: onTabIndexChanged,
                onCarSelected: onCarSelected,
                onBikeSelected: onBikeSelected,
                onCarImageUploaded: onCarImageUploaded,
                onBikeImageUploaded: onBikeImageUploaded,
              )),
        ];

    return SafeArea(
      child: Consumer<DriverVerificationProvider>(
        builder: (context, driverVerificationNotifier, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stepper(
              type: StepperType.horizontal,
              steps: getSteps(),
              currentStep: driverVerificationNotifier.currentStep,
              onStepContinue: () async {
                String firstName = _firstNameController.text.toString();
                String lastName = _lastNameController.text.toString();

                switch (driverVerificationNotifier.currentStep) {
                  case 0:
                    driverVerificationNotifier.incrementCurrentStep();
                    break;
                  case 1:
                    // Tofix : selectedImage cannot be null , before continuing to the nex step(case 2 OR step 3)
                    if ((firstName.isEmpty) ||
                        (lastName.isEmpty) ||
                        selectedDocument == 'Select Document' ||
                        selectedDocument.isEmpty) {
                      showToastMessage(context, "Please Enter all the fields",
                          Icons.error_outline);
                    } else {
                      driverVerificationNotifier.incrementCurrentStep();
                    }
                    break;
                  case 2:
                    String vehicleRegistrationNumber =
                        _vehicleRegistrationNumber.text.toString();

                    // User Identity (Step 2) Details
                    print("First Name:${_firstNameController.text.toString()}");
                    print("Last Name:${_lastNameController.text.toString()}");
                    print(
                        "Identity Dropdown Selected:${selectedDocument.toString()}");
                    print("Image of identity ${selectedImage.toString()}");
                    print(_isBikeTabSelected == 0
                        ? "Car Details Uploading..."
                        : "Bike Details Uploading...");
                    if (_isBikeTabSelected == 0) {
                      if ((selectedCar['Name'] == null) ||
                          (selectedCar['Name'] == 'Select Type') ||
                          vehicleRegistrationNumber.isEmpty) {
                        showToastMessage(context, "Please Enter all the fields",
                            Icons.error_outline_outlined);
                      } else {
                        addVehicleProvider.setWaiting(true);
                        String? imageUrl = "";
                        if (uploadedCarImage != null) {
                          // Now you can safely access properties and methods of uploadedCarImage
                          imageUrl = await imageProvider
                              .imageUpload(uploadedCarImage!);
                        } // heck if it is null or not , before uploading
                        AddVehicleReqModel model = AddVehicleReqModel(
                            userId: userId!,
                            type: selectedCar['Name'] == "Auto Rickshaw"
                                ? "Auto Rickshaw"
                                : "Car",
                            image: imageUrl!,
                            model: selectedCar['Name']!,
                            registrationNumber: vehicleRegistrationNumber,
                            offeringSeat: addVehicleProvider.numOfSeatSelected,
                            makeAndCategory: _makeCategory.text,
                            features: _features.text,
                            exception: _exception.text,
                            isDefault: addVehicleProvider.isDefaultVehicle,
                            requiredHelmet: false);
                        addVehicleProvider.addVehicle(model);
                        print(
                            "Vehicle Registration Number : ${vehicleRegistrationNumber}");
                        print(
                            "Make & category : ${_makeCategory.text.toString()}"); // check if it is null or not before sending to server
                        print(
                            "Features : ${_features.text.toString()}"); // check if it is null or not before sending to server
                        print(
                            "Is this vehicle is default : ${addVehicleProvider.isDefaultVehicle}");
                        print(
                            "Name : ${selectedCar['Name']} /n Image Path : ${selectedCar['Img']}");
                        print(selectedCar['Name'] == null
                            ? carTypeAndImg[0]
                            : selectedCar);
                        print(
                            "Vehicle Image File : ${uploadedCarImage.toString()}"); // check if it is null or not , before uploading
                        print(
                            "Number of seats selected : ${addVehicleProvider.numOfSeatSelected}");
                        String? documentImage =
                        await imageProvider.imageUpload(selectedImage);
                        UploadIdentityModel identityModel = UploadIdentityModel(firstName: _firstNameController.text.toString(), lastName: _lastNameController.text.toString(), identityDocument: IdentityDocument(documentType: selectedDocument.toString(), documentImg: documentImage!));
                        authProvider.uploadIdentity(identityModel);
                        // here set share prefs
                        setDriverVerification();
                      }
                    } else {
                      if ((selectedBike['Name'] == null) ||
                          (selectedBike['Name'] == 'Select Type') ||
                          (vehicleRegistrationNumber.isEmpty) ||
                          (addVehicleProvider.carryHelmet == 0)) {
                        showToastMessage(context, "Please Enter all the fields",
                            Icons.error_outline_outlined);
                      } else {
                        addVehicleProvider.setWaiting(true);
                        print(
                            "Helmet Required (1 : Required, 2:Optional ) : ${addVehicleProvider.carryHelmet}");
                        print(
                            "Name : ${selectedBike['Name']} /n Image Path : ${selectedBike['Img']}");
                        String? imageUrl = "";
                        if (uploadedBikeImage != null) {
                          imageUrl =
                          await imageProvider.imageUpload(uploadedBikeImage!);
                        }
                        AddVehicleReqModel model = AddVehicleReqModel(
                            userId: userId!,
                            type: selectedBike['Name'] == "Bike"
                                ? "Bike"
                                : "Scooter",
                            image: imageUrl!,
                            model: selectedBike['Name']!,
                            registrationNumber: vehicleRegistrationNumber,
                            offeringSeat: 0,
                            makeAndCategory: _makeCategory.text,
                            features: _features.text,
                            exception: "",
                            isDefault: addVehicleProvider.isDefaultVehicle,
                            requiredHelmet: addVehicleProvider.carryHelmet == 1
                                ? true
                                : false);

                        addVehicleProvider.addVehicle(model);
                        print(
                            "Vehicle Registration Number : ${vehicleRegistrationNumber}");
                        print(
                            "Make & category : ${_makeCategory.text.toString()}"); // check if it is null or not before sending to server
                        print(
                            "Features : ${_features.text.toString()}"); // check if it is null or not before sending to server
                        print(
                            "Is this vehicle is default : ${addVehicleProvider.isDefaultVehicle}");
                        print(
                            "Name : ${selectedBike['Name']} /n Image Path : ${selectedBike['Img']}");
                        print(selectedBike['Name'] == null
                            ? carTypeAndImg[0]
                            : selectedBike);
                        print(
                            "Vehicle Image File : ${uploadedBikeImage.toString()}"); // check if it is null or not , before uploading
                        print(
                            "Helmet Required (1 : Required, 2:Optional ) : ${addVehicleProvider.carryHelmet}");

                        String? documentImage =
                        await imageProvider.imageUpload(selectedImage);
                        UploadIdentityModel identityModel = UploadIdentityModel(firstName: _firstNameController.text.toString(), lastName: _lastNameController.text.toString(), identityDocument: IdentityDocument(documentType: selectedDocument.toString(), documentImg: documentImage!));
                        authProvider.uploadIdentity(identityModel);
                        // here set share prefs
                        setDriverVerification();
                      }
                    }

                    break;
                }
              },
              onStepCancel: () {
                if (driverVerificationNotifier.currentStep == 0) {
                  return;
                } else {
                  driverVerificationNotifier.decrementCurrentStep();
                }
              },
              controlsBuilder: (context, details) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                        visible: driverVerificationNotifier.currentStep == 0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Divider(
                              thickness: 1,
                              color: Color(lightBorder.value),
                            ),
                            const HeightSpacer(size: 5),
                            Text(
                              "By Selecting \"Continue\" you agree to the",
                              style: roundFont(width * 0.04,
                                  Color(darkHeading.value), FontWeight.w500),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      // go to privacy policy page
                                    },
                                    child: Text(
                                      "Privacy Policy",
                                      style: roundFont(
                                              width * 0.04,
                                              Color(darkHeading.value),
                                              FontWeight.bold)
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.underline),
                                    )),
                                Text(
                                  "  and  ",
                                  style: roundFont(
                                      width * 0.04,
                                      Color(darkHeading.value),
                                      FontWeight.w500),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Go to T&C page
                                  },
                                  child: Text(
                                    "Terms & Condition",
                                    style: roundFont(
                                            width * 0.04,
                                            Color(darkHeading.value),
                                            FontWeight.bold)
                                        .copyWith(
                                            decoration:
                                                TextDecoration.underline),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )),
                    const HeightSpacer(size: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(loginPageColor.value),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                minimumSize: const Size(100, 55),
                              ),
                              onPressed: details.onStepContinue,
                              child: Text(
                                "Continue",
                                style: roundFont(width * 0.06, Colors.white,
                                    FontWeight.bold),
                              )),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Visibility(
                          visible: driverVerificationNotifier.currentStep == 0
                              ? false
                              : true,
                          child: Expanded(
                            child: OutlinedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  minimumSize: const Size(100, 55),
                                ),
                                onPressed: details.onStepCancel,
                                child: Text(
                                  "Cancel",
                                  style: roundFont(
                                      width * 0.06,
                                      Color(loginPageColor.value),
                                      FontWeight.bold),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
