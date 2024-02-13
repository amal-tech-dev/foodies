import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/add_recipe_screen/add_recipe_widgets/add_recipe_for_guest.dart';
import 'package:foodies/view/add_recipe_screen/add_recipe_widgets/add_recipe_for_user.dart';

class AddRecipeScreen extends StatefulWidget {
  AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  bool isGuest = true;
  FirebaseAuth auth = FirebaseAuth.instance;

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
          if (event.isAnonymous)
            isGuest = true;
          else
            isGuest = false;
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.padding,
        ),
        child: isGuest ? AddRecipeForGuest() : AddRecipeForUser(),
      ),
    );
  }
}
