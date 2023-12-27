import 'package:foodies/generated/assets.dart';
import 'package:foodies/model/recipe_model.dart';

class Database {
  static List<RecipeModel> recipes = [
    RecipeModel(
      name: 'BBQ Chicken',
      cuisine: 'BBQ',
      description:
          'Barbecue chicken consists of chicken parts or entire chickens that are barbecued, grilled or smoked. There are many global and regional preparation techniques and cooking styles. Barbecue chicken is often seasoned or coated in a spice rub, barbecue sauce, or both.',
      time: '6 to 10 mins for boneless and 10 to 14 mins for bone-in',
      shef: null,
      veg: false,
      ingredients: [],
      steps: [],
      imageUrl: Assets.imagesBbqChickenImage,
    ),
  ];
}
