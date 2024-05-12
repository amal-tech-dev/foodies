import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/add_user_details_screen/add_user_details_screen.dart';
import 'package:foodies/view/forget_password_screen/forget_password_screen.dart';
import 'package:foodies/view/get_started_screen/get_started_screen.dart';
import 'package:foodies/widgets/custom_button.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_text_field.dart';
import 'package:foodies/widgets/loading.dart';
import 'package:foodies/widgets/separator.dart';
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
  bool emailPressed = false, passwordVisible = false, loading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          paddingTop: DimenConstant.padding * 1.5,
          paddingLeft: DimenConstant.padding * 1.5,
          paddingRight: DimenConstant.padding * 1.5,
          paddingBottom: DimenConstant.padding * 1.5,
          onPressed: () async {
            loading = true;
            setState(() {});
            try {
              await auth.signInAnonymously();
              await Hive.openBox<String>(StringConstant.box);
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
                  backgroundColor: ColorConstant.tertiaryLight,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(
                    DimenConstant.padding,
                  ),
                  content: Text(
                    'Unable to login',
                    style: TextStyle(
                      color: ColorConstant.secondaryLight,
                      fontSize: DimenConstant.xsText,
                    ),
                  ),
                ),
              );
            }
          },
          child: Row(
            children: [
              Icon(
                Icons.person,
                color: ColorConstant.secondaryLight,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Continue as Guest',
                    style: TextStyle(
                      color: ColorConstant.secondaryLight,
                      fontSize: DimenConstant.sText,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Separator(),
        CustomContainer(
          paddingTop: DimenConstant.padding * 1.5,
          paddingLeft: DimenConstant.padding * 1.5,
          paddingRight: DimenConstant.padding * 1.5,
          paddingBottom: DimenConstant.padding * 1.5,
          onPressed: () async {
            loading = true;
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
                  backgroundColor: ColorConstant.tertiaryLight,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(
                    DimenConstant.padding,
                  ),
                  content: Text(
                    'Unable to login',
                    style: TextStyle(
                      color: ColorConstant.secondaryLight,
                      fontSize: DimenConstant.xsText,
                    ),
                  ),
                ),
              );
            }
          },
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.google,
                color: ColorConstant.secondaryLight,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Continue with Google',
                    style: TextStyle(
                      color: ColorConstant.secondaryLight,
                      fontSize: DimenConstant.sText,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Separator(),
        CustomContainer(
          paddingTop: DimenConstant.padding * 1.5,
          paddingLeft: DimenConstant.padding * 1.5,
          paddingRight: DimenConstant.padding * 1.5,
          paddingBottom: DimenConstant.padding * 1.5,
          onPressed: () {
            emailPressed = !emailPressed;
            setState(() {});
          },
          child: Row(
            children: [
              Icon(
                Icons.alternate_email_outlined,
                color: ColorConstant.secondaryLight,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    'Continue with Email',
                    style: TextStyle(
                      color: ColorConstant.secondaryLight,
                      fontSize: DimenConstant.sText,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Visibility(
          visible: emailPressed,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Separator(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DimenConstant.padding,
                  ),
                  child: CustomTextField.singleLineForm(
                    context: context,
                    hint: 'Email',
                    controller: emailController,
                    limit: 40,
                    onSubmit: (value) =>
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
                  child: CustomContainer(
                    child: CustomTextField.password(
                      context: context,
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      obscure: passwordVisible,
                      onObscureChange: () {
                        passwordVisible = !passwordVisible;
                        setState(() {});
                      },
                      onFieldSubmitted: (value) =>
                          FocusScope.of(context).unfocus(),
                      validator: (value) {
                        if (value!.length < 8) return 'Enter a valid password';
                        return null;
                      },
                    ),
                  ),
                ),
                Separator(),
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
                      color: ColorConstant.primary,
                    ),
                  ),
                ),
                Separator(),
                Center(
                  child: CustomButton.text(
                    text: 'Sign In',
                    onPressed: () async {
                      loading = true;
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
                              backgroundColor: ColorConstant.tertiaryLight,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.all(
                                DimenConstant.padding,
                              ),
                              content: Text(
                                'Invalid user or password',
                                style: TextStyle(
                                  color: ColorConstant.secondaryLight,
                                  fontSize: DimenConstant.xsText,
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Separator(),
        Loading(
          visible: loading,
          size: 50,
          stroke: 3,
        ),
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
