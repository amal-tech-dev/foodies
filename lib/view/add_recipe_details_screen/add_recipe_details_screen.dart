import 'package:flutter/material.dart';
import 'package:foodies/controller/add_recipe_controller.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/add_recipe_details_screen/add_recipe_details_widgets/recipe_details.dart';
import 'package:foodies/view/add_recipe_details_screen/add_recipe_details_widgets/recipe_image.dart';
import 'package:foodies/view/add_recipe_details_screen/add_recipe_details_widgets/recipe_ingredients.dart';
import 'package:foodies/view/add_recipe_details_screen/add_recipe_details_widgets/recipe_steps.dart';
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
  PageController controller = PageController();
  int index = 0;
  RecipeModel model = RecipeModel();
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
    List<Widget> pages = [
      RecipeDetails(),
      RecipeIngredients(),
      RecipeSteps(),
      RecipeImage(),
    ];

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
        actions: [
          Visibility(
            visible: index == pages.length - 1,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Save',
                style: TextStyle(
                  color: ColorConstant.secondary,
                  fontSize: DimenConstant.extraSmall,
                ),
              ),
            ),
          ),
          DimenConstant.separator,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.padding,
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                physics: NeverScrollableScrollPhysics(),
                children: pages,
              ),
            ),
            DimenConstant.separator,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Opacity(
                  opacity: index != 0 ? 1.0 : 0.0,
                  child: IconButton(
                    color: ColorConstant.primary,
                    onPressed: () {
                      if (index != 0) {
                        controller.previousPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.bounceInOut,
                        );
                        if (index > 0) index--;
                        setState(() {});
                      }
                    },
                    icon: Icon(
                      Icons.navigate_before_rounded,
                      color: ColorConstant.tertiary,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        ColorConstant.secondary,
                      ),
                    ),
                  ),
                ),
                SmoothPageIndicator(
                  controller: controller,
                  count: pages.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 5,
                    dotWidth: 5,
                    activeDotColor: ColorConstant.secondary,
                    dotColor: ColorConstant.primary.withOpacity(0.5),
                  ),
                ),
                Opacity(
                  opacity: index != pages.length - 1 ? 1.0 : 0.0,
                  child: IconButton(
                    color: ColorConstant.primary,
                    onPressed: () {
                      if (index != pages.length - 1) {
                        controller.nextPage(
                          duration: Duration(milliseconds: 200),
                          curve: Curves.bounceInOut,
                        );
                        if (index < pages.length - 1) index++;
                        setState(() {});
                      }
                    },
                    icon: Icon(
                      Icons.navigate_next_rounded,
                      color: ColorConstant.tertiary,
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        ColorConstant.secondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
