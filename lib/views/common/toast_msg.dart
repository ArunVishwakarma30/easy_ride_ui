import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
