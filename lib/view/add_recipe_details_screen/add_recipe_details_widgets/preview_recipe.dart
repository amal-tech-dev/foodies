import 'package:flutter/material.dart';
import 'package:foodies/controller/add_recipe_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:provider/provider.dart';

class PreviewRecipe extends StatelessWidget {
  PreviewRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Image.asset(
              ImageConstant.chef,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimenConstant.padding * 4,
              ),
              child: Text(
                StringConstant.previewRecipe,
                style: TextStyle(
                  color: ColorConstant.secondary,
                  fontSize: DimenConstant.extraSmall,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        DimenConstant.separator,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              color: ColorConstant.primary,
              onPressed: () =>
                  Provider.of<AddRecipeController>(context, listen: false)
                      .pageViewController
                      .nextPage(),
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
          ],
        ),
      ],
    );
  }
}
