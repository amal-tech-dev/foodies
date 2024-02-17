import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/lottie_constant.dart';
import 'package:lottie/lottie.dart';

class NoConnectionScreen extends StatelessWidget {
  NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Lottie.asset(
            LottieConstant.noInternet,
            fit: BoxFit.fill,
          ),
          DimenConstant.separator,
          Text(
            'No internet connection',
            style: TextStyle(
              color: ColorConstant.primaryColor,
              fontSize: DimenConstant.smallText,
            ),
          ),
        ],
      ),
    );
  }
}
