import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/driver_verification/question_heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/customTextField.dart';

class Step2 extends StatefulWidget {
  final ValueChanged<String> onDocumentSelected;

  const Step2({Key? key, required this.onDocumentSelected}) : super(key: key);

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  String selectedDocument = 'Select Document';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool isDropdownEnabled = false;
    // Define the dropdown items
    List<String> documentOptions = [
      'Select Document',
      'Passport',
      'Aadhaar Card',
      'PAN Card',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReuseableText(
            text: "Verify your Government ID",
            style: roundFont(
                width * 0.06, Color(darkHeading.value), FontWeight.bold)),
        const HeightSpacer(size: 20),
        const QuestionWidget(
            iconPath: "assets/icons/num_one.png",
            question: "Enter your name, exactly as it is on your document "),
        const HeightSpacer(size: 20),
        const CustomTextField(
          label: 'First Name',
          keyType: TextInputType.name,
          textSce: false,
        ),
        const HeightSpacer(size: 20),
        const CustomTextField(
          label: 'Last Name',
          keyType: TextInputType.name,
          textSce: false,
        ),
        const HeightSpacer(size: 20),
        const QuestionWidget(
            iconPath: "assets/icons/num_two.png",
            question: "Please select, which document would you like to upload"),
        const HeightSpacer(size: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(
                color: selectedDocument == "Select Document"
                    ? Color(lightBorder.value)
                    : Color(lightLoginBack.value),
                width: 2,
              )),
          child: DropdownButton<String>(
            underline: Container(
              height: 0,
            ),
            isDense: false,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            iconSize: 35.0,
            value: selectedDocument,
            onChanged: (String? newValue) {
              setState(() {
                selectedDocument = newValue!;
                widget.onDocumentSelected(selectedDocument);
              });
            },
            items: documentOptions.map((String value) {
              return DropdownMenuItem<String>(
                  value: value,
                  child: ReuseableText(
                    text: value,
                    style: roundFont(
                        16,
                        Color(darkHeading.value),
                        selectedDocument != "Select Document"
                            ? FontWeight.bold
                            : FontWeight.w500),
                  ));
            }).toList(),
          ),
        ),
        const HeightSpacer(size: 20),
        const QuestionWidget(
            iconPath: "assets/icons/num_three.png",
            question: "Upload proof of Identity"),
      ],
    );
  }
}
