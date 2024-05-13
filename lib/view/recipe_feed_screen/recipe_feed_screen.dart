import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/recipe_tile.dart';
import 'package:foodies/widgets/shimmer_recipe_tile.dart';

class RecipeFeedScreen extends StatelessWidget {
  RecipeFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(DimenConstant.padding),
        child: StreamBuilder(
          stream: firestore.collection('recipes').snapshots(),
          builder: (context, snapshot) {
            QuerySnapshot<Map<String, dynamic>>? recipes = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                itemBuilder: (context, index) => ShimmerRecipeTile(),
                itemCount: 10,
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) => RecipeTile(
                id: recipes?.docs[index].id ?? '',
                recipe: RecipeModel.fromJson(
                  recipes?.docs[index].data() ?? RecipeModel().toJson(),
                ),
              ),
              itemCount: recipes?.docs.length ?? 0,
            );
          },
        ),
      ),
    );
  }
}
