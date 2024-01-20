import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class RecipeDetails extends StatelessWidget {
  RecipeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: DimenConstant.edgePadding * 1.5,
          ),
          decoration: BoxDecoration(
            color: ColorConstant.tertiaryColor,
            borderRadius: BorderRadius.circular(
              DimenConstant.borderRadius,
            ),
          ),
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              label: Text(
                'Name',
                style: TextStyle(
                  color: ColorConstant.secondaryColor,
                ),
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: ColorConstant.primaryColor,
            ),
            cursorColor: ColorConstant.secondaryColor,
            cursorRadius: Radius.circular(
              DimenConstant.cursorRadius,
            ),
          ),
        ),
        DimenConstant.separator,
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: DimenConstant.edgePadding * 1.5,
          ),
          decoration: BoxDecoration(
            color: ColorConstant.tertiaryColor,
            borderRadius: BorderRadius.circular(
              DimenConstant.borderRadius,
            ),
          ),
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              label: Text(
                'Description',
                style: TextStyle(
                  color: ColorConstant.secondaryColor,
                ),
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(
              color: ColorConstant.primaryColor,
            ),
            cursorColor: ColorConstant.secondaryColor,
            cursorRadius: Radius.circular(
              DimenConstant.cursorRadius,
            ),
            maxLines: 4,
          ),
        ),
      ],
    );
  }
}
