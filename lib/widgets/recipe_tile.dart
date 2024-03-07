import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/counter.dart';

class RecipeTile extends StatefulWidget {
  String id;
  bool like, favourite;
  VoidCallback onRecipePressed;
  VoidCallback onLikePressed, onViewPressed, onSharePressed, onFavouritePressed;

  RecipeTile({
    super.key,
    required this.id,
    required this.like,
    required this.favourite,
    required this.onRecipePressed,
    required this.onLikePressed,
    required this.onViewPressed,
    required this.onSharePressed,
    required this.onFavouritePressed,
  });

  @override
  State<RecipeTile> createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser!;
  List<String> favourites = [];
  RecipeModel recipe = RecipeModel();

  @override
  void initState() {
    print('object');
    fetchData();
    super.initState();
  }

  fetchData() async {
    await getRecipe();
    await getFavourites();
    setState(() {});
  }

  // get recipe from firestore
  getRecipe() async {
    DocumentReference reference =
        firestore.collection('recipes').doc(widget.id);
    DocumentSnapshot snapshot = await reference.get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    recipe = RecipeModel.fromJson(data);
    setState(() {});
  }

  // get favourites from firestore
  getFavourites() async {
    DocumentSnapshot snapshot =
        await firestore.collection('users').doc(user.uid).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    favourites = List<String>.from(data['favourites']);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: Column(
            children: [
              InkWell(
                onTap: widget.onRecipePressed,
                child: Container(
                  padding: EdgeInsets.all(
                    DimenConstant.padding,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: recipe.veg!
                          ? [
                              ColorConstant.vegPrimary,
                              ColorConstant.vegSecondary,
                            ]
                          : [
                              ColorConstant.nonvegPrimary,
                              ColorConstant.nonvegSecondary,
                            ],
                    ),
                    borderRadius: BorderRadius.circular(
                      DimenConstant.borderRadius * 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 120,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              recipe.name ?? '',
                              style: TextStyle(
                                color: ColorConstant.primary,
                                fontSize: DimenConstant.extraSmall,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              recipe.cuisine ?? '',
                              style: TextStyle(
                                color: ColorConstant.primary,
                                fontSize: DimenConstant.mini,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        recipe.description ?? '',
                        style: TextStyle(
                          color: ColorConstant.primary,
                          fontSize: DimenConstant.mini,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                      ),
                      DimenConstant.separator,
                      Text(
                        (recipe.categories ?? []).join(' · '),
                        style: TextStyle(
                          color: ColorConstant.primary,
                          fontSize: DimenConstant.nano,
                        ),
                      ),
                      DimenConstant.separator,
                    ],
                  ),
                ),
              ),
              DimenConstant.separator,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: widget.onLikePressed,
                    child: Row(
                      children: [
                        Icon(
                          widget.like
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: widget.like
                              ? ColorConstant.error
                              : ColorConstant.primary,
                        ),
                        SizedBox(
                          width: DimenConstant.padding / 2,
                        ),
                        Counter(
                          count: recipe.likes?.length ?? 0,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: widget.onViewPressed,
                    child: Row(
                      children: [
                        Icon(
                          Icons.visibility_rounded,
                          color: ColorConstant.primary,
                        ),
                        SizedBox(
                          width: DimenConstant.padding / 2,
                        ),
                        Counter(
                          count: recipe.views ?? 0,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: widget.onSharePressed,
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.share,
                          color: ColorConstant.primary,
                          size: 18,
                        ),
                        SizedBox(
                          width: DimenConstant.padding / 2,
                        ),
                        Counter(
                          count: recipe.shared ?? 0,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: widget.onFavouritePressed,
                    child: Icon(
                      widget.favourite
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      color: widget.favourite
                          ? ColorConstant.secondary
                          : ColorConstant.primary,
                    ),
                  ),
                ],
              ),
              DimenConstant.separator,
            ],
          ),
        ),
        Positioned(
          left: 20,
          child: InkWell(
            onTap: widget.onRecipePressed,
            child: CircleAvatar(
              radius: 50,
              foregroundImage: NetworkImage(
                recipe.image!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
