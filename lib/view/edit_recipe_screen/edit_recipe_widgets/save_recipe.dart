import 'package:flutter/material.dart';
import 'package:foodies/controller/add_recipe_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:provider/provider.dart';

class SaveRecipe extends StatelessWidget {
  SaveRecipe({super.key});

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
                horizontal: DimenConstant.edgePadding * 4,
              ),
              child: Text(
                StringConstant.saveRecipe,
                style: TextStyle(
                  color: ColorConstant.secondaryColor,
                  fontSize: DimenConstant.extraSmallText,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        DimenConstant.separator,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              color: ColorConstant.primaryColor,
              onPressed: () =>
                  Provider.of<AddRecipeController>(context, listen: false)
                      .pageViewController
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
            ElevatedButton(
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
          ],
        ),
      ],
    );
  }
}
