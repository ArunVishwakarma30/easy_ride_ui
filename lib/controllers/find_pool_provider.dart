import 'package:easy_ride/views/common/service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindPoolProvider extends ChangeNotifier {
  DateTime? _travelDateTime = DateTime.now();

  get travelDateTime => _travelDateTime;

  void setTravelDateTime(BuildContext context) async {
    DateTime? tempDate = await pickDate(context);
    if (tempDate == null) {
      return;
    } else {
      TimeOfDay? tempTime = await pickTime(context);
      if (tempTime == null) {
        return;
      } else {
        final dateTime = DateTime(tempDate.year, tempDate.month, tempDate.day,
            tempTime.hour, tempTime.minute);
        _travelDateTime = dateTime;
      }
    }

    notifyListeners();
  }
}
