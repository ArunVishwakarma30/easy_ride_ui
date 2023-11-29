import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

// code to capture the image from camera
Future<File?> captureImage({required bool isImageSourceGallery}) async {
  try {
    final image = await ImagePicker().pickImage(source: isImageSourceGallery ? ImageSource.gallery : ImageSource.camera);
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
