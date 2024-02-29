import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

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
        backgroundColor: ColorConstant.backgroundColor,
        surfaceTintColor: Colors.transparent,
        leading: BackButton(
          color: ColorConstant.primaryColor,
        ),
        title: Text(
          'Account Settings',
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.smallText,
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
                  color: ColorConstant.primaryColor,
                  fontSize: DimenConstant.largeText,
                ),
              ),
              DimenConstant.separator,
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: DimenConstant.padding * 1.5,
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
                    User user = auth.currentUser!;
                    await user.sendEmailVerification();
                    if (user.emailVerified) {
                      await user.updateEmail(newEmail);
                    }
                    // Navigator.pop(context);
                  }
                },
                child: Text(
                  'Update',
                  style: TextStyle(
                    color: ColorConstant.tertiaryColor,
                  ),
                ),
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
