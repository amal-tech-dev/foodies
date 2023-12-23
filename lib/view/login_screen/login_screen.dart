import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/view/login_screen/login_widgets/login_options.dart';
import 'package:foodies/view/signup_screen/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(
            DimenConstant.edgePadding,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimenConstant.edgePadding,
                ),
                child: Image.asset(
                  ImageConstant.loginThumbnail,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(DimenConstant.edgePadding * 2),
                child: Text(
                  'Lets\'s You In',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.largeText,
                  ),
                ),
              ),
              Expanded(
                child: LoginOptions(
                  onGooglePressed: () {},
                  onEmailPressed: () {},
                  onGuestPressed: () {},
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create a new account > ',
                    style: TextStyle(
                      color: ColorConstant.secondaryColor,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
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
