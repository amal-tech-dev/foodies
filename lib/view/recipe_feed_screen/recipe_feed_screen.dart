import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/controller/filter_controller.dart';
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
  List<String> favourites = [],
      recipes = [],
      diet = [],
      cuisines = [],
      categories = [];
  bool loading = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    loading = true;
    setState(() {});
    await getRecipes();
    await getDiet();
    await getCuisines();
    await getCategories();
    loading = false;
    setState(() {});
  }

  // get recipe uids from firestore
  getRecipes() async {
    CollectionReference reference = firestore.collection('recipes');
    QuerySnapshot snapshot = await reference.get();
    for (QueryDocumentSnapshot doc in snapshot.docs) recipes.add(doc.id);
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
    User user = FirebaseAuth.instance.currentUser!;
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
                          id: recipes[index],
                          like: recipes.contains(user.uid) ? true : false,
                          favourite: favourites.contains(
                            recipes[index],
                          ),
                          onRecipePressed: () async {
                            DocumentReference reference = firestore
                                .collection('recipes')
                                .doc(recipes[index]);
                            await reference
                                .update({'views': FieldValue.increment(1)});
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeViewScreen(
                                  id: recipes[index],
                                ),
                              ),
                            );
                            fetchData();
                            setState(() {});
                          },
                          onLikePressed: () async {
                            DocumentReference reference = firestore
                                .collection('recipes')
                                .doc(recipes[index]);
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
                            fetchData();
                            setState(() {});
                          },
                          onViewPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => Container(),
                            );
                          },
                          onSharePressed: () {},
                          onFavouritePressed: () {},
                        ),
                  itemCount: loading ? 100 : recipes.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
