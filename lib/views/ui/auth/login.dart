import 'package:easy_ride/controllers/auth_provider.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/customTextField.dart';
import 'package:easy_ride/views/common/height_spacer.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/common/shadow_btn.dart';
import 'package:easy_ride/views/ui/auth/register.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/main_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return GestureDetector(onTap: () {
      // This closes the keyboard when tapping outside of text fields
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }, child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
      return Scaffold(
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
                        key: _formKey, // form key
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
                                    Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      child: CustomTextField(
                                        label: "Email",
                                        keyType: TextInputType.emailAddress,
                                        prefixIcon:
                                            const Icon(Icons.person_rounded),
                                        controller: _email,
                                        textSce: false,
                                        // validator: (value) {
                                        //   if (value == null || value.isEmpty) {
                                        //     return 'Please enter an email address';
                                        //   }
                                        //   // Regular expression to validate email format
                                        //   final emailRegex = RegExp(
                                        //       r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                                        //   if (!emailRegex.hasMatch(value)) {
                                        //     return 'Please enter a valid email address';
                                        //   }
                                        //   return null; // Validation passed
                                        // },
                                      ),
                                    ),
                                    CustomTextField(
                                      label: "Password",
                                      prefixIcon: const Icon(Icons.lock),
                                      keyType: TextInputType.name,
                                      controller: _password,
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          authProvider.setSecure();
                                        },
                                        child: authProvider.secure
                                            ? const Icon(Icons.visibility_off)
                                            : const Icon(Icons.visibility),
                                      ),
                                      textSce:
                                          authProvider.secure ? true : false,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    ShadowBtn(
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: ((context) =>
                                                      const MainPage())));
                                        }
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
                                    Flexible(
                                      child: Row(
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
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const RegisterPage()));
                                              },
                                              child: ReuseableText(
                                                  text: "Sign Up",
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
          ));
    }));
  }
}
