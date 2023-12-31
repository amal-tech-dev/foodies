import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class RecipeItem extends StatelessWidget {
  RecipeModel recipe;

  RecipeItem({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Visibility(
                  visible: recipe.shef == null ? false : true,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 25,
                      bottom: 4,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Recipy By: ',
                          style: TextStyle(
                            color: ColorConstant.primaryColor,
                          ),
                        ),
                        Text(
                          recipe.shef ?? '',
                          style: TextStyle(
                            color: ColorConstant.secondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 135,
                  padding: EdgeInsets.all(
                    DimenConstant.edgePadding,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: recipe.veg
                          ? [
                              ColorConstant.vegColorPrimary,
                              ColorConstant.vegColorSecondary,
                            ]
                          : [
                              ColorConstant.nonvegColorPrimary,
                              ColorConstant.nonvegColorSecondary,
                            ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              DimenConstant.edgePadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DimenConstant.separator,
                    CircleAvatar(
                      radius: 50,
                      foregroundImage: AssetImage(
                        recipe.imageUrl,
                      ),
                    ),
                    DimenConstant.separator,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.name,
                          style: TextStyle(
                            color: ColorConstant.primaryColor,
                            fontSize: DimenConstant.subtitleText,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${recipe.cuisine} · ${recipe.category}",
                          style: TextStyle(
                            color: ColorConstant.primaryColor,
                            fontSize: DimenConstant.extraSmallText,
                          ),
                          maxLines: 2,
                        ),
                        DimenConstant.separator,
                      ],
                    ),
                  ],
                ),
                Text(
                  recipe.description,
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: DimenConstant.smallText,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
                DimenConstant.separator,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
