import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/widgets/custom_container.dart';

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
        backgroundColor: ColorConstant.background,
        surfaceTintColor: Colors.transparent,
        leading: BackButton(
          color: ColorConstant.primary,
        ),
        title: Text(
          'Account Settings',
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Update Email',
                style: TextStyle(
                  color: ColorConstant.primary,
                  fontSize: DimenConstant.large,
                ),
              ),
              DimenConstant.separator,
              CustomContainer(
                paddingTop: 0.0,
                paddingLeft: DimenConstant.padding * 1.5,
                paddingRight: DimenConstant.padding * 1.5,
                paddingBottom: 0.0,
                child: TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    label: Text(
                      'Email',
                      style: TextStyle(
                        color: ColorConstant.secondary,
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: ColorConstant.primary,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: ColorConstant.secondary,
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
              Visibility(
                visible: loading,
                child: CircularProgressIndicator(
                  color: ColorConstant.secondary,
                  strokeCap: StrokeCap.round,
                ),
              ),
              DimenConstant.separator,
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                    ColorConstant.secondary,
                  ),
                ),
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
                        backgroundColor: ColorConstant.tertiary,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(
                          DimenConstant.padding,
                        ),
                        content: Text(
                          StringConstant.emailUpdate,
                          style: TextStyle(
                            color: ColorConstant.primary,
                            fontSize: DimenConstant.mini,
                          ),
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  }
                  loading = true;
                  setState(() {});
                },
                child: Text(
                  'Update',
                  style: TextStyle(
                    color: ColorConstant.tertiary,
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
