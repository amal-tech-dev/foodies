import 'package:flutter/material.dart';
import 'package:foodies/generated/assets.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';

class RecipeImage extends StatelessWidget {
  RecipeImage({super.key});

  @override
  Widget build(BuildContext context) {
    List examples = [
      Assets.foodImagesPrawnYellowRice,
      Assets.foodImagesBbqChicken,
      Assets.foodImagesPrawnSalad,
      Assets.foodImagesPrawnSalad,
      Assets.foodImagesVeggieOkonomiyaki,
      Assets.foodImagesPrawnYellowRice,
    ];
    String image = '';
    return Column(
      children: [
        Text(
          'Almost there!',
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.smallText,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: DimenConstant.edgePadding * 3),
          child: Text(
            StringConstant.addImage,
            style: TextStyle(
              color: ColorConstant.secondaryColor,
              fontSize: DimenConstant.miniText,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        DimenConstant.separator,
        Expanded(
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: DimenConstant.edgePadding,
              mainAxisSpacing: DimenConstant.edgePadding,
            ),
            itemBuilder: (context, index) => CircleAvatar(
              backgroundImage: AssetImage(
                examples[index],
              ),
            ),
            itemCount: 6,
          ),
        ),
        Expanded(
          child: CircleAvatar(
            radius: double.infinity,
            backgroundColor: ColorConstant.tertiaryColor,
            foregroundImage: AssetImage(
              image,
            ),
            child: Icon(
              Icons.monochrome_photos_rounded,
              color: ColorConstant.primaryColor,
              size: 150,
            ),
          ),
        ),
      ],
    );
  }
}
