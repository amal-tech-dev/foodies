import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/forget_password_screen/forget_password_screen.dart';
import 'package:foodies/view/get_started_screen/get_started_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginOptions extends StatefulWidget {
  LoginOptions({super.key});

  @override
  State<LoginOptions> createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isEmailPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setBool('loggedin', true);
            preferences.setString('login', 'guest');
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => GetStartedScreen(),
              ),
              (route) => false,
            );
          },
          child: Container(
            padding: EdgeInsets.all(
              DimenConstant.edgePadding * 1.5,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.tertiaryColor,
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: ColorConstant.primaryColor,
                ),
                DimenConstant.separator,
                Text(
                  'Continue as Guest',
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: DimenConstant.extraSmallText,
                  ),
                )
              ],
            ),
          ),
        ),
        DimenConstant.separator,
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            isEmailPressed = !isEmailPressed;
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(
              DimenConstant.edgePadding * 1.5,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.tertiaryColor,
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.alternate_email_outlined,
                  color: ColorConstant.primaryColor,
                ),
                DimenConstant.separator,
                Text(
                  'Continue with Email',
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: DimenConstant.extraSmallText,
                  ),
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: isEmailPressed,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DimenConstant.separator,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimenConstant.edgePadding,
                ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    label: Text(
                      'Email',
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                  ),
                  cursorColor: ColorConstant.secondaryColor,
                  cursorRadius: Radius.circular(
                    DimenConstant.cursorRadius,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimenConstant.edgePadding,
                ),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    label: Text(
                      'Password',
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                  ),
                  cursorColor: ColorConstant.secondaryColor,
                  cursorRadius: Radius.circular(
                    DimenConstant.cursorRadius,
                  ),
                ),
              ),
              DimenConstant.separator,
              InkWell(
                splashColor: Colors.transparent,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgetPasswordScreen(),
                  ),
                ),
                child: Text(
                  'Forget Password?',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                  ),
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
                    ColorConstant.secondaryColor,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        DimenConstant.separator,
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {},
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(
                DimenConstant.edgePadding * 1.5,
              ),
              decoration: BoxDecoration(
                color: ColorConstant.tertiaryColor,
                borderRadius: BorderRadius.circular(
                  DimenConstant.borderRadius,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.google,
                    color: ColorConstant.primaryColor,
                  ),
                  DimenConstant.separator,
                  Text(
                    'Continue with Google',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.extraSmallText,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
