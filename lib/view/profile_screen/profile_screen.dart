import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/about_screen/about_screen.dart';
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
        padding: const EdgeInsets.all(
          DimenConstant.edgePadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileTile(
                  id: 0,
                  name: 'Guest',
                  imageUrl: '',
                ),
                Visibility(
                  visible: !isGuest,
                  child: DimenConstant.separator,
                ),
                Visibility(
                  visible: !isGuest,
                  child: SettingsTile(
                    name: 'My Recipes',
                    screen: MyRecipesScreen(),
                  ),
                ),
                DimenConstant.separator,
                SettingsTile(
                  name: 'About Categories and Cuisines',
                  screen: AboutScreen(),
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
                        fontSize: DimenConstant.titleText,
                      ),
                    ),
                    content: Text(
                      isGuest
                          ? 'You are logged in as guest. Data cannot be recovered after logging out. Do you want to logout?'
                          : 'Do you want to logout?',
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                        fontSize: DimenConstant.smallText,
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
                            fontSize: DimenConstant.smallText,
                          ),
                        ),
                      ),
                      DimenConstant.separator,
                      InkWell(
                        onTap: () {
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
                            fontSize: DimenConstant.smallText,
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
                  fontSize: DimenConstant.subtitleText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
