import 'package:easy_ride/constants/app_constants.dart';
import 'package:easy_ride/controllers/onboarding_provider.dart';
import 'package:easy_ride/views/common/app_style.dart';
import 'package:easy_ride/views/common/reuseable_text_widget.dart';
import 'package:easy_ride/views/ui/auth/login.dart';
import 'package:easy_ride/views/ui/auth/temp.dart';
import 'package:easy_ride/views/ui/onboarding/page_one.dart';
import 'package:easy_ride/views/ui/onboarding/page_three.dart';
import 'package:easy_ride/views/ui/onboarding/page_two.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../common/shadow_btn.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();
  int _curretPageIndex = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print("Build");
    return Scaffold(body:
        Consumer<OnBoardingProvider>(builder: (context, onBoarNotifoer, child) {
      return Stack(
        children: [
          PageView(
            physics: onBoarNotifoer.islastPage
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: (page) {
              _curretPageIndex = page;
              if (page == 2) {
                onBoarNotifoer.setLastPage(true);
              } else {
                onBoarNotifoer.setLastPage(false);
              }
            },
            children: const [
              PageOne(),
              PageTwo(),
              PageThree(),
            ],
          ),
          Positioned(
              top: height * 0.06,
              right: width * 0.06,
              child: onBoarNotifoer.islastPage
                  ? const SizedBox.shrink()
                  : InkWell(
                      onTap: () {
                        pageController.jumpToPage(2);
                      },
                      child: ReuseableText(
                          text: "skip",
                          style: appStyle(
                              18, Color(lightShade.value), FontWeight.w600)))),
          Positioned(
              top: height * 0.65,
              left: width * 0.4,
              child: Center(
                child: onBoarNotifoer.islastPage
                    ? const SizedBox.shrink()
                    : SmoothPageIndicator(
                        count: 3,
                        controller: pageController,
                        effect: ExpandingDotsEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            activeDotColor: Color(lightShade.value),
                            dotColor: Color(textColor.value).withOpacity(0.5)),
                      ),
              )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            height: height * 0.85, // You can adjust the height as needed
            width: width,

            child: onBoarNotifoer.islastPage
                ? const SizedBox.shrink()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _curretPageIndex == 0
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: InkWell(
                                onTap: () {
                                  // pageController.previousPage(
                                  //     duration:
                                  //         const Duration(milliseconds: 300),
                                  //     curve: Curves.linear);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>const LoginPage()));
                                          
                                },
                                child: ReuseableText(
                                  text: "back",
                                  style: appStyle(19, Color(lightShade.value),
                                      FontWeight.w600),
                                ),
                              ),
                            ),
                      ShadowBtn(
                        height: 60,
                        size: 30.0,
                        width: 60.0,
                        child: const Icon(
                          Icons.arrow_forward,
                          size: 30.0,
                          color: Colors.white,
                        ),
                        onTap: () {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear);
                        },
                      ),
                    ],
                  ),
          )
        ],
      );
    }));
  }
}
