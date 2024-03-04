import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/login_screen/login_widgets/login_options.dart';
import 'package:foodies/view/signup_screen/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
            children: [
              SizedBox(
                height: kToolbarHeight,
              ),
              Center(
                child: Image.asset(
                  ImageConstant.login,
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  DimenConstant.padding * 2,
                ),
                child: Text(
                  StringConstant.login,
                  style: TextStyle(
                    color: ColorConstant.primary,
                    fontSize: DimenConstant.large,
                  ),
                ),
              ),
              LoginOptions(),
              DimenConstant.separator,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create a new account - ',
                    style: TextStyle(
                      color: ColorConstant.primary,
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignupScreen(),
                      ),
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: ColorConstant.secondary,
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
