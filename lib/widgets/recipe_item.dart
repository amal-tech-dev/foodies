import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/model/recipe_model.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class RecipeItem extends StatefulWidget {
  String id;
  RecipeModel recipe;
  VoidCallback onPressed;

  RecipeItem({
    super.key,
    required this.id,
    required this.recipe,
    required this.onPressed,
  });

  @override
  State<RecipeItem> createState() => _RecipeItemState();
}

class _RecipeItemState extends State<RecipeItem> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  int likes = 0, shared = 0;

  @override
  void initState() {
    likes = widget.recipe.likes ?? 0;
    shared = widget.recipe.shared ?? 0;
    setState(() {});
    super.initState();
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
                onTap: widget.onPressed,
                child: Container(
                  padding: EdgeInsets.all(
                    DimenConstant.padding,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: widget.recipe.veg!
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
                              widget.recipe.name!,
                              style: TextStyle(
                                color: ColorConstant.primaryColor,
                                fontSize: DimenConstant.extraSmallText,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              widget.recipe.cuisine!,
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
                        widget.recipe.description!,
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
                        widget.recipe.categories!.join(' · '),
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
              Padding(
                padding: const EdgeInsets.all(
                  DimenConstant.padding,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_outline_rounded,
                          color: ColorConstant.errorColor,
                        ),
                        StreamBuilder(
                          stream: firestore
                              .collection('recipes')
                              .doc(widget.id)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              var data = snapshot.data!.data();
                              likes = data!['likes'] as int;
                            }
                            return Text(
                              likes.toString(),
                              style: TextStyle(
                                color: ColorConstant.errorColor,
                                fontSize: DimenConstant.extraSmallText,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_outline_rounded,
                          color: ColorConstant.errorColor,
                        ),
                        StreamBuilder(
                          stream: firestore
                              .collection('recipes')
                              .doc(widget.id)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              var data = snapshot.data!.data();
                              likes = data!['likes'] as int;
                            }
                            return Text(
                              likes.toString(),
                              style: TextStyle(
                                color: ColorConstant.errorColor,
                                fontSize: DimenConstant.extraSmallText,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_outline_rounded,
                          color: ColorConstant.errorColor,
                        ),
                        StreamBuilder(
                          stream: firestore
                              .collection('recipes')
                              .doc(widget.id)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              var data = snapshot.data!.data();
                              likes = data!['likes'] as int;
                            }
                            return Text(
                              likes.toString(),
                              style: TextStyle(
                                color: ColorConstant.errorColor,
                                fontSize: DimenConstant.extraSmallText,
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          child: InkWell(
            onTap: widget.onPressed,
            child: CircleAvatar(
              radius: 50,
              foregroundImage: NetworkImage(
                widget.recipe.image!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
