import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/controller/menu_list_controller.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/cooking_screen/cooking_screen.dart';
import 'package:foodies/view/user_profile_screen/user_profile_screen.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class RecipeViewScreen extends StatefulWidget {
  RecipeModel recipe;
  String recipeId;
  RecipeViewScreen({
    super.key,
    required this.recipe,
    required this.recipeId,
  });

  @override
  State<RecipeViewScreen> createState() => _RecipeViewScreenState();
}

class _RecipeViewScreenState extends State<RecipeViewScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool menuCheck = false;

  @override
  void initState() {
    initialise();
    super.initState();
  }

  // initialise data
  initialise() async {
    menuCheck = await checkRecipeInMenu(widget.recipeId);
    setState(() {});
  }

  // update menu based on authentication status
  Future<void> updateMenu(String docId) async {
    if (auth.currentUser?.isAnonymous ?? false)
      await updateGuestMenu(docId);
    else
      await updateUserMenu(docId);
  }

// check if the recipe exists in menu
  Future<bool> checkRecipeInMenu(String docId) async {
    if (auth.currentUser!.isAnonymous || auth.currentUser == null)
      return await checkGuestMenu(docId);
    else
      return await checkUserMenu(docId);
  }

// update menu for guest
  Future<void> updateGuestMenu(String docId) async {
    Box<String> menuBox = Hive.box<String>('menuBox');
    if (menuBox.containsKey(docId))
      menuBox.delete(docId);
    else
      menuBox.put(docId, docId);
  }

// update menu for user
  Future<void> updateUserMenu(String docId) async {
    String uid = auth.currentUser!.uid;
    DocumentReference reference = firestore.collection('users').doc(uid);
    DocumentSnapshot snapshot = await reference.get();
    List<String> menu = List<String>.from(snapshot.get('menu') ?? []);
    if (menu.contains(docId))
      menu.remove(docId);
    else
      menu.add(docId);
    await reference.update({'menu': menu});
  }

// check recipe for guest
  Future<bool> checkGuestMenu(String docId) async {
    Box<String> box = Hive.box<String>('menuBox');
    return box.containsKey(docId);
  }

// check recipe for user
  Future<bool> checkUserMenu(String docId) async {
    String uid = auth.currentUser!.uid;
    DocumentReference reference = firestore.collection('users').doc(uid);
    DocumentSnapshot snapshot = await reference.get();
    List<String> menu = List<String>.from(snapshot.get('menu') ?? []);
    return menu.contains(docId);
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
                                widget.recipe.image!,
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
                      widget.recipe.name!,
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                        fontSize: DimenConstant.extraSmallText,
                      ),
                    ),
                  ),
                  actions: [
                    Visibility(
                      visible: widget.recipe.chef == null ? false : true,
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
                    IconButton(
                      onPressed: () async {
                        await updateMenu(widget.recipeId);
                        initialise();
                        setState(() {});
                        Provider.of<MenuListController>(
                          context,
                          listen: false,
                        ).getMenuList();
                      },
                      icon: Icon(
                        menuCheck
                            ? Icons.favorite_rounded
                            : Icons.favorite_outline_rounded,
                        color: menuCheck
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
                      widget.recipe.description!,
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
                          backgroundColor: widget.recipe.veg!
                              ? ColorConstant.vegSecondaryGradient
                              : ColorConstant.nonvegSecondaryGradient,
                          radius: 10,
                        ),
                        DimenConstant.separator,
                        Text(
                          widget.recipe.veg! ? 'Vegetarian' : 'Non-Vegetarian',
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
                            widget.recipe.cuisine!,
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
                            widget.recipe.categories!.join(', ') + '.',
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
                            widget.recipe.time!,
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
                            widget.recipe.ingredients![index],
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
                  itemCount: widget.recipe.ingredients!.length,
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
                            widget.recipe.steps![index],
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
                  itemCount: widget.recipe.steps!.length,
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
                    recipe: widget.recipe,
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
