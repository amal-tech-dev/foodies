import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/recipe_tile.dart';
import 'package:foodies/widgets/shimmer_recipe_tile.dart';

class FavouritesScreen extends StatelessWidget {
  FavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User user = FirebaseAuth.instance.currentUser!;
    List<Map<String, RecipeModel>> recipes = [];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(DimenConstant.padding),
        child: StreamBuilder(
          stream: firestore.collection('users').doc(user.uid).snapshots(),
          builder: (context, snapshot) {
            DocumentSnapshot<Map<String, dynamic>>? userData = snapshot.data;
            (userData?.get('favourites') as List).forEach(
              (element) => recipes.add(
                {
                  'id': element,
                  'recipe': RecipeModel.fromJson(
                    firestore.collection('recipes').doc(element).get()
                        as Map<String, dynamic>,
                  ),
                },
              ),
            );
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                itemBuilder: (context, index) => ShimmerRecipeTile(),
                itemCount: 10,
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) => RecipeTile(
                id: userData?.get('favourites')[index] ?? '',
                recipe: RecipeModel(),
              ),
              itemCount: (userData?.get('favourites') as List).length,
            );
          },
        ),
      ),
    );
  }
}
