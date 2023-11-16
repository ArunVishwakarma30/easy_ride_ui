import 'package:flutter/cupertino.dart';

import '../../../constants/app_constants.dart';
import '../../common/app_style.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {Key? key, required this.iconPath, required this.question})
      : super(key: key);

  final String iconPath;
  final String question;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Image.asset(
          iconPath,
          width: width * 0.05,
          height: width * 0.05,
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Text(question,
              style: roundFont(
                  width * 0.05, Color(darkHeading.value), FontWeight.bold)),
        ),
      ],
    );
  }
}
