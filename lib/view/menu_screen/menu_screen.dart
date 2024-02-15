import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/lottie_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/recipe_view_screen/recipe_view_screen.dart';
import 'package:foodies/widgets/recipe_item.dart';
import 'package:foodies/widgets/shimmer_widget.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<RecipeModel> recipes = [];
  List<String> menu = [];

  @override
  void initState() {
    getMenuList();
    super.initState();
  }

  // get menu list
  getMenuList() async {
    isLoading = true;
    setState(() {});
    if (auth.currentUser!.isAnonymous && auth.currentUser == null) {
      Box<String> menuBox = Hive.box<String>('menuBox');
      menu = menuBox.values.toList();
    } else {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot snapshot =
          await firestore.collection('users').doc(uid).get();
      if (snapshot.exists) {
        menu = List<String>.from(
            (snapshot.data() as Map<String, dynamic>)['menu']);
      }
    }
    for (String docId in menu) {
      DocumentSnapshot snapshot =
          await firestore.collection('recipes').doc(docId).get();
      if (snapshot.exists) {
        recipes
            .add(RecipeModel.fromJson(snapshot.data() as Map<String, dynamic>));
      }
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(
          DimenConstant.padding,
        ),
        child: isLoading
            ? ListView.separated(
                itemBuilder: (context, index) => ShimmerWidget(),
                separatorBuilder: (context, index) => DimenConstant.separator,
                itemCount: 10,
              )
            : recipes.isEmpty
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
                : Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) => RecipeItem(
                        recipe: recipes[index],
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipeViewScreen(
                              recipe: recipes[index],
                              recipeId: menu[index],
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          DimenConstant.separator,
                      itemCount: recipes.length,
                    ),
                  ),
      ),
    );
  }
}
