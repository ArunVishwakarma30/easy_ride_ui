import 'package:easy_ride/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RideDetailsPage extends StatelessWidget {
  const RideDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: loginPageColor),
      ),
    );
  }
}
