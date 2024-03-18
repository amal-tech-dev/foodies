import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/foodies_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorConstant.background,
        surfaceTintColor: Colors.transparent,
        leading: FoodiesWidget.back(),
        title: Text(
          'Reset Password',
          style: TextStyle(
            color: ColorConstant.primary,
            fontSize: DimenConstant.small,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FoodiesWidget.container(
                child: FoodiesWidget.password(
                  context: context,
                  controller: currentPasswordController,
                  obscure: passwordVisible,
                  onObscureChange: () {
                    passwordVisible = !passwordVisible;
                    setState(() {});
                  },
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              DimenConstant.separator,
              FoodiesWidget.container(
                child: FoodiesWidget.singleLineForm(
                  context: context,
                  label: 'New Password',
                  controller: newPasswordController,
                  focusNode: newPasswordFocusNode,
                  limit: 40,
                  onSubmit: (value) => FocusScope.of(context)
                      .requestFocus(confirmPasswordFocusNode),
                  validator: (value) {
                    if (value!.length < 8)
                      return 'Password must be at least 8 characters long';
                    if (!containsUppercase(value))
                      return 'Password must contain at least one uppercase letter';
                    if (!containsLowercase(value))
                      return 'Password must contain at least one lowercase letter';
                    if (!containsNumber(value))
                      return 'Password must contain at least one number';
                    if (!containsSymbol(value))
                      return 'Password must contain at least one symbol (excluding spaces)';
                    return null;
                  },
                ),
              ),
              DimenConstant.separator,
              FoodiesWidget.container(
                child: FoodiesWidget.password(
                  context: context,
                  controller: currentPasswordController,
                  focusNode: confirmPasswordFocusNode,
                  obscure: passwordVisible,
                  onObscureChange: () {
                    passwordVisible = !passwordVisible;
                    setState(() {});
                  },
                  validator: (value) {
                    if (value != newPasswordController.text.trim())
                      return 'Passwords doesn\'t match';
                    return null;
                  },
                ),
              ),
              DimenConstant.separator,
              Center(
                child: FoodiesWidget.text(
                  text: 'Reset',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await auth.confirmPasswordReset(
                        code: '',
                        newPassword: confirmPasswordController.text.trim(),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // check password
  checkPassword() async {
    User user = auth.currentUser!;
    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPasswordController.text.trim(),
    );
    await user.reauthenticateWithCredential(credential);
  }

  // check password contains uppercase letter
  bool containsUppercase(String value) {
    return value.contains(RegExp(r'[A-Z]'));
  }

  // check password contains lowercase letter
  bool containsLowercase(String value) {
    return value.contains(RegExp(r'[a-z]'));
  }

  // check password contains number
  bool containsNumber(String value) {
    return value.contains(RegExp(r'[0-9]'));
  }

  // check password contains symbol except space
  bool containsSymbol(String value) {
    return value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }
}
