import 'package:flutter/material.dart';
import 'package:foodies/controller/email_login_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/view/login_screen/login_widgets/login_options.dart';
import 'package:foodies/view/signup_screen/signup_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

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
              Visibility(
                visible:
                    !Provider.of<EmailLoginController>(context).isEmailPressed,
                child: Center(
                  child: Image.asset(
                    ImageConstant.loginThumbnail,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                  DimenConstant.edgePadding * 2,
                ),
                child: Text(
                  'Let\'s You In',
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: DimenConstant.largeText,
                  ),
                ),
              ),
              Expanded(
                child: LoginOptions(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create a new account > ',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
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
