import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodies/database/database.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/lottie_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/widgets/recipe_item.dart';
import 'package:lottie/lottie.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isLoading = false;
  bool isEmpty = false;

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
        isEmpty = true;
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.edgePadding,
        ),
        child: isLoading
            ? Center(
                child: Lottie.asset(
                  LottieConstant.loading,
                ),
              )
            : isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        LottieConstant.emptyKitchen,
                        repeat: false,
                        height: MediaQuery.of(context).size.width - 100,
                        width: MediaQuery.of(context).size.width - 100,
                        fit: BoxFit.cover,
                      ),
                      DimenConstant.separator,
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                        ),
                        child: Text(
                          StringConstant.emptyMenu,
                          style: TextStyle(
                            color: ColorConstant.secondaryColor,
                            fontSize: DimenConstant.subtitleText,
                          ),
                          textAlign: TextAlign.center,
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
    );
  }
}
