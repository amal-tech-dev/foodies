import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/recipe_view_screen/recipe_view_screen.dart';
import 'package:foodies/view/user_profile_screen/user_profile_screen.dart';

class RecipeItem extends StatelessWidget {
  RecipeModel recipe;

  RecipeItem({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RecipeViewScreen(),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserProfileScreen(),
                            ),
                          ),
                          child: Text(
                            recipe.shef ?? '',
                            style: TextStyle(
                              color: ColorConstant.secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 150,
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
                          recipe.cuisine,
                          style: TextStyle(
                            color: ColorConstant.primaryColor,
                            fontSize: DimenConstant.smallText,
                          ),
                          maxLines: 2,
                        ),
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
                SizedBox(
                  height: 10,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => Text(
                      recipe.categories[index],
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                        fontSize: DimenConstant.extraSmallText,
                      ),
                    ),
                    separatorBuilder: (context, index) => Text(
                      ' · ',
                      style: TextStyle(
                        color: ColorConstant.primaryColor,
                        fontSize: DimenConstant.extraSmallText,
                      ),
                    ),
                    itemCount: recipe.categories.length,
                  ),
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
