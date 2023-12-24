import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/view/forget_password_screen/forget_password_widgets/forget_password_options.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

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
                padding: const EdgeInsets.all(
                  DimenConstant.edgePadding,
                ),
                child: Expanded(
                  child: Center(
                    child: Image.asset(
                      ImageConstant.signupThumbnail,
                      height: MediaQuery.of(context).size.height * 0.175,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  DimenConstant.edgePadding * 2,
                ),
                child: Text(
                  'Enter Your Registered Email Id',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.mediumText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: ForgetPasswordOptions(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
