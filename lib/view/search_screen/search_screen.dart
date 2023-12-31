import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/database/database.dart';
import 'package:foodies/global_widgets/recipe_item.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.edgePadding,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: DimenConstant.edgePadding * 1.5,
              ),
              decoration: BoxDecoration(
                color: ColorConstant.tertiaryColor,
                borderRadius: BorderRadius.circular(
                  DimenConstant.borderRadius,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      autofocus: true,
                      enableSuggestions: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter,
                      ],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Find recipes',
                        hintStyle: TextStyle(
                          color: ColorConstant.primaryColor.withOpacity(0.5),
                        ),
                      ),
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                      ),
                      cursorColor: ColorConstant.secondaryColor,
                      cursorRadius: Radius.circular(
                        DimenConstant.cursorRadius,
                      ),
                    ),
                  ),
                  DimenConstant.separator,
                  Text(
                    'Search',
                    style: TextStyle(
                      color: ColorConstant.secondaryColor,
                    ),
                  )
                ],
              ),
            ),
            DimenConstant.separator,
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
