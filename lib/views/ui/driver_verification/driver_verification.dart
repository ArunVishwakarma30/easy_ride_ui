import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/driver_verification/step_one_widget.dart';
import 'package:easy_ride/views/ui/driver_verification/step_two_widget.dart';
import 'package:flutter/material.dart';

class DriverVerification extends StatefulWidget {
  const DriverVerification({Key? key}) : super(key: key);

  @override
  State<DriverVerification> createState() => _DriverVerificationState();
}

class _DriverVerificationState extends State<DriverVerification> {
  //################################### change the _current step from 1 to 0 in order to work properly
  int _currentStep = 1;
  String selectedDocument = 'Select Document';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<Step> getSteps() => [
          Step(
              state: _currentStep > 0 ? StepState.complete : StepState.indexed,
              isActive: _currentStep == 0,
              title: ReuseableText(
                  text: "Step 1",
                  style:
                      roundFont(16, Color(darkHeading.value), FontWeight.bold)),
              content: const Step1()),
          Step(
              state: _currentStep > 1 ? StepState.complete : StepState.indexed,
              isActive: _currentStep == 1,
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
              )),
          Step(
              state: _currentStep > 2 ? StepState.complete : StepState.indexed,
              isActive: _currentStep == 2,
              title: ReuseableText(
                  text: "Step 3",
                  style:
                      roundFont(16, Color(darkHeading.value), FontWeight.bold)),
              content: const Text("Stepper 3")),
        ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: _currentStep,
          onStepContinue: () {
            print("Current Step: $_currentStep"); // Add this line
            if (_currentStep == 2) {
              // send data to server
              print("Form filling completed");
              // Print the selected document
              print("Selected Document: $selectedDocument");
            } else {
              _currentStep++;
            }
            setState(() {});
          },
          onStepCancel: () {
            if (_currentStep == 0) {
              return null;
              setState(() {});
            } else {
              _currentStep--;
              setState(() {});
            }
          },
          controlsBuilder: (context, details) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Visibility(
                    visible: _currentStep == 0,
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
                                          decoration: TextDecoration.underline),
                                )),
                            Text(
                              "  and  ",
                              style: roundFont(width * 0.04,
                                  Color(darkHeading.value), FontWeight.w500),
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
                                        decoration: TextDecoration.underline),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            minimumSize: Size(100, 55),
                          ),
                          onPressed: details.onStepContinue,
                          child: Text(
                            "Continue",
                            style: roundFont(
                                width * 0.06, Colors.white, FontWeight.bold),
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Visibility(
                      visible: _currentStep == 0 ? false : true,
                      child: Expanded(
                        child: OutlinedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              minimumSize: Size(100, 55),
                            ),
                            onPressed: details.onStepCancel,
                            child: Text(
                              "Cancel",
                              style: roundFont(width * 0.06,
                                  Color(loginPageColor.value), FontWeight.bold),
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
