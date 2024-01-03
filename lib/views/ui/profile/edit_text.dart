import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../constants/app_constants.dart';
import '../../common/app_style.dart';
import '../../common/customTextField.dart';
import '../../common/height_spacer.dart';
import '../../common/reuseable_text_widget.dart';

class EditText extends StatefulWidget {
  const EditText(
      {Key? key, required this.heading, required this.value, this.keyBoardType})
      : super(key: key);
  final String heading;
  final String value;
  final TextInputType? keyBoardType;

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  late TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.value;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.close_outlined,
                  color: Color(loginPageColor.value),
                  size: 30,
                ),
              ),
            ),
            const HeightSpacer(size: 25),
            ReuseableText(
                text: "What's your ${widget.heading}?",
                style: roundFont(25, darkHeading, FontWeight.bold)),
            const HeightSpacer(size: 30),
            CustomTextField(
              keyType: widget.keyBoardType ?? TextInputType.text,
              label: widget.heading,
              textSce: false,
              controller: _controller,
            ),
            const Expanded(child: HeightSpacer(size: 10)),
            Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                    onPressed: () {
                      // todo : get back with saving data
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(loginPageColor.value)),
                    child: ReuseableText(
                      text: "Save",
                      style: roundFont(20, Colors.white, FontWeight.bold),
                    )))
          ],
        ),
      )),
    );
  }
}
