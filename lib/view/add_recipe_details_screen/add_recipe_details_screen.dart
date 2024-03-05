import 'package:flutter/material.dart';
import 'package:foodies/controller/add_recipe_controller.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/add_recipe_details_screen/add_recipe_details_widgets/preview_recipe.dart';
import 'package:foodies/view/add_recipe_details_screen/add_recipe_details_widgets/recipe_details.dart';
import 'package:foodies/view/add_recipe_details_screen/add_recipe_details_widgets/recipe_image.dart';
import 'package:foodies/view/add_recipe_details_screen/add_recipe_details_widgets/recipe_ingredients.dart';
import 'package:foodies/view/add_recipe_details_screen/add_recipe_details_widgets/recipe_steps.dart';
import 'package:foodies/view/add_recipe_details_screen/add_recipe_details_widgets/save_recipe.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddRecipeDetailsScreen extends StatefulWidget {
  RecipeModel? recipe;

  AddRecipeDetailsScreen({
    super.key,
    this.recipe,
  });

  @override
  State<AddRecipeDetailsScreen> createState() => _AddRecipeDetailsScreenState();
}

class _AddRecipeDetailsScreenState extends State<AddRecipeDetailsScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.recipe != null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          Provider.of<AddRecipeController>(context, listen: false)
              .update(recipe: widget.recipe!);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: ColorConstant.background,
        surfaceTintColor: Colors.transparent,
        leading: BackButton(
          color: ColorConstant.primary,
        ),
        title: Text(
          'Add Recipe',
          style: TextStyle(
            color: ColorConstant.primary,
            fontSize: DimenConstant.small,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.padding,
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller:
                    Provider.of<AddRecipeController>(context, listen: false)
                        .pageViewController
                        .controller,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  PreviewRecipe(),
                  RecipeDetails(),
                  RecipeIngredients(),
                  RecipeSteps(),
                  RecipeImage(),
                  SaveRecipe(),
                ],
              ),
            ),
            DimenConstant.separator,
            SmoothPageIndicator(
              controller:
                  Provider.of<AddRecipeController>(context, listen: false)
                      .pageViewController
                      .controller,
              count: 6,
              effect: ExpandingDotsEffect(
                dotHeight: 5,
                dotWidth: 5,
                activeDotColor: ColorConstant.secondary,
                dotColor: ColorConstant.primary.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
