import 'package:flutter/cupertino.dart';

class BottomNavNotifier extends ChangeNotifier{
  int _currentIndex = 2;
  get currentIndex => _currentIndex;

  void setCurrentIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }
}