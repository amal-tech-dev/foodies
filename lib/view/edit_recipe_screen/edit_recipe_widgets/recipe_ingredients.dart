import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/controller/add_recipe_controller.dart';
import 'package:foodies/controller/text_input_format_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:provider/provider.dart';

class RecipeIngredients extends StatefulWidget {
  RecipeIngredients({super.key});

  @override
  State<RecipeIngredients> createState() => _RecipeIngredientsState();
}

class _RecipeIngredientsState extends State<RecipeIngredients> {
  List<String> ingredients = [];
  TextEditingController ingredientsController = TextEditingController();

  @override
  void initState() {
    ingredients = Provider.of<AddRecipeController>(context, listen: false)
        .editedRecipe
        .ingredients;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Ingredients',
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.smallText,
          ),
        ),
        Text(
          StringConstant.addIngredients,
          style: TextStyle(
            color: ColorConstant.secondaryColor,
            fontSize: DimenConstant.miniText,
          ),
          textAlign: TextAlign.center,
        ),
        DimenConstant.separator,
        Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.symmetric(
                vertical: DimenConstant.edgePadding * 1.5,
                horizontal: DimenConstant.edgePadding,
              ),
              decoration: BoxDecoration(
                color: ColorConstant.tertiaryColor,
                borderRadius: BorderRadius.circular(
                  DimenConstant.borderRadius,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      ingredients[index],
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                        fontSize: DimenConstant.extraSmallText,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
            separatorBuilder: (context, index) => DimenConstant.separator,
            itemCount: ingredients.length,
          ),
        ),
        DimenConstant.separator,
        TextField(
          controller: ingredientsController,
          decoration: InputDecoration(
            label: Text(
              'Add Ingredients',
              style: TextStyle(
                color: ColorConstant.secondaryColor,
                fontSize: DimenConstant.miniText,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: DimenConstant.edgePadding,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(500),
              borderSide: BorderSide(
                color: ColorConstant.primaryColor,
                width: DimenConstant.borderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(500),
              borderSide: BorderSide(
                color: ColorConstant.secondaryColor,
                width: DimenConstant.borderWidth,
              ),
            ),
            suffix: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                if (ingredientsController.text.isNotEmpty)
                  ingredients.add(ingredientsController.text.trim());
                ingredientsController.clear();
                setState(() {});
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimenConstant.edgePadding,
                ),
                child: Text(
                  'Add',
                  style: TextStyle(
                    color: ColorConstant.secondaryColor,
                    fontSize: DimenConstant.miniText,
                  ),
                ),
              ),
            ),
          ),
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.miniText,
          ),
          cursorColor: ColorConstant.secondaryColor,
          cursorRadius: Radius.circular(
            DimenConstant.cursorRadius,
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(100),
            TextInputFormatController(),
          ],
          textCapitalization: TextCapitalization.sentences,
          onSubmitted: (value) {
            if (ingredientsController.text.isNotEmpty)
              ingredients.add(ingredientsController.text.trim());
            ingredientsController.clear();
            setState(() {});
          },
        ),
        DimenConstant.separator,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              color: ColorConstant.primaryColor,
              onPressed: () =>
                  Provider.of<AddRecipeController>(context, listen: false)
                      .carouselSliderController
                      .previousPage(),
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
            IconButton(
              color: ColorConstant.primaryColor,
              onPressed: () =>
                  Provider.of<AddRecipeController>(context, listen: false)
                      .carouselSliderController
                      .nextPage(),
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
    );
  }
}
