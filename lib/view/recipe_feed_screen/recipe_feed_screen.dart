import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodies/database/database.dart';
import 'package:foodies/global_widgets/recipe_item.dart';
import 'package:foodies/main.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/lottie_constant.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_widgets/filter_bottom_sheet.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeFeedScreen extends StatefulWidget {
  RecipeFeedScreen({super.key});

  @override
  State<RecipeFeedScreen> createState() => _RecipeFeedScreenState();
}

class _RecipeFeedScreenState extends State<RecipeFeedScreen> {
  List<String> selectedCuisines = [];
  late Diet selectedDiet;
  List<String> filteredCuisines = [];
  List<String> filteredCategories = [];
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    setState(() {});
    getPreferences();
    Timer(
      Duration(
        seconds: 3,
      ),
      () {
        isLoading = false;
        setState(() {});
      },
    );
    super.initState();
  }

  // get preferences from shared preferences
  getPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    switch (preferences.getString('diet')) {
      case 'veg':
        selectedDiet = Diet.veg;
        break;
      case 'non':
        selectedDiet = Diet.non;
        break;
      case 'semi':
        selectedDiet = Diet.semi;
        break;
      default:
        selectedDiet = Diet.semi;
    }
    selectedCuisines = preferences.getStringList('cuisines')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: Lottie.asset(
                LottieConstant.loading,
              ),
            )
          : Padding(
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
                          filteredCategories.isEmpty && filteredCuisines.isEmpty
                              ? Icon(
                                  Icons.tune_rounded,
                                  color: ColorConstant.primaryColor,
                                  size: 18,
                                )
                              : Container(
                                  height: 18,
                                  width: 18,
                                  decoration: BoxDecoration(
                                    color: ColorConstant.primaryColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${filteredCategories.length + filteredCuisines.length}',
                                      style: TextStyle(
                                        color: ColorConstant.tertiaryColor,
                                        fontSize: DimenConstant.extraSmallText,
                                      ),
                                    ),
                                  ),
                                ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'Filters',
                            style: TextStyle(
                              color: ColorConstant.secondaryColor,
                              fontSize: DimenConstant.smallText,
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
