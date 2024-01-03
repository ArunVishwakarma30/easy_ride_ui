import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

// Toast message
showToastMessage(BuildContext context, String msg, IconData icon) {
  FToast fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    margin: const EdgeInsets.only(top: 20),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    color: Colors.redAccent,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Text(
            msg,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    ),
  );
  fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 2),
      gravity: ToastGravity.TOP);
}

// Snackbar message
ShowSnackbar( {
  required String? title,
  required String? message,
  required IconData? icon,
  Color? textColor = Colors.white,
  Color? bgColor = Colors.redAccent,
}) {
  Get.snackbar(title!, message!, margin: const EdgeInsets.only(top: 15, left: 20, right:  20),
      colorText: textColor,

      backgroundColor: bgColor,
      icon: Icon(
        icon,
        color: Colors.white,
      ));
}
