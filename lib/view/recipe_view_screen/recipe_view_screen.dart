import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/cooking_screen/cooking_screen.dart';
import 'package:foodies/view/user_profile_screen/user_profile_screen.dart';

class RecipeViewScreen extends StatelessWidget {
  RecipeModel recipe;
  bool isAddedToKitchen;
  VoidCallback onKitchenPressed;
  RecipeViewScreen({
    super.key,
    required this.recipe,
    required this.isAddedToKitchen,
    required this.onKitchenPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: ColorConstant.backgroundColor,
                  surfaceTintColor: Colors.transparent,
                  floating: true,
                  expandedHeight: 200,
                  collapsedHeight: 56,
                  pinned: true,
                  centerTitle: true,
                  leading: BackButton(
                    color: ColorConstant.primaryColor,
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: Image.asset(
                            recipe.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorConstant.tertiaryColor.withOpacity(0.3),
                                ColorConstant.tertiaryColor.withOpacity(0.3),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      recipe.name,
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                        fontSize: DimenConstant.titleText,
                      ),
                    ),
                  ),
                  actions: [
                    Visibility(
                      visible: recipe.chef == null ? false : true,
                      child: IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfileScreen(),
                          ),
                        ),
                        icon: Icon(
                          Icons.person_rounded,
                          color: ColorConstant.primaryColor,
                        ),
                      ),
                    ),
                    Container(),
                    IconButton(
                      onPressed: onKitchenPressed,
                      icon: Icon(
                        isAddedToKitchen
                            ? Icons.food_bank_rounded
                            : Icons.food_bank_outlined,
                        color: isAddedToKitchen
                            ? ColorConstant.secondaryColor
                            : ColorConstant.primaryColor,
                        size: 30,
                      ),
                    ),
                    DimenConstant.separator,
                  ],
                ),
                SliverToBoxAdapter(
                  child: DimenConstant.separator,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.edgePadding,
                    ),
                    child: Text(
                      recipe.description,
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                        fontSize: DimenConstant.subtitleText,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DimenConstant.separator,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.edgePadding,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: recipe.veg
                              ? ColorConstant.vegColorSecondary
                              : ColorConstant.nonvegColorSecondary,
                          radius: 10,
                        ),
                        DimenConstant.separator,
                        Text(
                          recipe.veg ? 'Vegetarian' : 'Non-Vegetarian',
                          style: TextStyle(
                            color: ColorConstant.primaryColor,
                            fontSize: DimenConstant.subtitleText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DimenConstant.separator,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.edgePadding,
                    ),
                    child: Text(
                      'Cuisine',
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                        fontSize: DimenConstant.titleText,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.edgePadding,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: DimenConstant.subtitleText / 2,
                          ),
                          child: CircleAvatar(
                            backgroundColor: ColorConstant.secondaryColor,
                            radius: 5,
                          ),
                        ),
                        DimenConstant.separator,
                        Expanded(
                          child: Text(
                            recipe.cuisine,
                            style: TextStyle(
                              color: ColorConstant.primaryColor,
                              fontSize: DimenConstant.subtitleText,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DimenConstant.separator,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.edgePadding,
                    ),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                        fontSize: DimenConstant.titleText,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.edgePadding,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: DimenConstant.subtitleText / 2,
                          ),
                          child: CircleAvatar(
                            backgroundColor: ColorConstant.secondaryColor,
                            radius: 5,
                          ),
                        ),
                        DimenConstant.separator,
                        Expanded(
                          child: Text(
                            recipe.categories.join(', ') + '.',
                            style: TextStyle(
                              color: ColorConstant.primaryColor,
                              fontSize: DimenConstant.subtitleText,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DimenConstant.separator,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.edgePadding,
                    ),
                    child: Text(
                      'Cooking Time',
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                        fontSize: DimenConstant.titleText,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.edgePadding,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: DimenConstant.subtitleText / 2,
                          ),
                          child: CircleAvatar(
                            backgroundColor: ColorConstant.secondaryColor,
                            radius: 5,
                          ),
                        ),
                        DimenConstant.separator,
                        Expanded(
                          child: Text(
                            recipe.time,
                            style: TextStyle(
                              color: ColorConstant.primaryColor,
                              fontSize: DimenConstant.subtitleText,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DimenConstant.separator,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.edgePadding,
                    ),
                    child: Text(
                      'Ingredients',
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                        fontSize: DimenConstant.titleText,
                      ),
                    ),
                  ),
                ),
                SliverList.separated(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.edgePadding,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: DimenConstant.subtitleText / 2,
                          ),
                          child: CircleAvatar(
                            backgroundColor: ColorConstant.secondaryColor,
                            radius: 5,
                          ),
                        ),
                        DimenConstant.separator,
                        Expanded(
                          child: Text(
                            recipe.ingredients[index],
                            style: TextStyle(
                              color: ColorConstant.primaryColor,
                              fontSize: DimenConstant.subtitleText,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => DimenConstant.separator,
                  itemCount: recipe.ingredients.length,
                ),
                SliverToBoxAdapter(
                  child: DimenConstant.separator,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.edgePadding,
                    ),
                    child: Text(
                      'Steps',
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                        fontSize: DimenConstant.titleText,
                      ),
                    ),
                  ),
                ),
                SliverList.separated(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.edgePadding,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: DimenConstant.subtitleText / 2,
                          ),
                          child: CircleAvatar(
                            backgroundColor: ColorConstant.secondaryColor,
                            radius: 5,
                          ),
                        ),
                        DimenConstant.separator,
                        Expanded(
                          child: Text(
                            recipe.steps[index],
                            style: TextStyle(
                              color: ColorConstant.primaryColor,
                              fontSize: DimenConstant.subtitleText,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => DimenConstant.separator,
                  itemCount: recipe.steps.length,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              DimenConstant.edgePadding,
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                fixedSize: MaterialStatePropertyAll(
                  Size(
                    MediaQuery.of(context).size.width,
                    45,
                  ),
                ),
                backgroundColor: MaterialStatePropertyAll(
                  ColorConstant.secondaryColor,
                ),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CookingScreen(),
                ),
              ),
              child: Text(
                'Start Cooking',
                style: TextStyle(
                  color: ColorConstant.primaryColor,
                  fontSize: DimenConstant.subtitleText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
