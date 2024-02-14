import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/controller/filter_controller.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_widgets/filter_bottom_sheet.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_widgets/filter_item.dart';
import 'package:foodies/view/recipe_view_screen/recipe_view_screen.dart';
import 'package:foodies/widgets/recipe_item.dart';
import 'package:foodies/widgets/shimmer_widget.dart';
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
  List<RecipeModel> recipes = [];
  List<String> diet = [], cuisines = [], categories = [];

  @override
  void initState() {
    getDiet();
    getCuisines();
    getCategories();
    setState(() {});
    super.initState();
  }

  // get diet from firestore
  getDiet() async {
    DocumentSnapshot snapshot =
        await firestore.collection('database').doc('diet').get();
    final data = snapshot.data() as Map<String, dynamic>;
    diet = List<String>.from(data['diet']);
  }

  // get cuisine from firestore
  getCuisines() async {
    DocumentSnapshot snapshot =
        await firestore.collection('database').doc('cuisines').get();
    final data = snapshot.data() as Map<String, dynamic>;
    cuisines = List<String>.from(data['cuisines']);
  }

  // get categories from firestore
  getCategories() async {
    DocumentSnapshot snapshot =
        await firestore.collection('database').doc('categories').get();
    final data = snapshot.data() as Map<String, dynamic>;
    categories = List<String>.from(data['categories']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DimenConstant.padding,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 25,
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
                        backgroundColor: ColorConstant.backgroundColor,
                        showDragHandle: true,
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.tune_rounded,
                          color: ColorConstant.primaryColor,
                          size: 18,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Text(
                          'Filters',
                          style: TextStyle(
                            color: ColorConstant.secondaryColor,
                            fontSize: DimenConstant.miniText,
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
              child: StreamBuilder(
                stream: firestore.collection('recipes').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data == null) {
                    return ShimmerWidget();
                  }
                  if (snapshot.connectionState == ConnectionState.active &&
                      snapshot.data != null) {
                    for (var value in snapshot.data!.docs) {
                      recipes.add(
                        RecipeModel.fromJson(value.data()),
                      );
                    }
                  }
                  return ListView.separated(
                    itemBuilder: (context, index) => RecipeItem(
                      recipe: recipes[index],
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeViewScreen(
                            recipe: recipes[index],
                            isAdded: false,
                            onKitchenPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        DimenConstant.separator,
                    itemCount: recipes.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
