import 'package:flutter/cupertino.dart';

class BottomNavNotifier extends ChangeNotifier{

  // todo : In order to work bottom nav bar properly, set _currentIndex = 2
  int _currentIndex = 2; // temp change, make this 2 in future
  get currentIndex => _currentIndex;

  void setCurrentIndex(int index){
    _currentIndex = index;
    notifyListeners();
  }
}