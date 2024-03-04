import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodies/controller/connectivity_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/lottie_constant.dart';
import 'package:foodies/view/home_screen/home_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class NoConnectionScreen extends StatefulWidget {
  NoConnectionScreen({super.key});

  @override
  State<NoConnectionScreen> createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    ConnectivityController connectivityController =
        Provider.of<ConnectivityController>(
      context,
      listen: false,
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              LottieConstant.noInternet,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width * 0.6,
            ),
            DimenConstant.separator,
            Text(
              'No internet connection',
              style: TextStyle(
                color: ColorConstant.primary,
                fontSize: DimenConstant.small,
              ),
            ),
            DimenConstant.separator,
            Container(
              padding: EdgeInsets.symmetric(
                vertical: DimenConstant.padding,
                horizontal: DimenConstant.padding * 2,
              ),
              decoration: BoxDecoration(
                color: ColorConstant.tertiary,
                borderRadius: BorderRadius.circular(
                  DimenConstant.borderRadius,
                ),
              ),
              child: InkWell(
                onTap: () {
                  isLoading = true;
                  setState(() {});
                  Timer(
                    Duration(
                      seconds: 2,
                    ),
                    () {
                      connectivityController.checkConnectivity();
                      if (connectivityController.isConnected) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                          (route) => false,
                        );
                      } else {
                        isLoading = false;
                        setState(() {});
                      }
                    },
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    isLoading
                        ? SizedBox(
                            height: 24,
                            width: 24,
                            child: Padding(
                              padding: const EdgeInsets.all(
                                DimenConstant.padding / 2,
                              ),
                              child: CircularProgressIndicator(
                                color: ColorConstant.primary,
                                strokeCap: StrokeCap.round,
                                strokeWidth: 2.5,
                              ),
                            ),
                          )
                        : Icon(
                            Icons.refresh_rounded,
                            color: ColorConstant.primary,
                          ),
                    DimenConstant.separator,
                    Text(
                      'Retry',
                      style: TextStyle(
                        color: ColorConstant.secondary,
                        fontSize: DimenConstant.mini,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
