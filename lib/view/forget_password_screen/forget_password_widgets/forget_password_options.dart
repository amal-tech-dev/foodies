import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/login_screen/login_screen.dart';

class ForgetPasswordOptions extends StatefulWidget {
  const ForgetPasswordOptions({super.key});

  @override
  State<ForgetPasswordOptions> createState() => _ForgetPasswordOptionsState();
}

class _ForgetPasswordOptionsState extends State<ForgetPasswordOptions> {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: DimenConstant.padding,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.tertiaryColor,
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
            ),
            child: TextFormField(
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              cursorColor: ColorConstant.secondaryColor,
              cursorRadius: Radius.circular(
                DimenConstant.cursorRadius,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
              ],
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
              validator: (value) {
                if (value!.isEmpty) return 'Please enter your email';
                if (!checkEmail(value)) return 'Please enter a valid email';
                return null;
              },
            ),
          ),
          DimenConstant.separator,
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                ColorConstant.secondaryColor,
              ),
            ),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                try {
                  await auth.sendPasswordResetEmail(
                      email: emailController.text.trim());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: ColorConstant.tertiaryColor,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 5),
                      margin: EdgeInsets.all(
                        DimenConstant.padding,
                      ),
                      content: Text(
                        'Click on the link sent to your email to reset your password',
                        style: TextStyle(
                          color: ColorConstant.primaryColor,
                          fontSize: DimenConstant.miniText,
                        ),
                      ),
                    ),
                  );
                  Timer(
                    Duration(seconds: 5),
                    () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (route) => false,
                    ),
                  );
                } on FirebaseAuthException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: ColorConstant.tertiaryColor,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(
                        DimenConstant.padding,
                      ),
                      content: Text(
                        'Unable to reset password',
                        style: TextStyle(
                          color: ColorConstant.primaryColor,
                          fontSize: DimenConstant.miniText,
                        ),
                      ),
                    ),
                  );
                }
              }
            },
            child: Text(
              'Verify',
              style: TextStyle(
                color: ColorConstant.tertiaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // simple email validation using a regular expression
  bool checkEmail(String email) {
    final emailRegex =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$', caseSensitive: false);
    return emailRegex.hasMatch(email);
  }
}
