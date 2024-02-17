import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodies/controller/text_input_format_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/lottie_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool startSearching = true, isSearching = false, noResultsFound = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.padding,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: DimenConstant.padding * 1.5,
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
                  hintText: 'Find recipes',
                  hintStyle: TextStyle(
                    color: ColorConstant.primaryColor.withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                  suffix: InkWell(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      startSearching = false;
                      isSearching = true;
                      setState(() {});
                      Timer(
                        Duration(
                          seconds: 3,
                        ),
                        () {
                          isSearching = false;
                          noResultsFound = true;
                          setState(() {});
                        },
                      );
                    },
                    child: Text(
                      'Search',
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                      ),
                    ),
                  ),
                ),
                style: TextStyle(
                  color: ColorConstant.primaryColor,
                ),
                cursorColor: ColorConstant.secondaryColor,
                cursorRadius: Radius.circular(
                  DimenConstant.cursorRadius,
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(40),
                  TextInputFormatController(),
                ],
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                  startSearching = false;
                  isSearching = true;
                  setState(() {});
                  Timer(
                    Duration(
                      seconds: 3,
                    ),
                    () {
                      isSearching = false;
                      noResultsFound = true;
                      setState(() {});
                    },
                  );
                },
              ),
            ),
            DimenConstant.separator,
            if (startSearching)
              Expanded(
                child: Center(
                  child: Text(
                    StringConstant.search,
                    style: TextStyle(
                      color: ColorConstant.secondaryColor,
                      fontSize: DimenConstant.extraSmallText,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else if (isSearching)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(
                    DimenConstant.padding * 2,
                  ),
                  child: Lottie.asset(
                    LottieConstant.searching,
                  ),
                ),
              )
            else if (noResultsFound)
              Column(
                children: [
                  Lottie.asset(
                    LottieConstant.noResults,
                    repeat: false,
                    height: 200,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: Text(
                      StringConstant.noResults,
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                        fontSize: DimenConstant.extraSmallText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            // else
            //   Expanded(
            //     child: ListView.builder(
            //       itemBuilder: (context, index) => RecipeItem(
            //         recipe: Recipes.list[index],
            //         onPressed: () {},
            //       ),
            //       itemCount: Recipes.list.length,
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
