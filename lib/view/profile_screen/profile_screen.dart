import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/user_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/login_screen/login_screen.dart';
import 'package:foodies/view/profile_screen/profile_widgets/guest_tile.dart';
import 'package:foodies/view/profile_screen/profile_widgets/profile_tile.dart';
import 'package:foodies/view/profile_screen/profile_widgets/settings_tile.dart';
import 'package:foodies/view/user_profile_screen/user_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isGuest = false;
  UserModel? userModel;

  @override
  void initState() {
    checkLoginType();
    super.initState();
  }

// check login type
  checkLoginType() async {
    auth.authStateChanges().listen(
      (event) {
        if (event != null) {
          if (event.isAnonymous) {
            isGuest = true;
            userModel = null;
            setState(() {});
          } else {
            isGuest = false;
            getUserdata();
          }
        }
      },
    );
  }

  // get user details
  getUserdata() async {
    DocumentReference reference =
        firestore.collection('users').doc(auth.currentUser!.uid);
    DocumentSnapshot snapshot = await reference.get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    userModel = UserModel.fromJson(data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DimenConstant.padding,
        ),
        child: Column(
          children: [
            isGuest
                ? GuestTile()
                : ProfileTile(
                    name: userModel?.name ?? '',
                    username: userModel?.username ?? '',
                    image: userModel?.profile,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfileScreen(
                          uid: auth.currentUser!.uid,
                        ),
                      ),
                    ),
                  ),
            DimenConstant.separator,
            SettingTile(
              icon: Icons.timer_outlined,
              name: 'Timer',
              onPressed: () {},
            ),
            DimenConstant.separator,
            SettingTile(
              icon: Icons.logout_rounded,
              name: 'Logout',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: ColorConstant.backgroundColor,
                    surfaceTintColor: Colors.transparent,
                    title: Text(
                      'Are you leaving?',
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                        fontSize: DimenConstant.smallText,
                      ),
                    ),
                    content: Text(
                      isGuest
                          ? StringConstant.logoutAlertGuest
                          : StringConstant.logoutAlert,
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                        fontSize: DimenConstant.miniText,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    actions: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: ColorConstant.primaryColor,
                            fontSize: DimenConstant.miniText,
                          ),
                        ),
                      ),
                      DimenConstant.separator,
                      InkWell(
                        onTap: () async {
                          try {
                            await auth.signOut();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
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
                                  'Unable to logout',
                                  style: TextStyle(
                                    color: ColorConstant.primaryColor,
                                    fontSize: DimenConstant.miniText,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Leave',
                          style: TextStyle(
                            color: ColorConstant.errorColor,
                            fontSize: DimenConstant.miniText,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
