import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodies/controller/navigation_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/home_screen/home_screen.dart';
import 'package:foodies/view/login_screen/login_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var navigationController =
        Provider.of<NavigationController>(context, listen: false);
    Timer(
      Duration(
        seconds: 3,
      ),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                navigationController.isLoggedin ? HomeScreen() : LoginScreen(),
          ),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            ImageConstant.appLogo,
            height: MediaQuery.of(context).size.width / 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringConstant.appNamePartOne,
                style: TextStyle(
                  color: ColorConstant.primaryColor,
                  fontSize: DimenConstant.extraLargeText,
                ),
              ),
              Text(
                StringConstant.appNamePartTwo,
                style: TextStyle(
                  color: ColorConstant.secondaryColor,
                  fontSize: DimenConstant.extraLargeText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
