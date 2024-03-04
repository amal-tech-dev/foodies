import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/add_user_details_screen/add_user_details_screen.dart';
import 'package:foodies/view/forget_password_screen/forget_password_screen.dart';
import 'package:foodies/view/get_started_screen/get_started_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

class LoginOptions extends StatefulWidget {
  LoginOptions({super.key});

  @override
  State<LoginOptions> createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  FirebaseAuth auth = FirebaseAuth.instance;
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
              await auth.signInAnonymously();
              await Hive.openBox<String>('menuBox');
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
                  backgroundColor: ColorConstant.tertiary,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(
                    DimenConstant.padding,
                  ),
                  content: Text(
                    'Unable to login',
                    style: TextStyle(
                      color: ColorConstant.primary,
                      fontSize: DimenConstant.mini,
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
              color: ColorConstant.tertiary,
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: ColorConstant.primary,
                ),
                DimenConstant.separator,
                Text(
                  'Continue as Guest',
                  style: TextStyle(
                    color: ColorConstant.primary,
                    fontSize: DimenConstant.extraSmall,
                  ),
                )
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
                await auth.signInWithCredential(credential);
              }
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                CollectionReference reference =
                    FirebaseFirestore.instance.collection('users');
                DocumentSnapshot document = await reference.doc(user.uid).get();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => document.exists
                        ? GetStartedScreen()
                        : AddUserDetailsScreen(),
                  ),
                  (route) => false,
                );
              }
            } on FirebaseAuthException catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: ColorConstant.tertiary,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(
                    DimenConstant.padding,
                  ),
                  content: Text(
                    'Unable to login',
                    style: TextStyle(
                      color: ColorConstant.primary,
                      fontSize: DimenConstant.mini,
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
              color: ColorConstant.tertiary,
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.google,
                  color: ColorConstant.primary,
                ),
                DimenConstant.separator,
                Text(
                  'Continue with Google',
                  style: TextStyle(
                    color: ColorConstant.primary,
                    fontSize: DimenConstant.extraSmall,
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
              color: ColorConstant.tertiary,
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.alternate_email_outlined,
                  color: ColorConstant.primary,
                ),
                DimenConstant.separator,
                Text(
                  'Continue with Email',
                  style: TextStyle(
                    color: ColorConstant.primary,
                    fontSize: DimenConstant.extraSmall,
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
                          color: ColorConstant.secondary,
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
                          color: ColorConstant.secondary,
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
                      color: ColorConstant.secondary,
                    ),
                  ),
                ),
                DimenConstant.separator,
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        ColorConstant.secondary,
                      ),
                    ),
                    onPressed: () async {
                      isLoading = true;
                      setState(() {});
                      try {
                        await auth.signInWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
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
                              backgroundColor: ColorConstant.tertiary,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(
                                DimenConstant.padding,
                              ),
                              content: Text(
                                'Invalid user or password',
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
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: ColorConstant.tertiary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: isLoading,
          child: DimenConstant.separator,
        ),
        Visibility(
          visible: isLoading,
          child: Center(
            child: CircularProgressIndicator(
              color: ColorConstant.secondary,
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
