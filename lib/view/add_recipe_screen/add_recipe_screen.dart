import 'package:flutter/material.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/add_recipe_screen/add_recipe_widgets/add_recipe_for_guest.dart';

class AddRecipeScreen extends StatelessWidget {
  AddRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.edgePadding,
        ),
        child: AddRecipeForGuest(),
      ),
    );
  }
}
