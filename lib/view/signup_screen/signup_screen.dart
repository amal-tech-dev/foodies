import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/view/login_screen/login_screen.dart';
import 'package:foodies/view/signup_screen/signup_widgets/signup_options.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(
            DimenConstant.edgePadding,
          ),
          child: Column(
            children: [
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
                  'Create a New Account',
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: DimenConstant.mediumText,
                  ),
                ),
              ),
              Expanded(
                child: SignupOptions(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? > ',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false,
                    ),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              DimenConstant.separator,
            ],
          ),
        ),
      ),
    );
  }
}
