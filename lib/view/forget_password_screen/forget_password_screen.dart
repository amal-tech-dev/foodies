import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/forget_password_screen/forget_password_widgets/forget_password_options.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.padding,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: kToolbarHeight,
              ),
              BackButton(
                color: ColorConstant.primary,
              ),
              Padding(
                padding: const EdgeInsets.all(
                  DimenConstant.padding,
                ),
                child: Center(
                  child: Image.asset(
                    ImageConstant.signup,
                    height: MediaQuery.of(context).size.height * 0.175,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  DimenConstant.padding * 2,
                ),
                child: Text(
                  StringConstant.forgetPassword,
                  style: TextStyle(
                    color: ColorConstant.primary,
                    fontSize: DimenConstant.medium,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              ForgetPasswordOptions(),
            ],
          ),
        ),
      ),
    );
  }
}
