import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodies/controller/connectivity_controller.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/view/home_screen/home_screen.dart';
import 'package:foodies/view/login_screen/login_screen.dart';
import 'package:foodies/view/no_connection_screen/no_connection_screen.dart';
import 'package:foodies/widgets/app_name.dart';
import 'package:foodies/widgets/custom_navigator.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  bool darkMode = false;
  ConnectivityController connectivity = ConnectivityController();

  @override
  void initState() {
    connectivity.checkConnectivity();
    user = auth.currentUser;
    Timer(
      Duration(seconds: 3),
      () => CustomNavigator.pushReplacement(
        context: context,
        replace: connectivity.connected
            ? user != null
                ? HomeScreen()
                : LoginScreen()
            : NoConnectionScreen(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    darkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              darkMode ? ImageConstant.logoDark : ImageConstant.logoLight,
              height: MediaQuery.of(context).size.width / 3,
            ),
            AppName(size: DimenConstant.xxLarge),
          ],
        ),
      ),
    );
  }
}
