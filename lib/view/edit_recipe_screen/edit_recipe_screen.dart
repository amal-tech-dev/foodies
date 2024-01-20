import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodies/utils/color_constant.dart';
import 'package:foodies/utils/dimen_constant.dart';
import 'package:foodies/view/edit_recipe_screen/edit_recipe_widgets/recipe_form.dart';
import 'package:foodies/view/edit_recipe_screen/edit_recipe_widgets/recipe_preview.dart';

class EditRecipeScreen extends StatefulWidget {
  bool toAdd;
  EditRecipeScreen({
    super.key,
    required this.toAdd,
  });

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  bool isLoading = false;

  @override
  void initState() {
    isLoading = true;
    setState(() {});
    Timer(
      Duration(
        seconds: 3,
      ),
      () {
        isLoading = false;
        setState(() {});
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.backgroundColor,
        surfaceTintColor: Colors.transparent,
        leading: BackButton(
          color: ColorConstant.primaryColor,
        ),
        title: Text(
          widget.toAdd ? 'Add Recipe' : 'Edit your Recipe',
          style: TextStyle(
            color: ColorConstant.primaryColor,
            fontSize: DimenConstant.titleText,
          ),
        ),
      ),
      body: isLoading ? RecipePreview() : RecipeForm(),
    );
  }
}
