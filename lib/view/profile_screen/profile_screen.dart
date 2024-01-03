import 'package:flutter/material.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/info_screen/info_screen.dart';
import 'package:foodies/view/my_recipes_screen/my_recipes_screen.dart';
import 'package:foodies/view/profile_screen/profile_widgets/profile_tile.dart';
import 'package:foodies/view/profile_screen/profile_widgets/settings_tile.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.edgePadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileTile(
              id: 0,
              name: 'Guest',
              imageUrl: '',
            ),
            DimenConstant.separator,
            SettingsTile(
              name: 'My Recipes',
              screen: MyRecipesScreen(),
            ),
            DimenConstant.separator,
            SettingsTile(
              name: 'Info',
              screen: InfoScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
