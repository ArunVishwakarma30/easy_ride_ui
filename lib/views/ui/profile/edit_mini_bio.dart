import 'package:easy_ride/controllers/profile_page_provider.dart';
import 'package:easy_ride/models/request/update_profule_req.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../models/response/get_user_model.dart';
import '../../common/app_style.dart';
import '../../common/height_spacer.dart';
import '../../common/reuseable_text_widget.dart';

class EditMiniBio extends StatefulWidget {
  const EditMiniBio({Key? key}) : super(key: key);

  @override
  State<EditMiniBio> createState() => _EditMiniBioState();
}

class _EditMiniBioState extends State<EditMiniBio> {
  late TextEditingController _controller;
  late GetUser userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    userData = Get.arguments;
    if(userData.miniBio.isNotEmpty){
      _controller.text = userData.miniBio;
    }
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
      child: Consumer<ProfileProvider>(
        builder: (context, profileNotifier, child) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
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
                    Text(
                        "What would you like other members to know about you ?",
                        style: roundFont(26, darkHeading, FontWeight.bold)),
                    const HeightSpacer(size: 30),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Color(backgroundGrey.value)),
                      child: TextFormField(
                        cursorColor: Color(loginPageColor.value),
                        style: roundFont(
                            16, Color(darkHeading.value), FontWeight.bold),
                        maxLines: 13,
                        minLines: 5,
                        keyboardType: TextInputType.multiline,
                        controller: _controller,
                        decoration: InputDecoration(
                          hintStyle:
                              roundFont(15, Colors.black45, FontWeight.bold),
                          hintText:
                              'Example: "I\'m a student at Mumbai University, and I often visit friends in mumbai. I love photography and rock music." ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                                color: Color(backgroundGrey.value),
                                width: 1,
                                style: BorderStyle.solid),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),

                            borderSide: BorderSide(
                                width: 1,
                                color: Color(backgroundGrey.value)), //
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),

                            borderSide: BorderSide(
                                width: 1,
                                color: Color(backgroundGrey
                                    .value)), // Custom border color
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: HeightSpacer(size: 10)),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                            onPressed: () {
                              UpdateProfileReq model = UpdateProfileReq(
                                  firstName: userData.firstName,
                                  lastName: userData.lastName,
                                  phoneNumber: userData.phoneNumber,
                                  miniBio: _controller.text.trim(),
                                  email: userData.email);
                              profileNotifier.updateUser(model);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(loginPageColor.value)),
                            child: profileNotifier.waiting
                                ? const CircularProgressIndicator()
                                : ReuseableText(
                                    text: "Save",
                                    style: roundFont(
                                        20, Colors.white, FontWeight.bold),
                                  )))
                  ],
                ),
              ));
        },
      ),
    );
    ;
  }
}
