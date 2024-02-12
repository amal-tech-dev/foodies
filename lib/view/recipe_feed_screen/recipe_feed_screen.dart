import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/lottie_constant.dart';
import 'package:foodies/view/recipe_feed_screen/recipe_feed_widgets/filter_bottom_sheet.dart';
import 'package:foodies/view/recipe_view_screen/recipe_view_screen.dart';
import 'package:foodies/widgets/recipe_item.dart';
import 'package:lottie/lottie.dart';

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
  bool isLoading = false;

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
      body: isLoading
          ? Center(
              child: Lottie.asset(
                LottieConstant.loading,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimenConstant.padding,
              ),
              child: Column(
                children: [
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
                    child: Padding(
                      padding: const EdgeInsets.all(
                        DimenConstant.padding,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
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
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: firestore.collection('recipes').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Lottie.asset(
                              LottieConstant.loading,
                            ),
                          );
                        }
                        if (snapshot.connectionState ==
                                ConnectionState.active &&
                            snapshot.data != null) {
                          for (var value in snapshot.data!.docs) {
                            recipes.add(
                              RecipeModel.fromJson(value.data()),
                            );
                          }
                        }
                        return ListView.separated(
                          itemBuilder: (context, index) => InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeViewScreen(
                                  recipe: recipes[index],
                                  isAdded: false,
                                  onKitchenPressed: () {},
                                ),
                              ),
                            ),
                            child: RecipeItem(
                              recipe: recipes[index],
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
