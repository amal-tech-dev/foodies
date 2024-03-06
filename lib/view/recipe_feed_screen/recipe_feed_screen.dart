import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/controller/filter_controller.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_widgets/filter_bottom_sheet.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_widgets/filter_item.dart';
import 'package:foodies/view/recipe_view_screen/recipe_view_screen.dart';
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
  User user = FirebaseAuth.instance.currentUser!;
  Map<String, RecipeModel> recipes = {};
  List<String> likes = [], favourites = [];
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
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
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
              child: StreamBuilder(
                stream: firestore.collection('recipes').snapshots(),
                builder: (context, snapshot) {
                  bool like = false, favourites = false;
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data == null) {
                    return ListView.builder(
                      itemBuilder: (context, index) => ShimmerRecipeTile(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.active &&
                      snapshot.data != null) {
                    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
                        in snapshot.data!.docs) {
                      RecipeModel recipe = RecipeModel.fromJson(doc.data());
                      recipes[doc.id] = recipe;
                      if (recipe.likes!.contains(user.uid))
                        like = true;
                      else
                        like = false;
                    }
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) => RecipeTile(
                      id: recipes.keys.toList()[index],
                      recipe: recipes.values.toList()[index],
                      like: like,
                      favourite: favourites,
                      onRecipePressed: () async {
                        DocumentReference reference = firestore
                            .collection('recipes')
                            .doc(recipes.keys.toList()[index]);
                        await reference
                            .update({'views': FieldValue.increment(1)});
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeViewScreen(
                              id: recipes.keys.toList()[index],
                            ),
                          ),
                        );
                      },
                      onLikePressed: () async {
                        DocumentReference reference = firestore
                            .collection('recipes')
                            .doc(recipes.keys.toList()[index]);
                        DocumentSnapshot snapshot = await reference.get();
                        Map<String, dynamic> data =
                            snapshot.data() as Map<String, dynamic>;
                        List temp = data['likes'];
                        if (temp.contains(user.uid))
                          await reference.update({
                            'likes': FieldValue.arrayRemove([user.uid])
                          });
                        else
                          await reference.update({
                            'likes': FieldValue.arrayUnion([user.uid])
                          });
                      },
                      onViewPressed: () {},
                      onSharePressed: () {},
                      onFavouritePressed: () {},
                    ),
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
