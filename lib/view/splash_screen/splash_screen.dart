import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodies/controller/navigation_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/get_started_screen/get_started_screen.dart';
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
    Timer(
      Duration(
        seconds: 2,
      ),
      () {
        Provider.of<NavigationController>(context, listen: false)
            .startLoading();
        Timer(
          Duration(
            seconds: 3,
          ),
          () {
            Provider.of<NavigationController>(context, listen: false)
                .stopLoading();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    Provider.of<NavigationController>(context).isFirstVisit
                        ? GetStartedScreen()
                        : Provider.of<NavigationController>(context).isLoggedIn
                            ? HomeScreen()
                            : LoginScreen(),
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
                  Icon(
                    Icons.fastfood_rounded,
                    size: MediaQuery.of(context).size.width / 3,
                    color: ColorConstant.primaryColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringConstant.appNamePartOne,
                        style: TextStyle(
                          color: ColorConstant.secondaryColor,
                          fontSize: DimenConstant.extraLargeText,
                        ),
                      ),
                      Text(
                        StringConstant.appNamePartTwo,
                        style: TextStyle(
                          color: ColorConstant.primaryColor,
                          fontSize: DimenConstant.extraLargeText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Center(
              child: Visibility(
                visible: Provider.of<NavigationController>(context).isVisible,
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
