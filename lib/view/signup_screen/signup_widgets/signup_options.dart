import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/add_user_details_screen/add_user_details_screen.dart';
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_text_field.dart';
import 'package:foodies/widgets/loading.dart';
import 'package:foodies/widgets/separator.dart';

class SignupOptions extends StatefulWidget {
  SignupOptions({super.key});

  @override
  State<SignupOptions> createState() => _SignupOptionsState();
}

class _SignupOptionsState extends State<SignupOptions> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool passwordVisible = false, loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField.singleLineForm(
            context: context,
            hint: 'Email',
            controller: emailController,
            limit: 40,
            onSubmit: (value) =>
                FocusScope.of(context).requestFocus(passwordFocusNode),
            validator: (value) {
              if (value!.isEmpty) return 'Please enter your email';
              if (!checkEmail(value)) return 'Please enter a valid email';
              return null;
            },
          ),
          Separator(),
          CustomContainer(
            child: CustomTextField.password(
              context: context,
              controller: passwordController,
              focusNode: passwordFocusNode,
              obscure: passwordVisible,
              onObscureChange: () {
                passwordVisible = !passwordVisible;
                setState(() {});
              },
              onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
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
          Separator(),
          CustomButton.text(
            text: 'Sign Up',
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                loading = true;
                setState(() {});
                try {
                  UserCredential userCredential =
                      await auth.createUserWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                  await userCredential.user!.reload();
                  await auth.signInWithEmailAndPassword(
                    email: emailController.text.trim(),
                    password: passwordController.text.trim(),
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddUserDetailsScreen(),
                    ),
                    (route) => false,
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: ColorConstant.tertiaryDark,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(
                          DimenConstant.padding,
                        ),
                        content: Text(
                          'The password provided is too weak.',
                          style: TextStyle(
                            color: ColorConstant.secondaryDark,
                            fontSize: DimenConstant.xsText,
                          ),
                        ),
                      ),
                    );
                  } else if (e.code == 'email-already-in-use') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: ColorConstant.tertiaryDark,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(
                          DimenConstant.padding,
                        ),
                        content: Text(
                          'The account already exists for that email.',
                          style: TextStyle(
                            color: ColorConstant.secondaryDark,
                            fontSize: DimenConstant.xsText,
                          ),
                        ),
                      ),
                    );
                  }
                } catch (e) {
                  print('Error: $e');
                }
              }
            },
          ),
          Visibility(
            visible: loading,
            child: SizedBox(
              height: 100,
              child: Center(
                child: Loading(
                  visible: loading,
                  size: 50,
                  width: 3,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // simple email validation using a regular expression
  bool checkEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$', caseSensitive: false);
    return emailRegex.hasMatch(email);
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
