import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindLocationPage extends StatefulWidget {
  const FindLocationPage({Key? key}) : super(key: key);

  @override
  State<FindLocationPage> createState() => _FindLocationPageState();
}

class _FindLocationPageState extends State<FindLocationPage> {
  String dataFromPrevPage = Get.arguments;
  String newData = "Safed pool Sakinaka, maharashtra, mumbai 400072 ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.back(result: newData);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 30,
                )),
            Center(
              child: Text(dataFromPrevPage),
            ),
          ],
        ),
      ),
    );
  }
}
