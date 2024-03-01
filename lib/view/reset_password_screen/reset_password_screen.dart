import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

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
  bool passwordVisibility = false;
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
          'Reset Password',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
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
                  controller: currentPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    labelStyle: TextStyle(
                      color: ColorConstant.secondaryColor,
                    ),
                    border: InputBorder.none,
                    suffix: InkWell(
                      onTap: () {
                        passwordVisibility = !passwordVisibility;
                        setState(() {});
                      },
                      child: Icon(
                        passwordVisibility
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                  ),
                  cursorColor: ColorConstant.secondaryColor,
                  cursorRadius: Radius.circular(
                    DimenConstant.cursorRadius,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(40),
                  ],
                  obscureText: !passwordVisibility,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  onFieldSubmitted: (value) =>
                      FocusScope.of(context).requestFocus(newPasswordFocusNode),
                  validator: (value) {
                    User user = auth.currentUser!;
                    AuthCredential credential = EmailAuthProvider.credential(
                      email: user.email!,
                      password: currentPasswordController.text.trim(),
                    );
                    return null;
                  },
                ),
              ),
              DimenConstant.separator,
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
                  controller: newPasswordController,
                  focusNode: newPasswordFocusNode,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    labelStyle: TextStyle(
                      color: ColorConstant.secondaryColor,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(40),
                  ],
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  onFieldSubmitted: (value) => FocusScope.of(context)
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
                  controller: currentPasswordController,
                  focusNode: confirmPasswordFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(
                      color: ColorConstant.secondaryColor,
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(40),
                  ],
                  obscureText: true,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                  validator: (value) {
                    if (value != newPasswordController.text.trim())
                      return 'Passwords doesn\'t match';
                    return null;
                  },
                ),
              ),
              DimenConstant.separator,
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      ColorConstant.secondaryColor,
                    ),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await auth.confirmPasswordReset(
                        code: '',
                        newPassword: confirmPasswordController.text.trim(),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      color: ColorConstant.tertiaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
