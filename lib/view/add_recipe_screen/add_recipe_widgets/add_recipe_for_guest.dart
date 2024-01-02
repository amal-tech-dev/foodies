import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/login_screen/login_screen.dart';
import 'package:foodies/view/signup_screen/signup_screen.dart';

class AddRecipeForGuest extends StatelessWidget {
  AddRecipeForGuest({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(
            DimenConstant.edgePadding * 4,
          ),
          child: Image.asset(
            ImageConstant.loginThumbnail,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimenConstant.edgePadding * 3,
          ),
          child: Text(
            StringConstant.addRecipeGuestText,
            style: TextStyle(
              color: ColorConstant.primaryColor,
              fontSize: DimenConstant.subtitleText,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 50,
        ),
        InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          ),
          child: Text(
            'Login to existing account',
            style: TextStyle(
              color: ColorConstant.secondaryColor,
              fontSize: DimenConstant.subtitleText,
            ),
          ),
        ),
        Text(
          '  or  ',
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.smallText,
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
            'Create new account',
            style: TextStyle(
              color: ColorConstant.secondaryColor,
              fontSize: DimenConstant.subtitleText,
            ),
          ),
        ),
      ],
    );
  }
}
