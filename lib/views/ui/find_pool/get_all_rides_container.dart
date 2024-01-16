import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/find_pool/path_painter.dart';

class GetAllRidesContainer extends StatelessWidget {
  const GetAllRidesContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top : 10.0, right: 15, left: 15),
      child: Card(

        elevation: 5,
        child: Column(
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                // ReuseableText(text: "11:00", style: roundFont(16, darkHeading, FontWeight.bold)),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
