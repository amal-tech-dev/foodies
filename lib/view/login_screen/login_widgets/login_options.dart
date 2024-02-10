import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/forget_password_screen/forget_password_screen.dart';
import 'package:foodies/view/get_started_screen/get_started_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginOptions extends StatefulWidget {
  LoginOptions({super.key});

  @override
  State<LoginOptions> createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isEmailPressed = false, isPasswordVisible = false, isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          splashColor: Colors.transparent,
          onTap: () async {
            isLoading = true;
            setState(() {});
            try {
              await firebaseAuth.signInAnonymously();
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setBool('loggedin', true);
              preferences.setString('login', 'guest');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => GetStartedScreen(),
                ),
                (route) => false,
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
                    'Unable to login',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.miniText,
                    ),
                  ),
                ),
              );
            }
          },
          child: Container(
            padding: EdgeInsets.all(
              DimenConstant.padding * 1.5,
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
                  color: ColorConstant.primaryColor,
                ),
                DimenConstant.separator,
                Text(
                  'Continue as Guest',
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: DimenConstant.extraSmallText,
                  ),
                )
              ],
            ),
          ),
        ),
        DimenConstant.separator,
        InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            isEmailPressed = !isEmailPressed;
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(
              DimenConstant.padding * 1.5,
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
                  color: ColorConstant.primaryColor,
                ),
                DimenConstant.separator,
                Text(
                  'Continue with Email',
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: DimenConstant.extraSmallText,
                  ),
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: isEmailPressed,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                DimenConstant.separator,
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimenConstant.padding,
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
                    onFieldSubmitted: (value) =>
                        FocusScope.of(context).requestFocus(passwordFocusNode),
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter your email';
                      if (!checkEmail(value))
                        return 'Please enter a valid email';
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimenConstant.padding,
                  ),
                  child: TextFormField(
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    decoration: InputDecoration(
                      label: Text(
                        'Password',
                        style: TextStyle(
                          color: ColorConstant.secondaryColor,
                        ),
                      ),
                      border: InputBorder.none,
                      suffix: InkWell(
                        onTap: () {
                          isPasswordVisible = !isPasswordVisible;
                          setState(() {});
                        },
                        child: Icon(
                          isPasswordVisible
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
                    obscureText: !isPasswordVisible,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    onFieldSubmitted: (value) {},
                    validator: (value) {
                      if (value!.length < 8) return 'Enter a valid password';
                      return null;
                    },
                  ),
                ),
                DimenConstant.separator,
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgetPasswordScreen(),
                    ),
                  ),
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                      color: ColorConstant.secondaryColor,
                    ),
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
                      isLoading = true;
                      setState(() {});
                      try {
                        await firebaseAuth.signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        preferences.setBool('loggedin', true);
                        preferences.setString('login', 'user');
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GetStartedScreen(),
                          ),
                          (route) => false,
                        );
                      } on FirebaseAuthException catch (e) {
                        print(e.code);
                        if (e.code == 'invalid-credential') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: ColorConstant.tertiaryColor,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(
                                DimenConstant.padding,
                              ),
                              content: Text(
                                'Invalid user or password',
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
                      'Sign In',
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
        DimenConstant.separator,
        InkWell(
          onTap: () async {
            isLoading = true;
            setState(() {});
            try {
              GoogleSignIn google = GoogleSignIn();
              GoogleSignInAccount? account = await google.signIn();
              if (account != null) {
                GoogleSignInAuthentication authentication =
                    await account.authentication;
                AuthCredential credential = GoogleAuthProvider.credential(
                  accessToken: authentication.accessToken,
                  idToken: authentication.idToken,
                );
                await firebaseAuth.signInWithCredential(credential);
              }
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.setBool('loggedin', true);
              preferences.setString('login', 'user');
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => GetStartedScreen(),
                ),
                (route) => false,
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
                    'Unable to login',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.miniText,
                    ),
                  ),
                ),
              );
            }
          },
          child: Container(
            padding: EdgeInsets.all(
              DimenConstant.padding * 1.5,
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
                  color: ColorConstant.primaryColor,
                ),
                DimenConstant.separator,
                Text(
                  'Continue with Google',
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: DimenConstant.extraSmallText,
                  ),
                )
              ],
            ),
          ),
        ),
        DimenConstant.separator,
        Visibility(
          visible: isLoading,
          child: Center(
            child: CircularProgressIndicator(
              color: ColorConstant.secondaryColor,
              strokeCap: StrokeCap.round,
            ),
          ),
        )
      ],
    );
  }

  // simple email validation using a regular expression
  bool checkEmail(String email) {
    final emailRegex =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$', caseSensitive: false);
    return emailRegex.hasMatch(email);
  }
}
