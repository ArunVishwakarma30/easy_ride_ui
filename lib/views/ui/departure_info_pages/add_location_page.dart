import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({Key? key}) : super(key: key);

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  String dataFromPrevPage = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(dataFromPrevPage),
      ),
    );
  }
}
