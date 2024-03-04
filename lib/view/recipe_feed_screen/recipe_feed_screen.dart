import 'package:cloud_firestore/cloud_firestore.dart';
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
  Map<String, RecipeModel> recipes = {};
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
                  String docId = '';
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.data == null) {
                    return ListView.separated(
                      itemBuilder: (context, index) => ShimmerRecipeTile(),
                      separatorBuilder: (context, index) =>
                          DimenConstant.separator,
                      itemCount: 10,
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.active &&
                      snapshot.data != null) {
                    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
                        in snapshot.data!.docs) {
                      docId = doc.id;
                      RecipeModel recipe = RecipeModel.fromJson(doc.data());
                      recipes[docId] = recipe;
                    }
                  }
                  return ListView.separated(
                    itemBuilder: (context, index) => RecipeTile(
                      recipe: recipes.values.toList()[index],
                      onPressed: () async {
                        DocumentReference reference =
                            firestore.collection('recipes').doc(docId);
                        await reference.update({
                          'views': FieldValue.increment(1),
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeViewScreen(
                              id: recipes.keys.toList()[index],
                            ),
                          ),
                        );
                      },
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
