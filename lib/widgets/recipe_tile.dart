import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodies/controller/recipe_tile_controller.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';
import 'package:foodies/widgets/counter.dart';
import 'package:foodies/widgets/custom_circle_avatar.dart';
import 'package:foodies/widgets/custom_container.dart';
import 'package:foodies/widgets/custom_icon.dart';
import 'package:foodies/widgets/custom_text.dart';
import 'package:foodies/widgets/separator.dart';
import 'package:provider/provider.dart';

class RecipeTile extends StatefulWidget {
  String id;
  RecipeModel recipe;

  RecipeTile({
    super.key,
    required this.id,
    required this.recipe,
  });

  @override
  State<RecipeTile> createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  User user = FirebaseAuth.instance.currentUser!;
  RecipeTileController controller = RecipeTileController();

  @override
  void initState() {
    controller.getRecipes();
    controller.getFavourites();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeTileController>(
      builder: (context, value, child) => Stack(
        children: [
          Column(
            children: [
              Separator(height: DimenConstant.padding * 5),
              CustomContainer(
                width: double.infinity,
                borderRadius: DimenConstant.borderRadiusLarge,
                gradients: widget.recipe.veg ?? true
                    ? [
                        ColorConstant.vegSecondary,
                        ColorConstant.vegPrimary,
                      ]
                    : [
                        ColorConstant.nonVegSecondary,
                        ColorConstant.nonVegPrimary,
                      ],
                onPressed: () => value.updateViews(context, widget.id),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: widget.recipe.name ?? '',
                            color: ColorConstant.secondaryDark,
                            lines: 1,
                          ),
                          CustomText(
                            text: widget.recipe.cuisine ?? '',
                            color: ColorConstant.secondaryDark,
                            size: DimenConstant.xsText,
                            lines: 2,
                          ),
                        ],
                      ),
                    ),
                    CustomText(
                      text: widget.recipe.about ?? '',
                      color: ColorConstant.secondaryDark,
                      size: DimenConstant.xsText,
                      lines: 3,
                      align: TextAlign.justify,
                    ),
                    Separator(),
                    CustomText(
                      text: (widget.recipe.categories ?? []).join(' · '),
                      color: ColorConstant.secondaryDark,
                      size: DimenConstant.xxsText,
                    ),
                    Separator(),
                  ],
                ),
              ),
              Separator(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => value.updateLikes(widget.id),
                    child: Row(
                      children: [
                        CustomIcon(
                          icon: value.recipes[widget.id]?.likes
                                      ?.contains(user.uid) ??
                                  false
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: value.recipes[widget.id]?.likes
                                      ?.contains(user.uid) ??
                                  false
                              ? ColorConstant.error
                              : null,
                        ),
                        Separator(width: DimenConstant.padding / 2),
                        Counter(
                          visible: (widget.recipe.shared ?? 0) != 0,
                          count: widget.recipe.likes?.length ?? 0,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => value.showViews(
                        context, widget.id, widget.recipe.views!),
                    child: Row(
                      children: [
                        CustomIcon(icon: Icons.visibility_rounded),
                        Separator(width: DimenConstant.padding / 2),
                        Counter(
                          visible: (widget.recipe.shared ?? 0) != 0,
                          count: widget.recipe.views ?? 0,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => value.updateShared(widget.id),
                    child: Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.share,
                          color: ColorConstant.secondaryLight,
                          size: 18,
                        ),
                        Separator(width: DimenConstant.padding / 2),
                        Counter(
                          visible: (widget.recipe.shared ?? 0) != 0,
                          count: widget.recipe.shared ?? 0,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => value.updateFavourites(widget.id),
                    child: CustomIcon(
                      icon: value.favourites.contains(widget.id)
                          ? Icons.bookmark_rounded
                          : Icons.bookmark_border_rounded,
                      color: value.favourites.contains(widget.id)
                          ? ColorConstant.primary
                          : null,
                    ),
                  ),
                ],
              ),
              Separator(),
            ],
          ),
          Positioned(
            left: 20,
            child: CustomCircleAvatar(
              radius: 50,
              image: widget.recipe.image == null
                  ? AssetImage(ImageConstant.food)
                  : NetworkImage(widget.recipe.image ?? '') as ImageProvider,
              onPressed: () => value.updateViews(context, widget.id),
            ),
          ),
        ],
      ),
    );
  }
}
