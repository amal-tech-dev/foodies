import 'package:flutter/material.dart';
import 'package:foodies/main.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/add_recipe_screen/add_recipe_screen.dart';
import 'package:foodies/view/bookmarks_screen/bookmarks_screen.dart';
import 'package:foodies/view/profile_screen/profile_screen.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_screen.dart';
import 'package:foodies/view/search_screen/search_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;
  List screens = [
    RecipeFeedScreen(),
    SearchScreen(),
    AddRecipeScreen(),
    BookmarksScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundColor,
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
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              value: Taste.veg,
              icon: Icon(
                Icons.expand_more_rounded,
              ),
              iconEnabledColor: ColorConstant.secondaryColor,
              dropdownColor: ColorConstant.backgroundColor,
              items: [
                DropdownMenuItem(
                  value: Taste.veg,
                  child: Text(
                    'Vegetarian',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.smallText,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: Taste.semi,
                  child: Text(
                    'Semi-Vegetarian',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.smallText,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: Taste.non,
                  child: Text(
                    'Non-Vegetarian',
                    style: TextStyle(
                      color: ColorConstant.primaryColor,
                      fontSize: DimenConstant.smallText,
                    ),
                  ),
                ),
              ],
              onChanged: (value) {},
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: ColorConstant.secondaryColor,
        unselectedItemColor: ColorConstant.primaryColor,
        backgroundColor: ColorConstant.backgroundColor,
        type: BottomNavigationBarType.fixed,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.fastfood_rounded),
            icon: Icon(Icons.fastfood_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.search_rounded),
            icon: Icon(Icons.search_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.add_rounded),
            icon: Icon(Icons.add_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.bookmark_rounded),
            icon: Icon(Icons.bookmark_border_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.person_rounded),
            icon: Icon(Icons.person_outline_rounded),
            label: '',
          ),
        ],
      ),
    );
  }
}
