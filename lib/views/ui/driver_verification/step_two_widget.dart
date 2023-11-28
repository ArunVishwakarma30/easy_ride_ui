import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/driver_verification/question_heading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../common/customTextField.dart';

class Step2 extends StatefulWidget {
  const Step2(
      {Key? key,
      required this.onDocumentSelected,
      required this.firstNameController,
      required this.lastNameController})
      : super(key: key);

  final ValueChanged<String> onDocumentSelected;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  String selectedDocument = 'Select Document';
  File? img;

  // code to capture the identity proof from camera
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) {
        return;
      }

      final imageTemporary = File(image.path);
      img = imageTemporary;
      setState(() {});
    } on PlatformException catch (e) {
      // this code will run , if user denied the permission to access the camera
      print('Filed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
        CustomTextField(
          label: 'First Name',
          controller: widget.firstNameController,
          keyType: TextInputType.name,
          textSce: false,
        ),
        const HeightSpacer(size: 20),
        CustomTextField(
          label: 'Last Name',
          controller: widget.lastNameController,
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
        const HeightSpacer(size: 20),
        Row(
          children: [
            const Icon(
              Icons.info,
              size: 16,
            ),
            const SizedBox(
              width: 10,
            ),
            ReuseableText(
                text: "We can't verify you without your camera",
                style: roundFont(16, Colors.black, FontWeight.w500))
          ],
        ),
        img != null
            ? Container(
                height: 200,
                decoration: BoxDecoration(
                    border:
                        Border.all(width: 1, color: Color(lightBorder.value)),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Image.file(
                        img!,
                        height: 200,
                        width: width * 0.5,
                      ),
                    ),
                    SizedBox(
                      width: width * 0.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                                overflow: TextOverflow.fade,
                                softWrap: true,
                                "Make sure your details are clear and unobstructed",
                                style: roundFont(16, Color(darkHeading.value),
                                    FontWeight.w500)),
                          ),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.black)),
                              onPressed: () {
                                pickImage();
                              },
                              child: ReuseableText(
                                text: "Retake Photo",
                                style: roundFont(16, Color(darkHeading.value),
                                    FontWeight.w500),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : DottedBorder(
                strokeWidth: 1,
                dashPattern: const [6, 3],
                color: Color(lightBorder.value),
                child: Container(
                  width: width,
                  height: 200,
                  color: Color(lightBorder.value),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.camera_alt),
                      const HeightSpacer(size: 10),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.black)),
                          onPressed: () {
                            pickImage();
                          },
                          child: ReuseableText(
                            text: "Open Camera",
                            style: roundFont(
                                20, Color(darkHeading.value), FontWeight.w500),
                          )),
                    ],
                  ),
                ),
              ),
      ],
    );
  }
}
