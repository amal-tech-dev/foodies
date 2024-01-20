import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_widgets/filter_item.dart';

class FilterBottomSheet extends StatelessWidget {
  FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        DimenConstant.edgePadding,
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Diet',
                    style: TextStyle(
                      color: ColorConstant.secondaryColor,
                      fontSize: DimenConstant.subtitleText,
                    ),
                  ),
                  DimenConstant.separator,
                  SizedBox(
                    height: 30,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => FilterItem(
                        name: StringConstant.diet[index],
                        isPressed: false,
                        onPressed: () {},
                      ),
                      separatorBuilder: (context, index) =>
                          DimenConstant.separator,
                      itemCount: StringConstant.diet.length,
                    ),
                  ),
                  DimenConstant.separator,
                  Text(
                    'Cuisines',
                    style: TextStyle(
                      color: ColorConstant.secondaryColor,
                      fontSize: DimenConstant.subtitleText,
                    ),
                  ),
                  DimenConstant.separator,
                  SizedBox(
                    height: 190,
                    child: MasonryGridView.builder(
                      crossAxisSpacing: DimenConstant.edgePadding,
                      mainAxisSpacing: DimenConstant.edgePadding,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                      ),
                      itemBuilder: (context, index) => FilterItem(
                        name: StringConstant.cuisines[index],
                        isPressed: false,
                        onPressed: () {},
                      ),
                      itemCount: StringConstant.cuisines.length,
                    ),
                  ),
                  DimenConstant.separator,
                  Text(
                    'Categories',
                    style: TextStyle(
                      color: ColorConstant.secondaryColor,
                      fontSize: DimenConstant.subtitleText,
                    ),
                  ),
                  DimenConstant.separator,
                  SizedBox(
                    height: 72,
                    child: MasonryGridView.builder(
                      crossAxisSpacing: DimenConstant.edgePadding,
                      mainAxisSpacing: DimenConstant.edgePadding,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) => FilterItem(
                        name: StringConstant.categories[index],
                        isPressed: false,
                        onPressed: () {},
                      ),
                      itemCount: StringConstant.categories.length,
                    ),
                  ),
                ],
              ),
            ),
          ),
          DimenConstant.separator,
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      ColorConstant.secondaryColor,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                ),
              ),
              DimenConstant.separator,
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      ColorConstant.secondaryColor,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
