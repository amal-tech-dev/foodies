import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodies/controller/menu_list_controller.dart';
import 'package:foodies/controller/shared_list_controller.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/cooking_screen/cooking_screen.dart';
import 'package:provider/provider.dart';

class RecipeViewScreen extends StatefulWidget {
  String id;
  RecipeViewScreen({
    super.key,
    required this.id,
  });

  @override
  State<RecipeViewScreen> createState() => _RecipeViewScreenState();
}

class _RecipeViewScreenState extends State<RecipeViewScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RecipeModel recipe = RecipeModel();
  int likes = 0, shared = 0;

  @override
  void initState() {
    initialise();
    super.initState();
  }

  // initialise data
  initialise() async {
    DocumentReference reference =
        firestore.collection('recipes').doc(widget.id);
    DocumentSnapshot snapshot = await reference.get();
    recipe = RecipeModel.fromJson(snapshot.data() as Map<String, dynamic>);
    likes = recipe.likes ?? 0;
    shared = recipe.shared ?? 0;
    setState(() {});
    await Provider.of<MenuListController>(
      context,
      listen: false,
    ).checkRecipeInMenu(widget.id);
    await Provider.of<SharedListController>(
      context,
      listen: false,
    ).checkRecipeIsShared(widget.id);
  }

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
                  expandedHeight:
                      MediaQuery.of(context).size.width - kToolbarHeight,
                  collapsedHeight: kToolbarHeight,
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
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                recipe.image ?? '',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                ColorConstant.tertiaryColor.withOpacity(0.3),
                                ColorConstant.tertiaryColor.withOpacity(0.2),
                                ColorConstant.tertiaryColor.withOpacity(0.1),
                                ColorConstant.tertiaryColor.withOpacity(0.0),
                                ColorConstant.tertiaryColor.withOpacity(0.0),
                                ColorConstant.tertiaryColor.withOpacity(0.1),
                                ColorConstant.tertiaryColor.withOpacity(0.3),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    title: Text(
                      recipe.name ?? '',
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                        fontSize: DimenConstant.extraSmallText,
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: DimenConstant.separator,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: DimenConstant.padding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Consumer<MenuListController>(
                          builder: (context, value, child) => InkWell(
                            onTap: () async {
                              await value.updateMenu(widget.id);
                              initialise();
                              setState(() {});
                              value.getMenuList();
                            },
                            child: Column(
                              children: [
                                FaIcon(
                                  value.check
                                      ? FontAwesomeIcons.solidHeart
                                      : FontAwesomeIcons.heart,
                                  color: value.check
                                      ? ColorConstant.errorColor
                                      : ColorConstant.primaryColor,
                                  size: 20,
                                ),
                                StreamBuilder(
                                  stream: firestore
                                      .collection('recipes')
                                      .doc(widget.id)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.active) {
                                      Map<String, dynamic> data = snapshot.data!
                                          .data() as Map<String, dynamic>;
                                      likes = data['likes'];
                                    }
                                    return Text(
                                      '${likes.toString()} Likes',
                                      style: TextStyle(
                                        color: ColorConstant.primaryColor,
                                        fontSize: DimenConstant.miniText,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: recipe.chef != null ? true : false,
                          child: InkWell(
                            onTap: () async {},
                            child: Column(
                              children: [
                                Icon(
                                  Icons.person_rounded,
                                  color: ColorConstant.primaryColor,
                                ),
                                Text(
                                  recipe.chef ?? '',
                                  style: TextStyle(
                                    color: ColorConstant.primaryColor,
                                    fontSize: DimenConstant.miniText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Consumer<SharedListController>(
                          builder: (context, value, child) => InkWell(
                            onTap: () async {
                              await value.updateSharedList(widget.id);
                              await value.shareRecipe(widget.id);
                              initialise();
                              setState(() {});
                            },
                            child: Column(
                              children: [
                                FaIcon(
                                  value.check
                                      ? FontAwesomeIcons.solidShareFromSquare
                                      : FontAwesomeIcons.shareFromSquare,
                                  color: value.check
                                      ? ColorConstant.secondaryColor
                                      : ColorConstant.primaryColor,
                                  size: 20,
                                ),
                                StreamBuilder(
                                  stream: firestore
                                      .collection('recipes')
                                      .doc(widget.id)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.active) {
                                      var data = snapshot.data!.data();
                                      shared = data!['shared'] as int;
                                    }
                                    return Text(
                                      '${shared.toString()} Shared',
                                      style: TextStyle(
                                        color: ColorConstant.primaryColor,
                                        fontSize: DimenConstant.miniText,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
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
                      recipe.description ?? '',
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
                          backgroundColor: recipe.veg ?? true
                              ? ColorConstant.vegSecondaryGradient
                              : ColorConstant.nonvegSecondaryGradient,
                          radius: 10,
                        ),
                        DimenConstant.separator,
                        Text(
                          recipe.veg ?? true ? 'Vegetarian' : 'Non-Vegetarian',
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
                            recipe.cuisine ?? '',
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
                            '${recipe.categories?.join(',') ?? []}.',
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
                            recipe.time ?? '',
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
                            recipe.ingredients?[index] ?? '',
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
                  itemCount: recipe.ingredients?.length ?? 0,
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
                            recipe.steps?[index] ?? '',
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
                  itemCount: recipe.steps?.length ?? 0,
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
