import 'dart:io';

import 'package:easy_ride/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

// code to capture the image from camera
Future<File?> captureImage({required bool isImageSourceGallery}) async {
  try {
    final image = await ImagePicker().pickImage(
        source:
            isImageSourceGallery ? ImageSource.gallery : ImageSource.camera);
    if (image == null) {
      return null;
    }

    final imageTemporary = File(image.path);
    return imageTemporary;
  } on PlatformException catch (e) {
    // this code will run , if user denied the permission to access the camera
    print('Filed to pick image: $e');
    return null;
  }
}

Future<DateTime?> pickDate(BuildContext context) {
  return showDatePicker(
      switchToInputEntryModeIcon: Icon(
        Icons.add,
        color: Color(loginPageColor.value),
      ),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100));
}

Future<TimeOfDay?> pickTime(BuildContext context) {
  return showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute));
}

Future pickDateTime(BuildContext context) async {
  DateTime? date = await pickDate(context);
  if (date == null) return;

  TimeOfDay? time = await pickTime(context);
  if (time == null) return;
}
