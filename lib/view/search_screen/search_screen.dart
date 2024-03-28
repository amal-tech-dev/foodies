import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/lottie_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_text_field.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool startSearching = true, searching = false, noResultsFound = false;
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
            CustomContainer(
              child: CustomTextField.search(
                context: context,
                hint: 'Find recipes',
                controller: searchController,
                limit: 40,
                onSearchPressed: () {
                  FocusScope.of(context).unfocus();
                  startSearching = false;
                  searching = true;
                  setState(() {});
                  Timer(
                    Duration(
                      seconds: 3,
                    ),
                    () {
                      searching = false;
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
                      color: ColorConstant.secondaryDark,
                      fontSize: DimenConstant.extraSmall,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else if (searching)
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
                        color: ColorConstant.secondaryDark,
                        fontSize: DimenConstant.extraSmall,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
