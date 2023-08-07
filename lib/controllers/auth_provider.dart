import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  // for on , off the visibility of the password
  bool _secure = true;
  get secure => _secure;

  void setSecure() {
    if (_secure) {
      _secure = false;
    } else {
      _secure = true;
    }
    notifyListeners();
  }
}
