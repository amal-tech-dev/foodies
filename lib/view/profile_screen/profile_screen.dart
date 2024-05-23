import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/user_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/account_settings_screen/account_settings_screen.dart';
import 'package:foodies/view/login_screen/login_screen.dart';
import 'package:foodies/view/my_recipes_screen/my_recipes_screen.dart';
import 'package:foodies/widgets/app_name.dart';
import 'package:foodies/widgets/counter.dart';
import 'package:foodies/widgets/custom_circle_avatar.dart';
import 'package:foodies/widgets/custom_icon.dart';
import 'package:foodies/widgets/custom_text.dart';
import 'package:foodies/widgets/separator.dart';
import 'package:foodies/widgets/settings_tile.dart';
import 'package:hive/hive.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser!;
  bool guest = false;
  UserModel model = UserModel();

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
          guest = event.isAnonymous;
          if (!event.isAnonymous) getUser();
        }
      },
    );
    setState(() {});
  }

  // get user data
  getUser() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection('users').doc(user.uid).get();
    Map<String, dynamic>? data = snapshot.data();
    if (data != null) model = UserModel.fromJson(data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: ColorConstant.primary,
      backgroundColor: ColorConstant.backgroundLight,
      onRefresh: () async => await checkLoginType(),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            guest
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(DimenConstant.padding * 2),
                      child: Row(
                        children: [
                          CustomCircleAvatar(
                            radius:
                                MediaQuery.of(context).size.height / 13 - 20,
                            image: AssetImage(ImageConstant.profile),
                          ),
                          Separator(),
                          CustomText(
                            text: 'Guest Account',
                            size: DimenConstant.large,
                          )
                        ],
                      ),
                    ),
                  )
                : SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DimenConstant.padding * 1.5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Separator(),
                          Row(
                            children: [
                              CustomCircleAvatar(
                                radius:
                                    MediaQuery.of(context).size.height / 13 -
                                        20,
                                image: model.profile == null
                                    ? AssetImage(ImageConstant.profile)
                                    : NetworkImage(model.profile!)
                                        as ImageProvider,
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Counter(
                                      count: model.recipes?.length ?? 0,
                                      header: 'Recipes',
                                    ),
                                    Counter(
                                      count: model.followers?.length ?? 0,
                                      header: 'Followers',
                                    ),
                                    Counter(
                                      count: model.following?.length ?? 0,
                                      header: 'Following',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Separator(),
                          Row(
                            children: [
                              model.username ==
                                      StringConstant.appName.toLowerCase()
                                  ? AppName()
                                  : CustomText(
                                      text: model.name ?? '',
                                      size: DimenConstant.medium,
                                      weight: FontWeight.bold,
                                    ),
                              Separator(width: DimenConstant.padding / 2),
                              CustomIcon(
                                visible: model.verified ?? false,
                                icon: Icons.verified,
                                color: ColorConstant.primary,
                                size: DimenConstant.small,
                              ),
                            ],
                          ),
                          CustomText(
                            text: model.bio ?? '',
                          ),
                        ],
                      ),
                    ),
                  ),
            SliverToBoxAdapter(
              child: Separator(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: DimenConstant.padding),
                child: SettingsTile(
                  visible: !guest,
                  icon: Icons.account_circle_outlined,
                  header: 'Account',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountSettingsScreen(),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Separator(visible: !guest),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: DimenConstant.padding,
                ),
                child: SettingsTile(
                  visible: !guest,
                  icon: Icons.fastfood_outlined,
                  header: 'My Recipes',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyRecipesScreen(),
                    ),
                  ),
                ),
              ),
            ),
            SliverVisibility(
              visible: !guest,
              sliver: SliverToBoxAdapter(
                child: Separator(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: DimenConstant.padding,
                ),
                child: SettingsTile(
                  icon: Icons.timer_outlined,
                  header: 'Timer',
                  onPressed: () {},
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Separator(),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: DimenConstant.padding,
                ),
                child: SettingsTile(
                  icon: Icons.logout_rounded,
                  header: 'Logout',
                  color: ColorConstant.error,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: ColorConstant.backgroundLight,
                        surfaceTintColor: Colors.transparent,
                        title: Text(
                          'Are you leaving?',
                          style: TextStyle(
                            color: ColorConstant.secondaryLight,
                            fontSize: DimenConstant.medium,
                          ),
                        ),
                        content: Text(
                          guest
                              ? StringConstant.logoutAlertGuest
                              : StringConstant.logoutAlert,
                          style: TextStyle(
                            color: ColorConstant.primary,
                            fontSize: DimenConstant.xSmall,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        actions: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: ColorConstant.secondaryLight,
                                fontSize: DimenConstant.xSmall,
                              ),
                            ),
                          ),
                          Separator(),
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
                                    backgroundColor:
                                        ColorConstant.tertiaryLight,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.all(
                                      DimenConstant.padding,
                                    ),
                                    content: Text(
                                      'Unable to logout',
                                      style: TextStyle(
                                        color: ColorConstant.secondaryLight,
                                        fontSize: DimenConstant.xSmall,
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
                                fontSize: DimenConstant.xSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
