import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';

class CookingPreview extends StatelessWidget {
  String name, image;
  VoidCallback onPressed;
  CookingPreview({
    super.key,
    required this.name,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        DimenConstant.padding,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(image),
            ),
            DimenConstant.separator,
            Text(
              name,
              style: TextStyle(
                color: ColorConstant.primaryColor,
                fontSize: DimenConstant.largeText,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              StringConstant.cookingPreparation,
              style: TextStyle(
                color: ColorConstant.secondaryColor,
                fontSize: DimenConstant.smallText,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  ColorConstant.secondaryColor,
                ),
              ),
              onPressed: onPressed,
              child: Text(
                'Check the Pantry',
                style: TextStyle(
                  color: ColorConstant.tertiaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
