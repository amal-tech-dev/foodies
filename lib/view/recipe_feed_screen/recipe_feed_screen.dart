import 'package:flutter/material.dart';
import 'package:foodies/database/database.dart';
import 'package:foodies/global_widgets/recipe_item.dart';
import 'package:foodies/main.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/lottie_constant.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_widgets/filter_bottom_sheet.dart';
import 'package:foodies/view/recipe_view_screen/recipe_view_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeFeedScreen extends StatefulWidget {
  RecipeFeedScreen({super.key});

  @override
  State<RecipeFeedScreen> createState() => _RecipeFeedScreenState();
}

class _RecipeFeedScreenState extends State<RecipeFeedScreen> {
  Diet diet = Diet.semi;
  List preferedCuisines = [];
  List<RecipeModel> preferedRecipes = [];
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    setState(() {});
    getPreference();
    isLoading = false;
    setState(() {});
    super.initState();
  }

  // get data from shared preferences
  getPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    switch (preferences.getString('diet')) {
      case 'veg':
        diet = Diet.veg;
        break;
      case 'non':
        diet = Diet.non;
        break;
      case 'semi':
        diet = Diet.semi;
        break;
      default:
        diet = Diet.semi;
    }
    preferedCuisines =
        preferences.getStringList('cuisines') ?? [Database.cuisines[0]];
    getData();
  }

  // get data with preferences
  getData() {
    List<RecipeModel> allRecipes = Database.recipes;
    List<RecipeModel> vegRecipes = [];
    List<RecipeModel> nonvegRecipes = [];
    for (int i = 0; i < allRecipes.length; i++) {
      if (allRecipes[i].veg) {
        vegRecipes.add(allRecipes[i]);
      } else {
        nonvegRecipes.add(allRecipes[i]);
      }
    }
    switch (diet) {
      case Diet.veg:
        preferedRecipes = vegRecipes;
        break;
      case Diet.non:
        preferedRecipes = nonvegRecipes;
        break;
      case Diet.semi:
        preferedRecipes = allRecipes;
        break;
      default:
        preferedRecipes = allRecipes;
    }
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
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
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
                          preferedRecipes.isNotEmpty
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
                              recipe: preferedRecipes[index],
                              isAddedToKitchen: false,
                              onKitchenPressed: () {},
                            ),
                          ),
                        ),
                        child: RecipeItem(
                          recipe: preferedRecipes[index],
                        ),
                      ),
                      itemCount: preferedRecipes.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
