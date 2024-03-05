import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/utils/string_constant.dart';
import 'package:foodies/view/cooking_screen/cooking_screen.dart';
import 'package:foodies/view/recipe_view_screen/recipe_view_widgets/details_item.dart';
import 'package:foodies/view/user_profile_screen/user_profile_screen.dart';
import 'package:foodies/widgets/counter.dart';
import 'package:foodies/widgets/custom_container.dart';

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
  String name = '', profile = '';
  bool verified = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  // get recipe data from firestore
  getData() async {
    DocumentReference reference =
        firestore.collection('recipes').doc(widget.id);
    DocumentSnapshot snapshot = await reference.get();
    recipe = RecipeModel.fromJson(snapshot.data() as Map<String, dynamic>);
    getChef();
    setState(() {});
  }

  // get profile of chef
  getChef() async {
    DocumentReference reference =
        firestore.collection('users').doc(recipe.chef);
    DocumentSnapshot snapshot = await reference.get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    name = data['name'] ?? '';
    profile = data['profile'] ?? '';
    verified = data['verified'] ?? false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: ColorConstant.background,
            surfaceTintColor: Colors.transparent,
            floating: true,
            expandedHeight:
                MediaQuery.of(context).size.width - (kToolbarHeight - 20),
            collapsedHeight: kToolbarHeight,
            pinned: true,
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(
                DimenConstant.padding * 2 / 3,
              ),
              child: BackButton(
                color: ColorConstant.primary,
              ),
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
                          ColorConstant.tertiary.withOpacity(0.3),
                          ColorConstant.tertiary.withOpacity(0.2),
                          ColorConstant.tertiary.withOpacity(0.1),
                          ColorConstant.tertiary.withOpacity(0.1),
                          ColorConstant.tertiary.withOpacity(0.2),
                          ColorConstant.tertiary.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                recipe.name ?? '',
                style: TextStyle(
                  color: ColorConstant.primary,
                  fontSize: DimenConstant.extraSmall,
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
                  Counter(
                    collection: 'recipes',
                    docId: widget.id,
                    field: 'likes',
                  ),
                  Counter(
                    collection: 'recipes',
                    docId: widget.id,
                    field: 'views',
                  ),
                  Counter(
                    collection: 'recipes',
                    docId: widget.id,
                    field: 'shared',
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
              child: CustomContainer(
                paddingLeft: DimenConstant.padding * 2.0,
                paddingRight: DimenConstant.padding * 2.0,
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfileScreen(
                      uid: recipe.chef!,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(
                        ImageConstant.profile,
                      ),
                      foregroundImage: profile == ''
                          ? AssetImage(
                              ImageConstant.profile,
                            )
                          : NetworkImage(
                              profile,
                            ) as ImageProvider<Object>,
                    ),
                    DimenConstant.separator,
                    name != 'Foodies'
                        ? Text(
                            name,
                            style: TextStyle(
                              color: ColorConstant.primary,
                              fontSize: DimenConstant.small,
                            ),
                            overflow: TextOverflow.ellipsis,
                          )
                        : Row(
                            children: [
                              Text(
                                StringConstant.appNamePrefix,
                                style: TextStyle(
                                  color: ColorConstant.primary,
                                  fontSize: DimenConstant.small,
                                  fontFamily: StringConstant.font,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                StringConstant.appNameSuffix,
                                style: TextStyle(
                                  color: ColorConstant.secondary,
                                  fontSize: DimenConstant.small,
                                  fontFamily: StringConstant.font,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                    DimenConstant.separator,
                    Visibility(
                      visible: verified,
                      child: Icon(
                        Icons.verified_rounded,
                        color: ColorConstant.secondary,
                      ),
                    )
                  ],
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
                horizontal: DimenConstant.padding,
              ),
              child: Text(
                recipe.description ?? '',
                style: TextStyle(
                  color: ColorConstant.primary,
                  fontSize: DimenConstant.extraSmall,
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
                        ? ColorConstant.vegSecondary
                        : ColorConstant.nonvegSecondary,
                    radius: 10,
                  ),
                  DimenConstant.separator,
                  Text(
                    recipe.veg ?? true ? 'Vegetarian' : 'Non-Vegetarian',
                    style: TextStyle(
                      color: ColorConstant.primary,
                      fontSize: DimenConstant.extraSmall,
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
                  color: ColorConstant.secondary,
                  fontSize: DimenConstant.small,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DetailsItem(
              content: recipe.cuisine ?? '',
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
                  color: ColorConstant.secondary,
                  fontSize: DimenConstant.small,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DetailsItem(
              content: '${recipe.categories?.join(',') ?? []}.',
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
                  color: ColorConstant.secondary,
                  fontSize: DimenConstant.small,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DetailsItem(
              content: recipe.time ?? '',
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
                  color: ColorConstant.secondary,
                  fontSize: DimenConstant.small,
                ),
              ),
            ),
          ),
          SliverList.separated(
            itemBuilder: (context, index) => DetailsItem(
              content: recipe.ingredients?[index] ?? '',
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
                  color: ColorConstant.secondary,
                  fontSize: DimenConstant.small,
                ),
              ),
            ),
          ),
          SliverList.separated(
            itemBuilder: (context, index) => DetailsItem(
              content: recipe.steps?[index] ?? '',
            ),
            separatorBuilder: (context, index) => DimenConstant.separator,
            itemCount: recipe.steps?.length ?? 0,
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorConstant.secondary,
        label: Text(
          'Start Cooking',
          style: TextStyle(
            color: ColorConstant.tertiary,
            fontSize: DimenConstant.mini,
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
      ),
    );
  }
}
