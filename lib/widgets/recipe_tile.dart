import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class RecipeTile extends StatelessWidget {
  RecipeModel recipe;
  VoidCallback onPressed;

  RecipeTile({
    super.key,
    required this.recipe,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: InkWell(
            onTap: onPressed,
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
        ),
        Positioned(
          left: 20,
          child: InkWell(
            onTap: onPressed,
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
