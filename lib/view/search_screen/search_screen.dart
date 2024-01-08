import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/database/database.dart';
import 'package:foodies/global_widgets/recipe_item.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/lottie_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/about_screen/about_screen.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool startSearching = true;
  bool isSearching = false;
  bool noResultsFound = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  InkWell(
                    onTap: () {
                      startSearching = false;
                      isSearching = true;
                      setState(() {});
                      Timer(
                          Duration(
                            seconds: 3,
                          ), () {
                        isSearching = false;
                        noResultsFound = true;
                        setState(() {});
                      });
                    },
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            DimenConstant.separator,
            Expanded(
              child: startSearching
                  ? Column(
                      children: [
                        Lottie.asset(
                          LottieConstant.startSearching,
                        ),
                        Text(
                          StringConstant.searchText,
                          style: TextStyle(
                            color: ColorConstant.primaryColor,
                            fontSize: DimenConstant.subtitleText,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    )
                  : isSearching
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Lottie.asset(
                              LottieConstant.searching,
                            ),
                          ),
                        )
                      : noResultsFound
                          ? Column(
                              children: [
                                Lottie.asset(
                                  LottieConstant.noResults,
                                  repeat: false,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                  ),
                                  child: Text(
                                    StringConstant.noResultsText,
                                    style: TextStyle(
                                      color: ColorConstant.primaryColor,
                                      fontSize: DimenConstant.subtitleText,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                  ),
                                  child: InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AboutScreen(),
                                      ),
                                    ),
                                    child: Text(
                                      'About cuisines and categories',
                                      style: TextStyle(
                                        color: ColorConstant.secondaryColor,
                                        fontSize: DimenConstant.subtitleText,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
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
