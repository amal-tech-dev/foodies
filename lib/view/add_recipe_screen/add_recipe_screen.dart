import 'package:flutter/material.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/add_recipe_screen/add_recipe_widgets/add_recipe_for_guest.dart';
import 'package:foodies/view/add_recipe_screen/add_recipe_widgets/add_recipe_for_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddRecipeScreen extends StatefulWidget {
  AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
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
        child: isGuest ? AddRecipeForGuest() : AddRecipeForUser(),
      ),
    );
  }
}
