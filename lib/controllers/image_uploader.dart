import 'dart:io';

import 'package:easy_ride/models/request/update_image_req.dart';
import 'package:easy_ride/services/helper/auth_helper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../views/common/toast_msg.dart';
import '../views/ui/bottom_nav_bar/main_page.dart';

class ImageUploader extends ChangeNotifier {
  String? finalImageUrl;
  bool _waiting = false;

  get waiting => _waiting;

  void setWaiting(bool value) {
    _waiting = value;
    notifyListeners();
  }

  saveImageToServer(UpdateProfileImageReq model) {
    AuthHelper.updateUserImage(model).then((isSaved) {
      if (isSaved) {
        ShowSnackbar(
            title: "Success",
            message: "Successfully Saved!",
            icon: Icons.done_outline,
            bgColor: Colors.green,
            textColor: Colors.white);
        Get.offAll(() => const MainPage(),
            transition: Transition.fadeIn,
            duration: const Duration(seconds: 2));
      } else {
        ShowSnackbar(
            title: "Failed to save",
            message: "Please try again later!",
            icon: Icons.add_alert);
      }
      setWaiting(false);
    });
  }

  var uuid = Uuid();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> imageUpload(File imgFile) async {
    Reference _ref = _storage.ref().child("EasyRide").child("${uuid.v1()}.jpg");
    // if image is not saving in the database then try to change firebase rule from here
// https://console.firebase.google.com/u/0/project/easy-ride-flutter-app/storage/easy-ride-flutter-app.appspot.com/rules
    UploadTask uploadTask = _ref.putFile(imgFile);

    TaskSnapshot snapshot = await uploadTask;
    String downLoadUrl = await snapshot.ref.getDownloadURL();

    print("DownLoadUrl : ****** ${downLoadUrl}");
    return downLoadUrl;
  }
}
