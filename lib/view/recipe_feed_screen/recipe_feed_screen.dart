import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/controller/filter_controller.dart';
import 'package:foodies/controller/recipe_tile_controller.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_widgets/filter_bottom_sheet.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_widgets/filter_item.dart';
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
    await getDiet();
    await getCuisines();
    await getCategories();
    setState(() {});
  }

  // get diet from firestore
  getDiet() async {
    DocumentSnapshot snapshot =
        await firestore.collection('database').doc('diet').get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    diet = List<String>.from(data['diet']);
    setState(() {});
  }

  // get cuisine from firestore
  getCuisines() async {
    DocumentSnapshot snapshot =
        await firestore.collection('database').doc('cuisines').get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    cuisines = List<String>.from(data['cuisines']);
    setState(() {});
  }

  // get categories from firestore
  getCategories() async {
    DocumentSnapshot snapshot =
        await firestore.collection('database').doc('categories').get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    categories = List<String>.from(data['categories']);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    RecipeTileController listeningController =
        Provider.of<RecipeTileController>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DimenConstant.padding,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => FilterItem(
                        name: Provider.of<FilterController>(context)
                            .filters[index],
                        isPressed: true,
                        onPressed: () {
                          Provider.of<FilterController>(
                            context,
                            listen: false,
                          ).removeFilter(
                            Provider.of<FilterController>(
                              context,
                              listen: false,
                            ).filters[index],
                          );
                        },
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 5,
                      ),
                      itemCount:
                          Provider.of<FilterController>(context).filters.length,
                    ),
                  ),
                  DimenConstant.separator,
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => FilterBottomSheet(
                          diet: diet,
                          cuisines: cuisines,
                          categories: categories,
                        ),
                        backgroundColor: ColorConstant.background,
                        showDragHandle: true,
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.tune_rounded,
                          color: ColorConstant.primary,
                          size: 18,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          'Filters',
                          style: TextStyle(
                            color: ColorConstant.secondary,
                            fontSize: DimenConstant.mini,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            DimenConstant.separator,
            Expanded(
              child: RefreshIndicator(
                color: ColorConstant.secondary,
                backgroundColor: ColorConstant.background,
                onRefresh: () => fetchData(),
                child: ListView.builder(
                  itemBuilder: (context, index) => loading
                      ? ShimmerRecipeTile()
                      : RecipeTile(
                          id: listeningController.recipes.keys.toList()[index],
                          recipe: listeningController.recipes.values
                              .toList()[index],
                        ),
                  itemCount: loading ? 100 : listeningController.recipes.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
