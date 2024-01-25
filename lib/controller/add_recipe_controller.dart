import 'package:flutter/material.dart';
import 'package:foodies/controller/carousel_slider_controller.dart';
import 'package:foodies/model/recipe_model.dart';

class AddRecipeController with ChangeNotifier {
  RecipeModel editedRecipe = RecipeModel(
    id: 0,
    name: '',
    cuisine: '',
    description: '',
    time: '',
    image: '',
    chef: '',
    veg: true,
    categories: [],
    ingredients: [],
    steps: [],
  );
  CarouselSliderController carouselSliderController =
      CarouselSliderController();

  // get existing recipe
  update({required RecipeModel recipe}) {
    editedRecipe = recipe;
    notifyListeners();
  }

  // reset recipe
  clear() {
    editedRecipe = RecipeModel(
      id: 0,
      name: '',
      cuisine: '',
      description: '',
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
