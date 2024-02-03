import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/login_screen/login_screen.dart';
import 'package:foodies/view/my_recipes_screen/my_recipes_screen.dart';
import 'package:foodies/view/profile_screen/profile_widgets/profile_tile.dart';
import 'package:foodies/view/profile_screen/profile_widgets/settings_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isGuest = true;

  @override
  void initState() {
    getPrefs();
    super.initState();
  }

// get shared preferences
  getPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('login') == 'user') {
      isGuest = false;
    } else if (preferences.getString('login') == 'guest') {
      isGuest = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DimenConstant.edgePadding * 2,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileTile(
                  username: 'guest_000000',
                  name: 'Guest',
                  image: ImageConstant.profilePicture,
                ),
                DimenConstant.separator,
                Visibility(
                  visible: !isGuest,
                  child: SettingsTile(
                    name: 'My Recipes',
                    screen: MyRecipesScreen(),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: ColorConstant.backgroundColor,
                    surfaceTintColor: Colors.transparent,
                    title: Text(
                      'Are you leaving?',
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                        fontSize: DimenConstant.smallText,
                      ),
                    ),
                    content: Text(
                      isGuest
                          ? StringConstant.logoutAlertGuest
                          : StringConstant.logoutAlert,
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
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
                          SharedPreferences preferences =
                              await SharedPreferences.getInstance();
                          preferences.setBool('loggedin', false);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Text(
                          'Leave',
                          style: TextStyle(
                            color: ColorConstant.secondaryColor,
                            fontSize: DimenConstant.miniText,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Text(
                'Logout',
                style: TextStyle(
                  color: ColorConstant.secondaryColor,
                  fontSize: DimenConstant.extraSmallText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
