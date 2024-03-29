import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodies/controller/recipe_tile_controller.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/widgets/counter.dart';
import 'package:provider/provider.dart';

class RecipeTile extends StatelessWidget {
  String id;
  RecipeModel recipe;
  RecipeTile({
    super.key,
    required this.id,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    RecipeTileController listeningController =
        Provider.of<RecipeTileController>(context);
    RecipeTileController nonListeningController =
        Provider.of<RecipeTileController>(context, listen: false);

    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: DimenConstant.padding * 5,
            ),
            InkWell(
              onTap: () => nonListeningController.updateViews(context, id),
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
                    DimenConstant.borderRadiusLarge,
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
                              color: ColorConstant.primaryDark,
                              fontSize: DimenConstant.extraSmall,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            recipe.cuisine ?? '',
                            style: TextStyle(
                              color: ColorConstant.primaryDark,
                              fontSize: DimenConstant.mini,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      recipe.about ?? '',
                      style: TextStyle(
                        color: ColorConstant.primaryDark,
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
                        color: ColorConstant.primaryDark,
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
                  onTap: () => nonListeningController.updateLikes(id),
                  child: Row(
                    children: [
                      Icon(
                        listeningController.recipes[id]?.likes
                                    ?.contains(user.uid) ??
                                false
                            ? Icons.favorite_rounded
                            : Icons.favorite_border_rounded,
                        color: listeningController.recipes[id]?.likes
                                    ?.contains(user.uid) ??
                                false
                            ? ColorConstant.error
                            : ColorConstant.primaryDark,
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
                  onTap: () => nonListeningController.showViews(
                      context, id, recipe.views!),
                  child: Row(
                    children: [
                      Icon(
                        Icons.visibility_rounded,
                        color: ColorConstant.primaryDark,
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
                  onTap: () => nonListeningController.updateShared(id),
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.share,
                        color: ColorConstant.primaryDark,
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
                  onTap: () => nonListeningController.updateFavourites(id),
                  child: Icon(
                    listeningController.favourites.contains(id)
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_border_rounded,
                    color: listeningController.favourites.contains(id)
                        ? ColorConstant.secondaryDark
                        : ColorConstant.primaryDark,
                  ),
                ),
              ],
            ),
            DimenConstant.separator,
          ],
        ),
        Positioned(
          left: 20,
          child: InkWell(
            onTap: () => nonListeningController.updateViews(context, id),
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                ImageConstant.food,
              ),
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
