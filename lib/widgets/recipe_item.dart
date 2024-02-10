import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/user_profile_screen/user_profile_screen.dart';

class RecipeItem extends StatelessWidget {
  RecipeModel recipe;

  RecipeItem({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 50,
          ),
          child: Container(
            padding: EdgeInsets.all(
              DimenConstant.padding,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: recipe.veg
                    ? [
                        ColorConstant.vegPrimaryGradient,
                        ColorConstant.vegSecondaryGradient,
                      ]
                    : [
                        ColorConstant.nonvegPrimaryGradient,
                        ColorConstant.nonvegSecondaryGradient,
                      ],
              ),
              borderRadius: BorderRadius.circular(20),
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
                        recipe.name,
                        style: TextStyle(
                          color: ColorConstant.primaryColor,
                          fontSize: DimenConstant.extraSmallText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        recipe.cuisine,
                        style: TextStyle(
                          color: ColorConstant.primaryColor,
                          fontSize: DimenConstant.miniText,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                Text(
                  recipe.description,
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: DimenConstant.miniText,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
                DimenConstant.separator,
                Text(
                  recipe.categories.join(' · '),
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: DimenConstant.nanoText,
                  ),
                ),
                DimenConstant.separator,
              ],
            ),
          ),
        ),
        Positioned(
          left: 20,
          child: CircleAvatar(
            radius: 50,
            foregroundImage: AssetImage(
              recipe.image,
            ),
          ),
        ),
        Positioned(
          top: 30,
          right: 20,
          child: Visibility(
            visible: recipe.chef == null ? false : true,
            child: Row(
              children: [
                Text(
                  'Recipy By: ',
                  style: TextStyle(
                    color: ColorConstant.primaryColor,
                    fontSize: DimenConstant.miniText,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfileScreen(),
                    ),
                  ),
                  child: Text(
                    recipe.chef ?? '',
                    style: TextStyle(
                      color: ColorConstant.secondaryColor,
                      fontSize: DimenConstant.miniText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
