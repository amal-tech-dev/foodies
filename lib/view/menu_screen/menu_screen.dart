import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/database/recipes.dart';
import 'package:foodies/model/recipe_model.dart';
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
  bool isLoading = false, isEmpty = false, isGuest = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  List<RecipeModel> recipes = [];
  List<String> menu = [];

  @override
  void initState() {
    isLoading = true;
    setState(() {});
    checkLoginType();
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

  // check login type
  checkLoginType() async {
    auth.authStateChanges().listen(
      (event) {
        if (event != null) {
          if (event.isAnonymous)
            isGuest = true;
          else
            isGuest = false;
          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.padding,
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
                            fontSize: DimenConstant.extraSmallText,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemBuilder: (context, index) => RecipeItem(
                      recipe: Recipes.list[index],
                      onPressed: () {},
                    ),
                    itemCount: Recipes.list.length,
                  ),
      ),
    );
  }
}
