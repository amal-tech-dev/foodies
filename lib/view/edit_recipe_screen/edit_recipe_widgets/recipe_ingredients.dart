import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/controller/text_input_format_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class RecipeIngredients extends StatefulWidget {
  RecipeIngredients({super.key});

  @override
  State<RecipeIngredients> createState() => _RecipeIngredientsState();
}

class _RecipeIngredientsState extends State<RecipeIngredients> {
  List<String> ingredients = [];
  TextEditingController ingredientsController = TextEditingController();

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
          'Try to add Ingredient name with required quantity.',
          style: TextStyle(
            color: ColorConstant.secondaryColor,
            fontSize: DimenConstant.miniText,
          ),
          textAlign: TextAlign.center,
        ),
        DimenConstant.separator,
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: DimenConstant.extraSmallText / 2,
                  ),
                  child: CircleAvatar(
                    backgroundColor: ColorConstant.secondaryColor,
                    radius: 5,
                  ),
                ),
                DimenConstant.separator,
                Expanded(
                  child: Text(
                    ingredients[index],
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.smallText,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
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
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
              borderSide: BorderSide(
                color: ColorConstant.primaryColor,
                width: DimenConstant.borderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                DimenConstant.borderRadius,
              ),
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
      ],
    );
  }
}
