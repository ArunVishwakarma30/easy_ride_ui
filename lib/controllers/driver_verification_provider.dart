import 'package:flutter/cupertino.dart';

class DriverVerificationProvider extends ChangeNotifier {

  int _currentStep = 0;

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
