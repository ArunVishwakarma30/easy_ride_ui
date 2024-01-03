import 'package:easy_ride/models/request/login_req_model.dart';
import 'package:easy_ride/models/request/sign_up_req_model.dart';
import 'package:easy_ride/services/helper/auth_helper.dart';
import 'package:easy_ride/views/common/toast_msg.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthProvider extends ChangeNotifier {
  // for on , off the visibility of the password
  bool _secure = true;
  bool _waiting = false;

  get secure => _secure;

  get waiting => _waiting;

  void setWaiting(bool value) {
    _waiting = value;
    notifyListeners();
  }

  void setSecure() {
    if (_secure) {
      _secure = false;
    } else {
      _secure = true;
    }
    notifyListeners();
  }

  signUp(SignUpReqModel model) {
    AuthHelper.signUp(model).then((responseStatusCode) {
      if (responseStatusCode == 201) {
        ShowSnackbar(
            title: "Success",
            message: "Successfully Registered!",
            icon: Icons.done_outline,
            bgColor: Colors.green,
            textColor: Colors.white);
        Get.offAll(() => const MainPage(),
            transition: Transition.fadeIn, duration: const Duration(seconds: 2));
      } else if (responseStatusCode == 409) {
        ShowSnackbar(
            title: "Sign Up Failed",
            message: "Email already exists",
            icon: Icons.error_outline_outlined);
      } else {
        ShowSnackbar(
            title: "Sign Up Failed",
            message: "Please check your credentials!",
            icon: Icons.add_alert);
      }
      setWaiting(false);
    });
  }

  login(LoginReqModel model) {
    AuthHelper.login(model).then((response) {
      if (response) {
        ShowSnackbar(
            title: "Success",
            message: "Successfully logged In!",
            icon: Icons.done_outline,
            bgColor: Colors.green,
            textColor: Colors.white);
        Get.offAll(() => const MainPage(),
            transition: Transition.fadeIn, duration: const Duration(seconds: 2));
      } else {
        ShowSnackbar(
            title: "Invalid login details",
            message: "Please check your credentials!",
            icon: Icons.add_alert);
      }
      setWaiting(false);
    });
  }
}
