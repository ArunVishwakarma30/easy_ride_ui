import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/controllers/driver_verification_provider.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/common/toast_msg.dart';
import 'package:easy_ride/views/ui/driver_verification/step_one_widget.dart';
import 'package:easy_ride/views/ui/driver_verification/step_three.dart';
import 'package:easy_ride/views/ui/driver_verification/step_two_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DriverVerification extends StatefulWidget {
  const DriverVerification({Key? key}) : super(key: key);

  @override
  State<DriverVerification> createState() => _DriverVerificationState();
}

class _DriverVerificationState extends State<DriverVerification> {
  String selectedDocument = '';
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                onDocumentSelected: (String value) {
                  setState(() {
                    selectedDocument = value;
                  });
                },
                firstNameController: firstNameController,
                lastNameController: lastNameController,
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
              content: Step3()),
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
              onStepContinue: () {
                String firstName = firstNameController.text.toString();
                String lastName = lastNameController.text.toString();

                switch (driverVerificationNotifier.currentStep) {
                  case 0:
                    driverVerificationNotifier.incrementCurrentStep();
                    break;
                  case 1:
                    if ((firstName.isEmpty) ||
                        (lastName.isEmpty) ||
                        selectedDocument == "Select Document") {
                      showToastMessage(context, "Please Enter all the fields",
                          Icons.error_outline);
                    } else {
                      driverVerificationNotifier.incrementCurrentStep();
                    }
                    break;
                  case 2:
                    print("for filling completed");
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
                            HeightSpacer(size: 5),
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
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                minimumSize: Size(100, 55),
                              ),
                              onPressed: details.onStepContinue,
                              child: Text(
                                "Continue",
                                style: roundFont(width * 0.06, Colors.white,
                                    FontWeight.bold),
                              )),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Visibility(
                          visible: driverVerificationNotifier.currentStep == 0
                              ? false
                              : true,
                          child: Expanded(
                            child: OutlinedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  minimumSize: Size(100, 55),
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
