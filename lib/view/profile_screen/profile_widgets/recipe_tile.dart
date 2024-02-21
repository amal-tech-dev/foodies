import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/utils/image_constant.dart';

class RecipeTile extends StatefulWidget {
  String id;
  RecipeTile({
    super.key,
    required this.id,
  });

  @override
  State<RecipeTile> createState() => _RecipeTileState();
}

class _RecipeTileState extends State<RecipeTile> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? name, image;

  @override
  void initState() {
    getRecipe();
    super.initState();
  }

  // get recipe from firebase
  getRecipe() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: DimenConstant.padding,
        horizontal: DimenConstant.padding,
      ),
      decoration: BoxDecoration(
        color: ColorConstant.tertiaryColor,
        borderRadius: BorderRadius.circular(
          DimenConstant.borderRadius * 2,
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(
              ImageConstant.profile,
            ),
          ),
          DimenConstant.separator,
          Text(
            'Guest',
            style: TextStyle(
              color: ColorConstant.primaryColor,
              fontSize: DimenConstant.mediumText,
            ),
          ),
        ],
      ),
    );
  }
}
