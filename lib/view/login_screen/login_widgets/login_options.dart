import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodies/controller/email_login_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/forget_password_screen/forget_password_screen.dart';
import 'package:foodies/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

class LoginOptions extends StatelessWidget {
  LoginOptions({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
            (route) => false,
          ),
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
                  color: ColorConstant.secondaryColor,
                ),
                DimenConstant.separator,
                Text(
                  'Continue as Guest',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.subtitleText,
                  ),
                )
              ],
            ),
          ),
        ),
        DimenConstant.separator,
        InkWell(
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
                  color: ColorConstant.secondaryColor,
                ),
                DimenConstant.separator,
                Text(
                  'Continue with Google',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.subtitleText,
                  ),
                )
              ],
            ),
          ),
        ),
        DimenConstant.separator,
        Provider.of<EmailLoginController>(context).isEmailPressed
            ? Column(
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
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgetPasswordScreen(),
                      ),
                    ),
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                  ),
                  DimenConstant.separator,
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          ColorConstant.primaryColor,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: ColorConstant.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : InkWell(
                onTap: () =>
                    Provider.of<EmailLoginController>(context, listen: false)
                        .showTextFields(),
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
                        color: ColorConstant.secondaryColor,
                      ),
                      DimenConstant.separator,
                      Text(
                        'Continue with Email',
                        style: TextStyle(
                          color: ColorConstant.secondaryColor,
                          fontSize: DimenConstant.subtitleText,
                        ),
                      )
                    ],
                  ),
                ),
              )
      ],
    );
  }
}
