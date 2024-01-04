import 'package:easy_ride/models/request/update_profule_req.dart';
import 'package:easy_ride/services/helper/auth_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/response/get_user_model.dart';
import '../views/common/toast_msg.dart';
import '../views/ui/bottom_nav_bar/main_page.dart';

class ProfileProvider extends ChangeNotifier {
  Future<GetUser>? getUserRes;
  bool _waiting = false;

  get waiting => _waiting;

  void setWaiting(bool value) {
    _waiting = value;
    notifyListeners();
  }

  getUser() async {
    getUserRes = AuthHelper.getUser();
  }

  updateUser(UpdateProfileReq model) {
    AuthHelper.updateUser(model).then((isUpdated) {
      if (isUpdated) {
        ShowSnackbar(
            title: "Success",
            message: "Successfully logged In!",
            icon: Icons.done_outline,
            bgColor: Colors.green,
            textColor: Colors.white);
        Get.offAll(() => const MainPage(),

            duration: const Duration(seconds: 2));
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
