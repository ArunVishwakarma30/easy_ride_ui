import 'package:easy_ride/controllers/auth_provider.dart';
import 'package:easy_ride/models/request/sign_up_req_model.dart';
import 'package:easy_ride/views/common/toast_msg.dart';
import 'package:easy_ride/views/ui/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/customTextField.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/common/shadow_btn.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String num = "";

  @override
  void dispose() {
    // TODO: implement dispose
    _fullName.dispose();
    _password.dispose();
    _phoneNumber.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentFocus = FocusScope.of(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(onTap: () {
      // This closes the keyboard when tapping outside of text fields
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }, child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return Scaffold(

          // resizeToAvoidBottomInset: false, //
          body: SingleChildScrollView(
        child: Container(
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
                            style:
                                roundFont(30, Colors.white, FontWeight.w600))),
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
                      key: _formKey, // form key
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Center(
                                  child: Padding(
                                padding: EdgeInsets.only(top: height * 0.07),
                                child: ReuseableText(
                                    text: "Register",
                                    style: roundFont(
                                        28,
                                        Color(loginPageColor.value),
                                        FontWeight.bold)),
                              ))),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: width * 0.1),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomTextField(
                                    label: "Full Name",
                                    keyType: TextInputType.name,
                                    prefixIcon:
                                        const Icon(Icons.person_rounded),
                                    controller: _fullName,
                                    textSce: false,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Please enter Your Full Name';
                                      }

                                      // Splitting the entered value in to words
                                      List<String> nameParts =
                                          value.trim().split(' ');
                                      if (nameParts.length < 2) {
                                        return 'Please enter both First Name and Last Name';
                                      }

                                      return null; // Validation passed
                                    },
                                  ),
                                  CustomTextField(
                                    label: "Email address",
                                    keyType: TextInputType.emailAddress,
                                    prefixIcon: const Icon(Icons.mail_outlined),
                                    controller: _email,
                                    textSce: false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an email address';
                                      }
                                      // Regular expression to validate email format
                                      final emailRegex = RegExp(regEx);
                                      if (!emailRegex.hasMatch(value)) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null; // Validation passed
                                    },
                                  ),
                                  IntlPhoneField(
                                    style: roundFont(
                                        19, Colors.black, FontWeight.w400),
                                    decoration: InputDecoration(
                                      labelText: "Phone Number",
                                      border: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 1,
                                            style: BorderStyle
                                                .solid), // Custom border color
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(loginPageColor
                                                .value)), // Custom border color
                                      ),
                                    ),
                                    initialCountryCode: 'IN',
                                    onChanged: (phone) {
                                      num = phone.completeNumber;
                                    },
                                    controller: _phoneNumber,
                                    keyboardType: TextInputType.phone,
                                    obscureText: false,
                                  ),
                                  CustomTextField(
                                    label: "Password",
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        authProvider.setSecure();
                                      },
                                      child: authProvider.secure
                                          ? const Icon(Icons.visibility_off)
                                          : const Icon(Icons.visibility),
                                    ),
                                    keyType: TextInputType.name,
                                    controller: _password,
                                    textSce: authProvider.secure ? true : false,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter password';
                                      }
                                      if (value.length < 6) {
                                        return "Password must contain more then 6 characters";
                                      }

                                      return null; // Validation passed
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Column(
                                children: [
                                  ShadowBtn(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (_phoneNumber.text.isEmpty) {
                                          ShowSnackbar(
                                              title: "Required",
                                              message:
                                                  "Please Enter Phone Number",
                                              icon:
                                                  Icons.error_outline_outlined);
                                        } else {
                                          if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }
                                          authProvider.setWaiting(
                                              true); // this is set to true, so we can show the progressIndicator till user is registered
                                          int spaceIndex = _fullName.text
                                              .toString()
                                              .indexOf(' ');
                                          String firstName = _fullName.text
                                              .toString()
                                              .substring(0, spaceIndex);
                                          String lastName = _fullName.text
                                              .toString()
                                              .substring(spaceIndex + 1);

                                          SignUpReqModel model = SignUpReqModel(
                                              firstName: firstName.trim(),
                                              lastName: lastName.trim(),
                                              email: _email.text.toString(),
                                              phoneNumber: num.toString(),
                                              password:
                                                  _password.text.toString());

                                          authProvider.signUp(model);
                                        }
                                      }
                                    },
                                    gradientColor1:
                                        const Color.fromARGB(255, 65, 100, 189),
                                    gradientColor2: Color(loginPageColor.value),
                                    size: 18.0,
                                    height: 55,
                                    width: width * 0.4,
                                    child: authProvider.waiting
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            'Register',
                                            style: GoogleFonts.varelaRound(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20.0,
                                              letterSpacing: 0.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                  ),
                                  const HeightSpacer(size: 15),
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ReuseableText(
                                            text: "Already an user? ",
                                            style: roundFont(
                                                17,
                                                Color(loginPageColor.value),
                                                FontWeight.w600)),
                                        InkWell(
                                            onTap: () {
                                              Get.off(() => LoginPage(),
                                                  transition: Transition.fade);
                                            },
                                            child: ReuseableText(
                                                text: "Login",
                                                style: roundFont(
                                                        16,
                                                        Color(loginPageColor
                                                            .value),
                                                        FontWeight.bold)
                                                    .copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .underline)))
                                      ],
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ));
    }));
  }
}
