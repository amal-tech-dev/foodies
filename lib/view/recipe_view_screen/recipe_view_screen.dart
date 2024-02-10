import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/cooking_screen/cooking_screen.dart';
import 'package:foodies/view/user_profile_screen/user_profile_screen.dart';

class RecipeViewScreen extends StatelessWidget {
  RecipeModel recipe;
  bool isAdded;
  VoidCallback onKitchenPressed;
  RecipeViewScreen({
    super.key,
    required this.recipe,
    required this.isAdded,
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
                        fontSize: DimenConstant.extraSmallText,
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
                        isAdded
                            ? Icons.favorite_rounded
                            : Icons.favorite_outline_rounded,
                        color: isAdded
                            ? ColorConstant.secondaryColor
                            : ColorConstant.primaryColor,
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
                      horizontal: DimenConstant.padding,
                    ),
                    child: Text(
                      recipe.description,
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                        fontSize: DimenConstant.extraSmallText,
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
                      horizontal: DimenConstant.padding,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: recipe.veg
                              ? ColorConstant.vegSecondaryGradient
                              : ColorConstant.nonvegSecondaryGradient,
                          radius: 10,
                        ),
                        DimenConstant.separator,
                        Text(
                          recipe.veg ? 'Vegetarian' : 'Non-Vegetarian',
                          style: TextStyle(
                            color: ColorConstant.primaryColor,
                            fontSize: DimenConstant.extraSmallText,
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
                      horizontal: DimenConstant.padding,
                    ),
                    child: Text(
                      'Cuisine',
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                        fontSize: DimenConstant.smallText,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: DimenConstant.extraSmallText / 2,
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
                              fontSize: DimenConstant.extraSmallText,
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
                      horizontal: DimenConstant.padding,
                    ),
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                        fontSize: DimenConstant.smallText,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: DimenConstant.extraSmallText / 2,
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
                              fontSize: DimenConstant.extraSmallText,
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
                      horizontal: DimenConstant.padding,
                    ),
                    child: Text(
                      'Cooking Time',
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                        fontSize: DimenConstant.smallText,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: DimenConstant.extraSmallText / 2,
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
                              fontSize: DimenConstant.extraSmallText,
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
                      horizontal: DimenConstant.padding,
                    ),
                    child: Text(
                      'Ingredients',
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                        fontSize: DimenConstant.smallText,
                      ),
                    ),
                  ),
                ),
                SliverList.separated(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: DimenConstant.extraSmallText / 2,
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
                              fontSize: DimenConstant.extraSmallText,
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
                      horizontal: DimenConstant.padding,
                    ),
                    child: Text(
                      'Steps',
                      style: TextStyle(
                        color: ColorConstant.secondaryColor,
                        fontSize: DimenConstant.smallText,
                      ),
                    ),
                  ),
                ),
                SliverList.separated(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DimenConstant.padding,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: DimenConstant.extraSmallText / 2,
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
                              fontSize: DimenConstant.extraSmallText,
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
              DimenConstant.padding,
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
                  builder: (context) => CookingScreen(
                    recipe: recipe,
                  ),
                ),
              ),
              child: Text(
                'Start Cooking',
                style: TextStyle(
                  color: ColorConstant.tertiaryColor,
                  fontSize: DimenConstant.extraSmallText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
