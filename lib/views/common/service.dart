import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

// code to capture the image from camera
Future<File?> captureImage({required bool isImageSourceGallery}) async {
  try {
    final image = await ImagePicker().pickImage(
        source: isImageSourceGallery ? ImageSource.gallery : ImageSource.camera, imageQuality: 50);
    if (image == null) {
      return null;
    }

    final imageTemporary = File(image.path);
    // File compressedImage = await compressImage(imageTemporary);
    // print("compressedImage :  $compressedImage");
    return imageTemporary;
  } on PlatformException catch (e) {
    // this code will run , if user denied the permission to access the camera
    print('Filed to pick image: $e');
    return null;
  }
}

// code to compress image
Future<File> compressImage(File file) async {
  const String targetPath = "/storage/emulated/0/Download/";
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    '$targetPath/EzRideFile.jpg',
  );

// Check if result is not null before accessing its properties
  if (result != null) {
    // result is in the form of XFile, and we want to return File
    File compressedFile = File(result.path);
    return compressedFile;
  } else {
    // Handle the case where compression failed
    throw Exception('Image compression failed');
  }

}

Future<DateTime?> pickDate(BuildContext context) {
  return showDatePicker(
      switchToInputEntryModeIcon: const Icon(
        Icons.add,
        color: Color(0xffeee8f4),
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

Future<TimeOfDay?> pickTime12HrsFormat(BuildContext context) {
  return showTimePicker(
    context: context,
    initialTime: TimeOfDay(
      hour: DateTime.now().hour,
      minute: DateTime.now().minute,
    ),
    builder: (BuildContext context, Widget? child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child!,
      );
    },
  );
}
