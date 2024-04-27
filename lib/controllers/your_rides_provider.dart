import 'package:easy_ride/models/request/accept_or_deny_req.dart';
import 'package:easy_ride/models/request/cancel_ride_req_model.dart';
import 'package:easy_ride/models/request/finish_ride_req_model.dart';
import 'package:easy_ride/models/request/send_otp_req_model.dart';
import 'package:easy_ride/models/request/start_ride_req.dart';
import 'package:easy_ride/models/request/verify_otp_req_model.dart';
import 'package:easy_ride/models/response/requested_ride_res_model.dart';
import 'package:easy_ride/models/response/send_otp_res_model.dart';
import 'package:easy_ride/models/response/your_rides_res_model.dart';
import 'package:easy_ride/services/helper/your_rides_helper.dart';
import 'package:easy_ride/views/common/toast_msg.dart';
import 'package:easy_ride/views/ui/bottom_nav_bar/main_page.dart';
import 'package:easy_ride/views/ui/your_rides/verify_otp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YourRidesProvider extends ChangeNotifier {
  late Future<List<YourCreatedRidesResModel>>? allCreatedRides;
  late Future<List<RequestedRidesResModel>>? allRequestedRides;
  late YourCreatedRidesResModel createdRide;
  late Future<SendOtpResModel>? otpHashData;

  bool _waiting = false;

  get waiting => _waiting;

  void setWaiting(bool value) {
    _waiting = value;
    notifyListeners();
  }

  getAllCreatedRides() {
    allCreatedRides = YourRidesHelper.getAllCreatedRides();
  }

  getAllRequestedRides() {
    allRequestedRides = YourRidesHelper.getAllRequestedRides();
  }

  cancelRide(CancelRideReqModel model, String rideId) {
    YourRidesHelper.cancelRide(model, rideId).then((value) {
      if (value) {
        ShowSnackbar(
            title: "Successful",
            message: "Your Ride  is Successfully.",
            icon: Icons.done_outline,
            bgColor: Colors.green,
            textColor: Colors.white);
        Get.offAll(() => const MainPage());
      } else {
        ShowSnackbar(
            title: "Failed",
            message: "Something went wrong! Please try again later.",
            icon: Icons.error,
            bgColor: Colors.red,
            textColor: Colors.white);
      }
    });
  }

  acceptOrDeclineUserRideReq(AcceptOrDenyReq model, String rideId) {
    YourRidesHelper.acceptOrDeclineUserRideRequest(model, rideId).then((value) {
      if (value) {
        ShowSnackbar(
            title: "Success",
            message:
                model.isAccepted ? "Request Accepted!" : "Request Declined!",
            icon: Icons.done_outline,
            bgColor: Colors.green,
            textColor: Colors.white);
        Get.offAll(() => const MainPage());
      } else {
        ShowSnackbar(
            title: "Failed",
            message: "Something went wrong!",
            icon: Icons.add_alert);
        Get.offAll(() => const MainPage());
      }
    });
  }


  startRide(BuildContext context, StartRideReq model, String rideId) {
    YourRidesHelper.startRide(model, rideId).then((value) {
      if (value) {
        scaffoldMessage(context, "Ride Started");
        Get.offAll(() => const MainPage());
      } else {
        ShowSnackbar(
            title: "Failed",
            message: "Something went wrong!",
            icon: Icons.add_alert);
        Get.offAll(() => const MainPage());
      }
    });
  }


  finishRide(BuildContext context, FinishRideReq model, String rideId) {
    YourRidesHelper.finishRide(model, rideId).then((value) {
      if (value) {
        scaffoldMessage(context, "Ride Completed");
        Get.offAll(() => const MainPage());
      } else {
        ShowSnackbar(
            title: "Failed",
            message: "Something went wrong!",
            icon: Icons.add_alert);
        Get.offAll(() => const MainPage());
      }
    });
  }


  // send OTP
  sendOTP(SendOtpReqModel model) {
    YourRidesHelper.sendOTP(model).then((value) {
      if (value[0]) {
        otpHashData = Future.value(value[1]);
        ShowSnackbar(
            title: "Successful",
            message: "OTP Successfully Sent.",
            icon: Icons.done_outline,
            bgColor: Colors.green,
            textColor: Colors.white);
        Get.to(
                () => OTPVerificationPage(emailAddress: model.email),
            transition: Transition.rightToLeft,
            arguments: "passengerProfile");
      } else {
        ShowSnackbar(
            title: "Failed",
            message: "Try again later",
            icon: Icons.error_outline_outlined);
      }
    });
  }

  // verify otp

verifyOTP(VerifyOtpReqModel model){
    YourRidesHelper.verifyOTP(model).then((value) {
      if(value){
        ShowSnackbar(
            title: "Successful",
            message: "OTP Verified",
            icon: Icons.done_outline,
            bgColor: Colors.green,
            textColor: Colors.white);
        Get.offAll(MainPage());
      }else{
        ShowSnackbar(
            title: "Failed",
            message: "Invalid OTP",
            icon: Icons.done_outline,
        );
        Get.offAll(MainPage());
      }
    });
}
}
