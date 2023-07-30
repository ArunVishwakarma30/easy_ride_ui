import 'package:flutter/material.dart';

class OnBoardingProvider extends ChangeNotifier {
  bool _islastPage = false;
  get islastPage => _islastPage;

  void setLastPage(bool isLast) {
    _islastPage = isLast;
    notifyListeners();
  }


}
