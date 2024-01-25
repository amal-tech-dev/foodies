import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodies/controller/add_recipe_controller.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/edit_recipe_screen/edit_recipe_widgets/preview_recipe.dart';
import 'package:foodies/view/edit_recipe_screen/edit_recipe_widgets/recipe_details.dart';
import 'package:foodies/view/edit_recipe_screen/edit_recipe_widgets/recipe_image.dart';
import 'package:foodies/view/edit_recipe_screen/edit_recipe_widgets/recipe_ingredients.dart';
import 'package:foodies/view/edit_recipe_screen/edit_recipe_widgets/recipe_steps.dart';
import 'package:foodies/view/edit_recipe_screen/edit_recipe_widgets/save_recipe.dart';
import 'package:provider/provider.dart';

class EditRecipeScreen extends StatefulWidget {
  bool toAdd;
  RecipeModel? recipe;

  EditRecipeScreen({
    super.key,
    required this.toAdd,
    this.recipe,
  });

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  List<Widget> pages = [
    PreviewRecipe(),
    RecipeDetails(),
    RecipeIngredients(),
    RecipeSteps(),
    RecipeImage(),
    SaveRecipe(),
  ];

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
        backgroundColor: ColorConstant.backgroundColor,
        surfaceTintColor: Colors.transparent,
        leading: BackButton(
          color: ColorConstant.primaryColor,
        ),
        title: Text(
          widget.toAdd ? 'Add Recipe' : 'Edit your Recipe',
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.smallText,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.edgePadding,
        ),
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider(
                carouselController: Provider.of<AddRecipeController>(context)
                    .carouselSliderController
                    .controller,
                items: pages,
                options: CarouselOptions(
                  initialPage: 0,
                  height: double.infinity,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  scrollPhysics: NeverScrollableScrollPhysics(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
