import 'package:flutter/material.dart';
import 'package:foodies/controller/likes_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/lottie_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/recipe_view_screen/recipe_view_screen.dart';
import 'package:foodies/widgets/recipe_tile.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isEmpty = false;

  @override
  void initState() {
    Provider.of<LikesController>(context, listen: false).getMenuList();
    if (Provider.of<LikesController>(context, listen: false).recipes.isEmpty)
      isEmpty = true;
    else
      isEmpty = false;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isEmpty
          ? Column(
              children: [
                Lottie.asset(
                  LottieConstant.empty,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
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
          : Expanded(
              child: Consumer<LikesController>(
                builder: (context, value, child) => Padding(
                  padding: const EdgeInsets.all(
                    DimenConstant.padding,
                  ),
                  child: ListView.separated(
                    itemBuilder: (context, index) => RecipeTile(
                      recipe: value.recipes[index],
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeViewScreen(
                            id: value.menu[index],
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        DimenConstant.separator,
                    itemCount: value.recipes.length,
                  ),
                ),
              ),
            ),
    );
  }
}
