import 'package:easy_ride/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestedRidePage extends StatefulWidget {
  RequestedRidePage({Key? key, this.rideDetail}) : super(key: key);
  var rideDetail;

  @override
  State<RequestedRidePage> createState() => _RequestedRidePageState();
}

class _RequestedRidePageState extends State<RequestedRidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: yellowDark,
      ),
    );
  }
}
