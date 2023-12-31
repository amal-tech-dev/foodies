import 'package:flutter/material.dart';
import 'package:foodies/database/database.dart';
import 'package:foodies/global_widgets/recipe_item.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/search_screen/search_widgets/filter_bottom_sheet.dart';

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
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: ColorConstant.primaryColor,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search_rounded,
                  ),
                  prefixIconColor: ColorConstant.secondaryColor,
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
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => FilterBottomSheet(),
                  backgroundColor: ColorConstant.backgroundColor,
                );
              },
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
