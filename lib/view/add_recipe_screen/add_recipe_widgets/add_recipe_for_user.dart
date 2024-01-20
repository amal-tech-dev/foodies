import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/edit_recipe_screen/edit_recipe_screen.dart';

class AddRecipeForUser extends StatelessWidget {
  AddRecipeForUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(
                DimenConstant.edgePadding * 4,
              ),
              child: Image.asset(
                ImageConstant.addRecipeThumbnail,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                DimenConstant.edgePadding,
              ),
              child: Text(
                StringConstant.addRecipeUserText,
                style: TextStyle(
                  color: ColorConstant.primaryColor,
                  fontSize: DimenConstant.smallText,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Column(
          children: [
            ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStatePropertyAll(
                  Size(
                    MediaQuery.of(context).size.width,
                    45,
                  ),
                ),
                backgroundColor: MaterialStatePropertyAll(
                  ColorConstant.secondaryColor,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditRecipeScreen(
                      toAdd: true,
                    ),
                  ),
                );
              },
              child: Text(
                'Add Recipe',
                style: TextStyle(
                  color: ColorConstant.primaryColor,
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
