import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodies/controller/connectivity_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/lottie_constant.dart';
import 'package:foodies/view/home_screen/home_screen.dart';
import 'package:foodies/widgets/foodies_container.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class NoConnectionScreen extends StatefulWidget {
  NoConnectionScreen({super.key});

  @override
  State<NoConnectionScreen> createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  bool loading = false;
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
            FoodiesContainer(
              paddingLeft: DimenConstant.padding * 2.0,
              paddingRight: DimenConstant.padding * 2.0,
              onPressed: () {
                loading = true;
                setState(() {});
                Timer(
                  Duration(
                    seconds: 2,
                  ),
                  () {
                    connectivityController.checkConnectivity();
                    if (connectivityController.connected) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                        (route) => false,
                      );
                    } else {
                      loading = false;
                      setState(() {});
                    }
                  },
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  loading
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
          ],
        ),
      ),
    );
  }
}
