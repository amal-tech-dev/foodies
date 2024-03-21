import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/login_screen/login_screen.dart';
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_text_field.dart';

class ForgetPasswordOptions extends StatefulWidget {
  ForgetPasswordOptions({super.key});

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
          CustomContainer(
            child: CustomTextField.singleLineForm(
              context: context,
              label: 'Email',
              controller: emailController,
              limit: 40,
              onSubmit: (value) => FocusScope.of(context).unfocus(),
              validator: (value) {
                if (value!.isEmpty) return 'Please enter your email';
                if (!checkEmail(value)) return 'Please enter a valid email';
                return null;
              },
            ),
          ),
          DimenConstant.separator,
          CustomButton.text(
            text: 'Verify',
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                try {
                  await auth.sendPasswordResetEmail(
                      email: emailController.text.trim());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: ColorConstant.tertiary,
                      behavior: SnackBarBehavior.floating,
                      duration: Duration(seconds: 5),
                      margin: EdgeInsets.all(
                        DimenConstant.padding,
                      ),
                      content: Text(
                        'Click on the link sent to your email to reset your password',
                        style: TextStyle(
                          color: ColorConstant.primary,
                          fontSize: DimenConstant.mini,
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
                      backgroundColor: ColorConstant.tertiary,
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.all(
                        DimenConstant.padding,
                      ),
                      content: Text(
                        'Unable to reset password',
                        style: TextStyle(
                          color: ColorConstant.primary,
                          fontSize: DimenConstant.mini,
                        ),
                      ),
                    ),
                  );
                }
              }
            },
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
