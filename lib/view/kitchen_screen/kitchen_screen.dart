import 'package:flutter/material.dart';
import 'package:foodies/database/database.dart';
import 'package:foodies/global_widgets/recipe_item.dart';

class KitchenScreen extends StatelessWidget {
  KitchenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => RecipeItem(
          recipe: Database.recipes[index],
        ),
        itemCount: Database.recipes.length,
      ),
    );
  }
}
