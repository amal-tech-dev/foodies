import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/add_recipe_screen/add_recipe_screen.dart';
import 'package:foodies/view/kitchen_screen/kitchen_screen.dart';
import 'package:foodies/view/profile_screen/profile_screen.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_screen.dart';
import 'package:foodies/view/search_screen/search_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;
  List screens = [
    RecipeFeedScreen(),
    SearchScreen(),
    AddRecipeScreen(),
    KitchenScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundColor,
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              StringConstant.appNamePartOne,
              style: TextStyle(
                color: ColorConstant.primaryColor,
                fontSize: DimenConstant.titleText,
              ),
            ),
            Text(
              StringConstant.appNamePartTwo,
              style: TextStyle(
                color: ColorConstant.secondaryColor,
                fontSize: DimenConstant.titleText,
              ),
            ),
          ],
        ),
      ),
      body: screens[pageIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: pageIndex,
          selectedItemColor: ColorConstant.secondaryColor,
          unselectedItemColor: ColorConstant.primaryColor,
          selectedFontSize: DimenConstant.smallText,
          unselectedFontSize: DimenConstant.smallText,
          backgroundColor: ColorConstant.backgroundColor,
          type: BottomNavigationBarType.fixed,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          onTap: (value) {
            pageIndex = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: Icon(
                Icons.fastfood_rounded,
              ),
              icon: Icon(Icons.fastfood_outlined),
              label: 'Recipes',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.search_rounded),
              icon: Icon(Icons.search_rounded),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.add_rounded),
              icon: Icon(Icons.add_rounded),
              label: 'Add',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.food_bank_rounded),
              icon: Icon(Icons.food_bank_outlined),
              label: 'Kitchen',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.person_rounded),
              icon: Icon(Icons.person_outline_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
