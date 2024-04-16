import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/add_recipe_details_screen/add_recipe_details_screen.dart';
import 'package:foodies/widgets/custom_button.dart';

class UserContibution extends StatelessWidget {
  UserContibution({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(
                DimenConstant.padding * 4,
              ),
              child: Image.asset(
                ImageConstant.addRecipe,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                DimenConstant.padding,
              ),
              child: Text(
                StringConstant.addRecipeUser,
                style: TextStyle(
                  color: ColorConstant.secondaryDark,
                  fontSize: DimenConstant.extraSmall,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Column(
          children: [
            CustomButton.text(
              text: 'Add Recipe',
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddRecipeDetailsScreen(),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ],
    );
  }
}
