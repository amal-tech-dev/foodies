import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/view/overview_screen/overview_screen_1.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isVisible = false;

  @override
  void initState() {
    Timer(
      Duration(seconds: 1),
      () {
        isVisible = true;
        Timer(
          Duration(seconds: 3),
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => OverviewScreen1(),
              ),
            );
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    ImageConstant.appLogo,
                  ),
                  DimenConstant.separator,
                  Image.asset(
                    ImageConstant.appTitleLogo,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Center(
              child: Visibility(
                visible: isVisible,
                child: CircularProgressIndicator(
                  color: ColorConstant.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
