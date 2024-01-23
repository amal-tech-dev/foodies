import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/edit_recipe_screen/edit_recipe_widgets/preview_recipe.dart';
import 'package:foodies/view/edit_recipe_screen/edit_recipe_widgets/recipe_details.dart';
import 'package:foodies/view/edit_recipe_screen/edit_recipe_widgets/recipe_image.dart';
import 'package:foodies/view/edit_recipe_screen/edit_recipe_widgets/recipe_ingredients.dart';
import 'package:foodies/view/edit_recipe_screen/edit_recipe_widgets/recipe_steps.dart';
import 'package:foodies/view/edit_recipe_screen/edit_recipe_widgets/save_recipe.dart';

class EditRecipeScreen extends StatefulWidget {
  bool toAdd;
  EditRecipeScreen({
    super.key,
    required this.toAdd,
  });

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  CarouselController carouselController = CarouselController();
  int pageIndex = 0;
  List<Widget> pages = [
    PreviewRecipe(),
    RecipeDetails(),
    RecipeIngredients(),
    RecipeSteps(),
    RecipeImage(),
    SaveRecipe(),
  ];

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
                carouselController: carouselController,
                items: pages,
                options: CarouselOptions(
                  initialPage: pageIndex,
                  height: double.infinity,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: false,
                  scrollPhysics: NeverScrollableScrollPhysics(),
                ),
              ),
            ),
            DimenConstant.separator,
            pageIndex == 0
                ? ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        ColorConstant.secondaryColor,
                      ),
                    ),
                    onPressed: () {
                      carouselController.nextPage();
                      pageIndex++;
                      setState(() {});
                    },
                    child: Text(
                      'Let\'s Start',
                      style: TextStyle(
                        color: ColorConstant.tertiaryColor,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: pageIndex != 1 ? true : false,
                        child: IconButton(
                          color: ColorConstant.primaryColor,
                          onPressed: () {
                            carouselController.previousPage();
                            pageIndex--;
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.navigate_before_rounded,
                            color: ColorConstant.tertiaryColor,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              ColorConstant.secondaryColor,
                            ),
                          ),
                        ),
                      ),
                      pageIndex == pages.length - 1
                          ? ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  ColorConstant.secondaryColor,
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Share with ${StringConstant.appName}',
                                style: TextStyle(
                                  color: ColorConstant.tertiaryColor,
                                ),
                              ),
                            )
                          : IconButton(
                              color: ColorConstant.primaryColor,
                              onPressed: () {
                                carouselController.nextPage();
                                pageIndex++;
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.navigate_next_rounded,
                                color: ColorConstant.tertiaryColor,
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  ColorConstant.secondaryColor,
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
