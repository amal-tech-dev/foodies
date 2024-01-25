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
              ImageConstant.addRecipePreviewThumbnail,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimenConstant.edgePadding * 4,
              ),
              child: Text(
                StringConstant.previewRecipe,
                style: TextStyle(
                  color: ColorConstant.secondaryColor,
                  fontSize: DimenConstant.extraSmallText,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              ColorConstant.secondaryColor,
            ),
          ),
          onPressed: () =>
              Provider.of<AddRecipeController>(context, listen: false)
                  .carouselSliderController
                  .nextPage(),
          child: Text(
            'Let\'s Start',
            style: TextStyle(
              color: ColorConstant.tertiaryColor,
            ),
          ),
        )
      ],
    );
  }
}
