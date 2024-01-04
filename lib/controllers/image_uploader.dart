import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class ImageUploader extends ChangeNotifier {
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
