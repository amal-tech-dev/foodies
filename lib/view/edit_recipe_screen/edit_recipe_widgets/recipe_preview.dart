import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';

class RecipePreview extends StatelessWidget {
  const RecipePreview({Key? key}) : super(key: key);

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
              fontSize: DimenConstant.subtitleText,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 150,
          child: Center(
            child: CircularProgressIndicator(
              color: ColorConstant.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
