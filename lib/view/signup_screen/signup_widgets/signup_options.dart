import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/add_user_details_screen/add_user_details_screen.dart';
import 'package:foodies/widgets/foodies_container.dart';
import 'package:foodies/widgets/foodies_text_field.dart';

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
          FoodiesTextField.singleLineForm(
            context: context,
            label: 'Email',
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
          DimenConstant.separator,
          FoodiesContainer(
            child: TextFormField(
              controller: passwordController,
              focusNode: passwordFocusNode,
              decoration: InputDecoration(
                label: Text(
                  'Password',
                  style: TextStyle(
                    color: ColorConstant.secondary,
                  ),
                ),
                errorStyle: TextStyle(
                  color: ColorConstant.error,
                  fontSize: DimenConstant.nano,
                  fontFamily: StringConstant.font,
                ),
                contentPadding: EdgeInsets.all(0),
                border: InputBorder.none,
                suffix: InkWell(
                  onTap: () {
                    passwordVisible = !passwordVisible;
                    setState(() {});
                  },
                  child: Icon(
                    passwordVisible
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                    color: ColorConstant.primary,
                  ),
                ),
              ),
              style: TextStyle(
                color: ColorConstant.primary,
              ),
              cursorColor: ColorConstant.secondary,
              cursorRadius: Radius.circular(
                DimenConstant.cursorRadius,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              inputFormatters: [
                LengthLimitingTextInputFormatter(40),
              ],
              obscureText: !passwordVisible,
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
          DimenConstant.separator,
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                ColorConstant.secondary,
              ),
            ),
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
                        backgroundColor: ColorConstant.tertiary,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(
                          DimenConstant.padding,
                        ),
                        content: Text(
                          'The password provided is too weak.',
                          style: TextStyle(
                            color: ColorConstant.primary,
                            fontSize: DimenConstant.mini,
                          ),
                        ),
                      ),
                    );
                  } else if (e.code == 'email-already-in-use') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: ColorConstant.tertiary,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(
                          DimenConstant.padding,
                        ),
                        content: Text(
                          'The account already exists for that email.',
                          style: TextStyle(
                            color: ColorConstant.primary,
                            fontSize: DimenConstant.mini,
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
            child: Text(
              'Sign Up',
              style: TextStyle(
                color: ColorConstant.tertiary,
              ),
            ),
          ),
          Visibility(
            visible: loading,
            child: SizedBox(
              height: 100,
              child: Center(
                child: CircularProgressIndicator(
                  color: ColorConstant.secondary,
                  strokeCap: StrokeCap.round,
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
    final emailRegex =
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
