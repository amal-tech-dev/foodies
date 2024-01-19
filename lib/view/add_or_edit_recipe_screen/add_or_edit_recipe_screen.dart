import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';

class AddOrEditRecipeScreen extends StatelessWidget {
  bool toAdd;
  AddOrEditRecipeScreen({
    super.key,
    required this.toAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundColor,
        surfaceTintColor: Colors.transparent,
        title: Text(
          toAdd ? 'Add Recipe' : 'Edit your Recipe',
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.titleText,
          ),
        ),
      ),
    );
  }
}
