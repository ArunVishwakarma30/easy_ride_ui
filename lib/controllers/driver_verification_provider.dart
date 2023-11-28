import 'package:flutter/cupertino.dart';

class DriverVerificationProvider extends ChangeNotifier {

  // in order to work properly set current step to 0
  int _currentStep = 2;

  int get currentStep => _currentStep;

  void incrementCurrentStep() {
    _currentStep++;
    notifyListeners();
  }

  void decrementCurrentStep() {
    _currentStep--;
    notifyListeners();
  }


}
