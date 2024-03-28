import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:foodies/controller/filter_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_widgets/filter_item.dart';
import 'package:provider/provider.dart';

class FilterBottomSheet extends StatefulWidget {
  List<String> diet, cuisines, categories;
  FilterBottomSheet({
    super.key,
    required this.diet,
    required this.cuisines,
    required this.categories,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int dietIndex = 0;
  List<int> cuisineIndexes = [0], categoryIndexes = [0];

  @override
  void didChangeDependencies() {
    getFilters();
    setState(() {});
    super.didChangeDependencies();
  }

  // get existing filters
  getFilters() {
    List<String> temp = Provider.of<FilterController>(context).filters;
    for (String value in temp) {
      if (widget.diet.contains(value)) {
        dietIndex = widget.diet.indexOf(value);
      } else if (widget.cuisines.contains(value)) {
        cuisineIndexes.add(widget.cuisines.indexOf(value) + 1);
      } else if (widget.categories.contains(value)) {
        categoryIndexes.add(widget.categories.indexOf(value) + 1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        DimenConstant.padding,
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
                      color: ColorConstant.secondaryDark,
                      fontSize: DimenConstant.extraSmall,
                    ),
                  ),
                  DimenConstant.separator,
                  SizedBox(
                    height: 32.5,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => FilterItem(
                        name: widget.diet[index],
                        isPressed: dietIndex == index ? true : false,
                        onPressed: () {
                          dietIndex = index;
                          setState(() {});
                        },
                      ),
                      separatorBuilder: (context, index) =>
                          DimenConstant.separator,
                      itemCount: widget.diet.length,
                    ),
                  ),
                  DimenConstant.separator,
                  Text(
                    'Cuisines',
                    style: TextStyle(
                      color: ColorConstant.secondaryDark,
                      fontSize: DimenConstant.extraSmall,
                    ),
                  ),
                  DimenConstant.separator,
                  SizedBox(
                    height: 150,
                    child: MasonryGridView.builder(
                      crossAxisSpacing: DimenConstant.padding,
                      mainAxisSpacing: DimenConstant.padding,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                      ),
                      itemBuilder: (context, index) => FilterItem(
                        name: index == 0 ? 'All' : widget.cuisines[index - 1],
                        isPressed:
                            cuisineIndexes.contains(index) ? true : false,
                        onPressed: () {
                          if (index == 0) {
                            if (!cuisineIndexes.contains(index)) {
                              cuisineIndexes = [0];
                            }
                          } else {
                            if (cuisineIndexes.contains(0)) {
                              cuisineIndexes.remove(0);
                            }
                            if (cuisineIndexes.contains(index)) {
                              cuisineIndexes.remove(index);
                            } else {
                              cuisineIndexes.add(index);
                            }
                          }
                          if (cuisineIndexes.isEmpty) {
                            cuisineIndexes = [0];
                          }
                          setState(() {});
                        },
                      ),
                      itemCount: widget.cuisines.length + 1,
                    ),
                  ),
                  DimenConstant.separator,
                  Text(
                    'Categories',
                    style: TextStyle(
                      color: ColorConstant.secondaryDark,
                      fontSize: DimenConstant.extraSmall,
                    ),
                  ),
                  DimenConstant.separator,
                  SizedBox(
                    height: 72,
                    child: MasonryGridView.builder(
                      crossAxisSpacing: DimenConstant.padding,
                      mainAxisSpacing: DimenConstant.padding,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) => FilterItem(
                        name: index == 0 ? 'All' : widget.categories[index - 1],
                        isPressed:
                            categoryIndexes.contains(index) ? true : false,
                        onPressed: () {
                          if (index == 0) {
                            if (!categoryIndexes.contains(index)) {
                              categoryIndexes = [0];
                            }
                          } else {
                            if (categoryIndexes.contains(0)) {
                              categoryIndexes.remove(0);
                            }
                            if (categoryIndexes.contains(index)) {
                              categoryIndexes.remove(index);
                            } else {
                              categoryIndexes.add(index);
                            }
                          }
                          if (categoryIndexes.isEmpty) {
                            categoryIndexes = [0];
                          }
                          setState(() {});
                        },
                      ),
                      itemCount: widget.categories.length + 1,
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
                      ColorConstant.secondaryDark,
                    ),
                  ),
                  onPressed: () {
                    Provider.of<FilterController>(context, listen: false)
                        .resetFilters();
                    dietIndex = 0;
                    cuisineIndexes = [0];
                    categoryIndexes = [0];
                    setState(() {});
                  },
                  child: Text(
                    'Reset',
                    style: TextStyle(
                      color: ColorConstant.tertiaryDark,
                    ),
                  ),
                ),
              ),
              DimenConstant.separator,
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      ColorConstant.secondaryDark,
                    ),
                  ),
                  onPressed: () {
                    List<String> temp = [];
                    if (dietIndex != 0) {
                      temp.add(widget.diet[dietIndex]);
                    }
                    if (cuisineIndexes != [0]) {
                      for (int i in cuisineIndexes) {
                        if (i != 0) temp.add(widget.cuisines[i - 1]);
                      }
                    }
                    if (categoryIndexes != [0]) {
                      for (int i in categoryIndexes) {
                        if (i != 0) temp.add(widget.categories[i - 1]);
                      }
                    }
                    Provider.of<FilterController>(context, listen: false)
                        .setFilters(temp);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: ColorConstant.tertiaryDark,
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
