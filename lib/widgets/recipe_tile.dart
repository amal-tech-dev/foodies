import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/widgets/counter.dart';

class RecipeTile extends StatelessWidget {
  String id;
  RecipeModel recipe;
  bool like, favourite;
  VoidCallback onRecipePressed;
  VoidCallback onLikePressed, onViewPressed, onSharePressed, onFavouritePressed;

  RecipeTile({
    super.key,
    required this.id,
    required this.recipe,
    required this.like,
    required this.favourite,
    required this.onRecipePressed,
    required this.onLikePressed,
    required this.onViewPressed,
    required this.onSharePressed,
    required this.onFavouritePressed,
  });

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User user = FirebaseAuth.instance.currentUser!;
    bool like = false, favourite = false;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: Column(
            children: [
              InkWell(
                onTap: onRecipePressed,
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
                              recipe.name!,
                              style: TextStyle(
                                color: ColorConstant.primary,
                                fontSize: DimenConstant.extraSmall,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              recipe.cuisine!,
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
                        recipe.description!,
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
                        recipe.categories!.join(' · '),
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
                    onTap: onLikePressed,
                    child: Row(
                      children: [
                        Icon(
                          like
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: like
                              ? ColorConstant.error
                              : ColorConstant.primary,
                        ),
                        SizedBox(
                          width: DimenConstant.padding / 2,
                        ),
                        Counter(
                          collection: 'recipes',
                          docId: id,
                          field: 'likes',
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: onViewPressed,
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
                          collection: 'recipes',
                          docId: id,
                          field: 'views',
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: onSharePressed,
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
                          collection: 'recipes',
                          docId: id,
                          field: 'shared',
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: onFavouritePressed,
                    child: Icon(
                      favourite
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      color: favourite
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
            onTap: onRecipePressed,
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
