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

class FavouritesScreen extends StatefulWidget {
  FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  bool empty = false;

  @override
  void initState() {
    Provider.of<LikesController>(context, listen: false).getMenuList();
    if (Provider.of<LikesController>(context, listen: false).recipes.isEmpty)
      empty = true;
    else
      empty = false;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: empty
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
                    StringConstant.noFavourites,
                    style: TextStyle(
                      color: ColorConstant.secondary,
                      fontSize: DimenConstant.extraSmall,
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
                      id: '',
                      recipe: value.recipes[index],
                      like: true,
                      favourite: true,
                      onRecipePressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeViewScreen(
                            id: value.menu[index],
                          ),
                        ),
                      ),
                      onLikePressed: () {},
                      onViewPressed: () {},
                      onSharePressed: () {},
                      onFavouritePressed: () {},
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
