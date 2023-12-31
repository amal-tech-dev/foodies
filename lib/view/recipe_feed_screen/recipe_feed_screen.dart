import 'package:flutter/material.dart';
import 'package:foodies/database/database.dart';
import 'package:foodies/global_widgets/recipe_item.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_widgets/filter_bottom_sheet.dart';

class RecipeFeedScreen extends StatelessWidget {
  RecipeFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DimenConstant.edgePadding,
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => FilterBottomSheet(),
                  backgroundColor: ColorConstant.backgroundColor,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(
                  DimenConstant.edgePadding,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.tune_rounded,
                      color: ColorConstant.primaryColor,
                      size: 18,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      'Filters',
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => RecipeItem(
                  recipe: Database.recipes[index],
                ),
                itemCount: Database.recipes.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
