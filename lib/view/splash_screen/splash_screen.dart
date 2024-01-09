import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/get_started_screen/get_started_screen.dart';
import 'package:foodies/view/home_screen/home_screen.dart';
import 'package:foodies/view/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoggedin = false;
  bool isNewLogin = false;
  @override
  void initState() {
    Timer(
      Duration(
        seconds: 3,
      ),
      () {
        getPreferences();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => isLoggedin
                ? isNewLogin
                    ? GetStartedScreen()
                    : HomeScreen()
                : LoginScreen(),
          ),
        );
      },
    );
    super.initState();
  }

  // fetch data from shared preferences
  getPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    isLoggedin = preferences.getBool('loggedin') ?? false;
    isNewLogin = preferences.getBool('newLogin') ?? true;
    setState(() {});
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
