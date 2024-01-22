import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';

class PreviewRecipe extends StatelessWidget {
  PreviewRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          ImageConstant.addRecipePreviewThumbnail,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DimenConstant.edgePadding * 4,
          ),
          child: Text(
            StringConstant.addRecipeText,
            style: TextStyle(
              color: ColorConstant.secondaryColor,
              fontSize: DimenConstant.extraSmallText,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
