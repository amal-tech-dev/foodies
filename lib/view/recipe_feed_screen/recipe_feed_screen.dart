import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodies/database/database.dart';
import 'package:foodies/global_widgets/recipe_item.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/lottie_constant.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_widgets/filter_bottom_sheet.dart';
import 'package:foodies/view/recipe_view_screen/recipe_view_screen.dart';
import 'package:lottie/lottie.dart';

class RecipeFeedScreen extends StatefulWidget {
  RecipeFeedScreen({super.key});

  @override
  State<RecipeFeedScreen> createState() => _RecipeFeedScreenState();
}

class _RecipeFeedScreenState extends State<RecipeFeedScreen> {
  List<RecipeModel> recipes = Database.recipes;
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    setState(() {});
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
                          recipes.isNotEmpty
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
                                      '0',
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
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeViewScreen(
                              recipe: recipes[index],
                              isAddedToKitchen: true,
                              onKitchenPressed: () {},
                            ),
                          ),
                        ),
                        child: RecipeItem(
                          recipe: recipes[index],
                        ),
                      ),
                      itemCount: recipes.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
