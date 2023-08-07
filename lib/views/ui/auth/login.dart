import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/customTextField.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/common/shadow_btn.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    TextEditingController().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // This closes the keyboard when tapping outside of text fields
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false, //
          body: Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    child: Container(
                      height: height * 0.26,
                      decoration: BoxDecoration(
                          color: Color(loginPageColor.value),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          )),
                      child: Center(
                          child: ReuseableText(
                              text: "Easy Ride",
                              style: roundFont(
                                  30, Colors.white, FontWeight.w600))),
                    )),
                Positioned(
                    top: height * 0.21,
                    left: 20,
                    right: 20,
                    child: Container(
                      height: height * 0.74,
                      width: width * 0.90,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color.fromARGB(221, 99, 93, 93), // Shadow color
                            offset: Offset(0, 2), // Offset of the shadow
                            blurRadius: 4, // Spread of the shadow
                            spreadRadius: 0, // Spread radius of the shadow
                          ),
                        ],
                      ),
                      child: Form(
                        key: formKey, // form key
                        child: Column(
                          children: [
                            const HeightSpacer(size: 10),
                            Expanded(
                                flex: 1,
                                child: Center(
                                    child: Padding(
                                  padding: EdgeInsets.only(top: height * 0.07),
                                  child: ReuseableText(
                                      text: "Login",
                                      style: roundFont(
                                          28,
                                          Color(loginPageColor.value),
                                          FontWeight.bold)),
                                ))),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.1),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomTextField(
                                      label: "Email or Phone Number",
                                      keyType: TextInputType.name,
                                      prefixIcon:
                                          const Icon(Icons.person_rounded),
                                      controller: name,
                                      textSce: false,
                                    ),
                                    CustomTextField(
                                      label: "Password",
                                      prefixIcon: const Icon(Icons.lock),
                                      keyType: TextInputType.name,
                                      controller: password,
                                      textSce: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Container(
                                  child: Column(
                                    children: [
                                      ShadowBtn(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginPage()));
                                        },
                                        gradientColor1: const Color.fromARGB(
                                            255, 65, 100, 189),
                                        gradientColor2:
                                            Color(loginPageColor.value),
                                        size: 18.0,
                                        height: 55,
                                        width: width * 0.4,
                                        child: Text(
                                          'Login',
                                          style: GoogleFonts.varelaRound(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20.0,
                                            letterSpacing: 0.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const HeightSpacer(size: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ReuseableText(
                                              text: "Don't have and account? ",
                                              style: roundFont(
                                                  17,
                                                  Color(loginPageColor.value),
                                                  FontWeight.w600)),
                                          InkWell(
                                              onTap: () {
                                                print("tapped");
                                              },
                                              child: ReuseableText(text: "Sign Up", style: roundFont(16, Color(loginPageColor.value), FontWeight.bold).copyWith(decoration: TextDecoration.underline)))
                                        ],
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}
