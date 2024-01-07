import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class RecipeViewScreen extends StatelessWidget {
  RecipeModel recipe;
  bool isAddedToKitchen;
  VoidCallback onKitchenPressed;
  RecipeViewScreen({
    super.key,
    required this.recipe,
    required this.isAddedToKitchen,
    required this.onKitchenPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: ColorConstant.backgroundColor,
            surfaceTintColor: Colors.transparent,
            floating: true,
            expandedHeight: 200,
            collapsedHeight: 56,
            pinned: true,
            leading: BackButton(
              color: ColorConstant.primaryColor,
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: Image.asset(
                      recipe.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          ColorConstant.tertiaryColor.withOpacity(0.3),
                          ColorConstant.tertiaryColor.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                recipe.name,
                style: TextStyle(
                  color: ColorConstant.primaryColor,
                  fontSize: DimenConstant.titleText,
                ),
              ),
            ),
            actions: [
              IconButton(
                onPressed: onKitchenPressed,
                icon: Icon(
                  isAddedToKitchen
                      ? Icons.food_bank_rounded
                      : Icons.food_bank_outlined,
                  color: isAddedToKitchen
                      ? ColorConstant.secondaryColor
                      : ColorConstant.primaryColor,
                  size: 30,
                ),
              ),
              DimenConstant.separator,
            ],
          ),
        ],
      ),
    );
  }
}
