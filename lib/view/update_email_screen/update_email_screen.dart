import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/custom_text_field.dart';
import 'package:foodies/widgets/loading.dart';
import 'package:foodies/widgets/separator.dart';

class UpdateEmailScreen extends StatefulWidget {
  UpdateEmailScreen({super.key});

  @override
  State<UpdateEmailScreen> createState() => _UpdateEmailScreenState();
}

class _UpdateEmailScreenState extends State<UpdateEmailScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundLight,
        surfaceTintColor: Colors.transparent,
        leading: CustomButton.back(),
        title: Text(
          'Account Settings',
          style: TextStyle(
            color: ColorConstant.secondaryLight,
            fontSize: DimenConstant.mText,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.padding,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Update Email',
                style: TextStyle(
                  color: ColorConstant.secondaryLight,
                  fontSize: DimenConstant.xlText,
                ),
              ),
              Separator(),
              CustomTextField.singleLineForm(
                context: context,
                hint: 'Email',
                controller: emailController,
                limit: 40,
                onSubmit: (value) => FocusScope.of(context).unfocus(),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter your email';
                  if (!checkEmail(value)) return 'Please enter a valid email';
                  return null;
                },
              ),
              Separator(),
              Loading(
                visible: loading,
                size: 50,
                stroke: 3,
              ),
              Separator(),
              CustomButton.text(
                text: 'Update',
                onPressed: () async {
                  loading = true;
                  setState(() {});
                  if (formKey.currentState!.validate()) {
                    User user = auth.currentUser!;
                    if (user.emailVerified)
                      await user.verifyBeforeUpdateEmail(
                        emailController.text.trim(),
                      );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: ColorConstant.tertiaryLight,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(
                          DimenConstant.padding,
                        ),
                        content: Text(
                          StringConstant.emailUpdate,
                          style: TextStyle(
                            color: ColorConstant.secondaryLight,
                            fontSize: DimenConstant.xsText,
                          ),
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  }
                  loading = true;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
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
