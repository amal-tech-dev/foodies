import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodies/controller/connectivity_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/font_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/home_screen/home_screen.dart';
import 'package:foodies/view/login_screen/login_screen.dart';
import 'package:foodies/view/no_connection_screen/no_connection_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  @override
  void initState() {
    Provider.of<ConnectivityController>(
      context,
      listen: false,
    ).checkConnectivity();
    user = auth.currentUser;
    Timer(
      Duration(
        seconds: 3,
      ),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Provider.of<ConnectivityController>(context).isConnected
                    ? user != null
                        ? HomeScreen()
                        : LoginScreen()
                    : NoConnectionScreen(),
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
            ImageConstant.logo,
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
                  fontFamily: FontConstant.font,
                ),
              ),
              Text(
                StringConstant.appNamePartTwo,
                style: TextStyle(
                  color: ColorConstant.secondaryColor,
                  fontSize: DimenConstant.extraLargeText,
                  fontFamily: FontConstant.font,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
