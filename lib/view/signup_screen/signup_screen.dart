import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorConstant.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(
            DimenConstant.edgePadding,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  BackButton(
                    color: ColorConstant.secondaryColor,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimenConstant.edgePadding,
                ),
                child: Center(
                  child: Image.asset(
                    ImageConstant.signupThumbnail,
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  DimenConstant.edgePadding * 2,
                ),
                child: Text(
                  'Create a New Account',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.mediumText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
