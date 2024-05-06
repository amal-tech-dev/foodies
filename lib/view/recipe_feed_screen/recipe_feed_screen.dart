import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/controller/recipe_tile_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/recipe_tile.dart';
import 'package:foodies/widgets/shimmer_recipe_tile.dart';
import 'package:provider/provider.dart';

class RecipeFeedScreen extends StatefulWidget {
  RecipeFeedScreen({
    super.key,
  });

  @override
  State<RecipeFeedScreen> createState() => _RecipeFeedScreenState();
}

class _RecipeFeedScreenState extends State<RecipeFeedScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<String> diet = [], cuisines = [], categories = [];
  bool loading = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  // fetch data
  fetchData() async {
    Provider.of<RecipeTileController>(context, listen: false).getRecipes();
    Provider.of<RecipeTileController>(context, listen: false).getFavourites();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    RecipeTileController listeningController =
        Provider.of<RecipeTileController>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(DimenConstant.padding),
        child: RefreshIndicator(
          color: ColorConstant.primary,
          backgroundColor: ColorConstant.backgroundDark,
          onRefresh: () => fetchData(),
          child: ListView.builder(
            itemBuilder: (context, index) => loading
                ? ShimmerRecipeTile()
                : RecipeTile(
                    id: listeningController.recipes.keys.toList()[index],
                    recipe: listeningController.recipes.values.toList()[index],
                  ),
            itemCount: loading ? 10 : listeningController.recipes.length,
          ),
        ),
      ),
    );
  }
}
