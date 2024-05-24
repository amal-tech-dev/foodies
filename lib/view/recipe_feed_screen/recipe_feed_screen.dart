import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/controller/filter_controller.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/home_screen/home_widgets/filter_item.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/recipe_tile.dart';
import 'package:foodies/widgets/separator.dart';
import 'package:foodies/widgets/shimmer_recipe_tile.dart';
import 'package:provider/provider.dart';

class RecipeFeedScreen extends StatelessWidget {
  RecipeFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FilterController filterController = FilterController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DimenConstant.padding),
        child: Column(
          children: [
            Consumer<FilterController>(
              builder: (context, value, child) => CustomContainer(
                visible: filterController.filters.isNotEmpty,
                height: 35,
                padding: 0,
                color: Colors.transparent,
                child: Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => FilterItem(
                      name: filterController.filters[index],
                      pressed: true,
                      onPressed: () {},
                    ),
                    separatorBuilder: (context, index) => Separator(width: 5),
                    itemCount: value.filters.length,
                  ),
                ),
              ),
            ),
            Separator(visible: filterController.filters.isNotEmpty),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
