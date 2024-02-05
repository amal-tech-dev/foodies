import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/cooking_screen/cooking_widgets/check_pantry.dart';
import 'package:foodies/view/cooking_screen/cooking_widgets/cooking_preview.dart';
import 'package:foodies/view/cooking_screen/cooking_widgets/serve_recipe.dart';
import 'package:foodies/view/cooking_screen/cooking_widgets/start_cooking.dart';
import 'package:foodies/view/cooking_screen/cooking_widgets/time_preview.dart';

class CookingScreen extends StatefulWidget {
  RecipeModel recipe;
  CookingScreen({
    super.key,
    required this.recipe,
  });

  @override
  State<CookingScreen> createState() => _CookingScreenState();
}

class _CookingScreenState extends State<CookingScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    VoidCallback nextPage = () {
      index++;
      setState(() {});
    };
    List<String> titles = [
      'Let\'s Begin',
      'Prep Time',
      'All Set',
      'Ignite the Stove',
      'Ready to Serve',
    ];
    List<Widget> pages = [
      CookingPreview(
        name: widget.recipe.name,
        image: widget.recipe.image,
        onPressed: nextPage,
      ),
      CheckPantry(
        ingredients: widget.recipe.ingredients,
        onPressed: nextPage,
      ),
      TimePreview(
        time: widget.recipe.time,
        onPressed: nextPage,
      ),
      StartCooking(
        time: widget.recipe.time,
        steps: widget.recipe.steps,
        onPressed: nextPage,
      ),
      ServeRecipe(
        name: widget.recipe.name,
        image: widget.recipe.image,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundColor,
        surfaceTintColor: Colors.transparent,
        leading: BackButton(
          color: ColorConstant.primaryColor,
        ),
        title: Text(
          titles[index],
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.smallText,
          ),
        ),
      ),
      body: pages[index],
    );
  }
}
