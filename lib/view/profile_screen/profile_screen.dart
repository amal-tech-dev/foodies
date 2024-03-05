import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/user_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/account_settings_screen/account_settings_screen.dart';
import 'package:foodies/view/login_screen/login_screen.dart';
import 'package:foodies/view/my_recipes_screen/my_recipes_screen.dart';
import 'package:foodies/view/profile_screen/profile_widgets/guest_tile.dart';
import 'package:foodies/view/profile_screen/profile_widgets/profile_tile.dart';
import 'package:foodies/view/user_profile_screen/user_profile_screen.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:hive/hive.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool guest = false;
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
            guest = true;
            userModel = null;
            setState(() {});
          } else {
            guest = false;
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
    return RefreshIndicator(
      color: ColorConstant.secondary,
      backgroundColor: ColorConstant.background,
      onRefresh: () async => await checkLoginType(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            guest
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(
                        DimenConstant.padding,
                      ),
                      child: GuestTile(),
                    ),
                  )
                : SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: DimenConstant.padding,
                        left: DimenConstant.padding,
                        right: DimenConstant.padding,
                      ),
                      child: ProfileTile(
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
                    ),
                  ),
            SliverToBoxAdapter(
              child: DimenConstant.separator,
            ),
            SliverToBoxAdapter(
              child: Visibility(
                visible: !guest,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: DimenConstant.padding,
                  ),
                  child: CustomContainer(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AccountSettingsScreen(),
                      ),
                    ),
                    child: Row(
                      children: [
                        DimenConstant.separator,
                        Icon(
                          Icons.account_circle_outlined,
                          color: ColorConstant.primary,
                        ),
                        DimenConstant.separator,
                        Text(
                          'Account',
                          style: TextStyle(
                            color: ColorConstant.secondary,
                            fontSize: DimenConstant.small,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Visibility(
                visible: !guest,
                child: DimenConstant.separator,
              ),
            ),
            SliverToBoxAdapter(
              child: Visibility(
                visible: !guest,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: DimenConstant.padding,
                  ),
                  child: CustomContainer(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyRecipesScreen(),
                      ),
                    ),
                    child: Row(
                      children: [
                        DimenConstant.separator,
                        Icon(
                          Icons.fastfood_rounded,
                          color: ColorConstant.primary,
                        ),
                        DimenConstant.separator,
                        Text(
                          'My Recipes',
                          style: TextStyle(
                            color: ColorConstant.secondary,
                            fontSize: DimenConstant.small,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Visibility(
                visible: !guest,
                child: DimenConstant.separator,
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: DimenConstant.padding,
                ),
                child: CustomContainer(
                  child: Row(
                    children: [
                      DimenConstant.separator,
                      Icon(
                        Icons.timer_outlined,
                        color: ColorConstant.primary,
                      ),
                      DimenConstant.separator,
                      Text(
                        'Timer',
                        style: TextStyle(
                          color: ColorConstant.secondary,
                          fontSize: DimenConstant.small,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: DimenConstant.separator,
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: DimenConstant.padding,
                ),
                child: CustomContainer(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: ColorConstant.background,
                        surfaceTintColor: Colors.transparent,
                        title: Text(
                          'Are you leaving?',
                          style: TextStyle(
                            color: ColorConstant.primary,
                            fontSize: DimenConstant.small,
                          ),
                        ),
                        content: Text(
                          guest
                              ? StringConstant.logoutAlertGuest
                              : StringConstant.logoutAlert,
                          style: TextStyle(
                            color: ColorConstant.secondary,
                            fontSize: DimenConstant.mini,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        actions: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: ColorConstant.primary,
                                fontSize: DimenConstant.mini,
                              ),
                            ),
                          ),
                          DimenConstant.separator,
                          InkWell(
                            onTap: () async {
                              try {
                                if (guest) {
                                  await auth.currentUser!.delete();
                                  Hive.box<String>('menuBox').close();
                                }
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
                                    backgroundColor: ColorConstant.tertiary,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(
                                      DimenConstant.padding,
                                    ),
                                    content: Text(
                                      'Unable to logout',
                                      style: TextStyle(
                                        color: ColorConstant.primary,
                                        fontSize: DimenConstant.mini,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Leave',
                              style: TextStyle(
                                color: ColorConstant.error,
                                fontSize: DimenConstant.mini,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      DimenConstant.separator,
                      Icon(
                        Icons.logout_rounded,
                        color: ColorConstant.primary,
                      ),
                      DimenConstant.separator,
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: ColorConstant.secondary,
                          fontSize: DimenConstant.small,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
