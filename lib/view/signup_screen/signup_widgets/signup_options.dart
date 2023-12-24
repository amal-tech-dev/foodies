import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/login_screen/login_screen.dart';

class SignupOptions extends StatelessWidget {
  SignupOptions({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: DimenConstant.edgePadding * 1.5,
          ),
          decoration: BoxDecoration(
            color: ColorConstant.tertiaryColor,
            borderRadius: BorderRadius.circular(
              DimenConstant.borderRadius,
            ),
          ),
          child: TextField(
            controller: emailController,
            decoration: InputDecoration(
              label: Text(
                'Email',
                style: TextStyle(
                  color: ColorConstant.primaryColor,
                ),
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: ColorConstant.secondaryColor,
            ),
            cursorColor: ColorConstant.primaryColor,
          ),
        ),
        DimenConstant.separator,
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: DimenConstant.edgePadding * 1.5,
          ),
          decoration: BoxDecoration(
            color: ColorConstant.tertiaryColor,
            borderRadius: BorderRadius.circular(
              DimenConstant.borderRadius,
            ),
          ),
          child: TextField(
            controller: passwordController,
            decoration: InputDecoration(
              label: Text(
                'Password',
                style: TextStyle(
                  color: ColorConstant.primaryColor,
                ),
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: ColorConstant.secondaryColor,
            ),
            cursorColor: ColorConstant.primaryColor,
          ),
        ),
        DimenConstant.separator,
        ElevatedButton(
          style: ButtonStyle(
            fixedSize: MaterialStatePropertyAll(
              Size(
                MediaQuery.of(context).size.width,
                45,
              ),
            ),
            backgroundColor: MaterialStatePropertyAll(
              ColorConstant.primaryColor,
            ),
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
              (route) => false,
            );
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: ColorConstant.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
