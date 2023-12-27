import 'package:flutter/material.dart';
import 'package:foodies/database/database.dart';
import 'package:foodies/global_widgets/recipe_item.dart';
import 'package:foodies/utils/dimen_constant.dart';

class RecipeFeedScreen extends StatelessWidget {
  RecipeFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DimenConstant.edgePadding,
        ),
        child: Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => RecipeItem(
              recipe: Database.recipes[0],
            ),
            separatorBuilder: (context, index) => DimenConstant.separator,
            itemCount: 10,
          ),
        ),
      ),
    );
  }
}
