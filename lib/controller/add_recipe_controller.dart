import 'package:flutter/material.dart';
import 'package:foodies/controller/page_view_controller.dart';
import 'package:foodies/model/recipe_model.dart';

class AddRecipeController with ChangeNotifier {
  RecipeModel editedRecipe = RecipeModel();
  PageViewController pageViewController = PageViewController();

  // get existing recipe
  update({required RecipeModel recipe}) {
    editedRecipe = recipe;
    notifyListeners();
  }

  // reset recipe
  clear() {
    editedRecipe = RecipeModel(
      name: '',
      cuisine: '',
      about: '',
      time: '',
      image: '',
      chef: '',
      veg: true,
      categories: [],
      ingredients: [],
      steps: [],
    );
    notifyListeners();
  }
}
