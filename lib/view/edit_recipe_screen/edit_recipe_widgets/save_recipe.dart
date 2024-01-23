import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/lottie_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:lottie/lottie.dart';

class SaveRecipe extends StatelessWidget {
  SaveRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(
          LottieConstant.recipeReady,
          repeat: false,
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
    );
  }
}
