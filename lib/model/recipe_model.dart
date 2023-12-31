class RecipeModel {
  int id;
  String name;
  String cuisine;
  String description;
  String time;
  String? shef;
  bool veg;
  List categories;
  List ingredients;
  List steps;
  String imageUrl;

  RecipeModel({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.description,
    required this.time,
    required this.shef,
    required this.veg,
    required this.categories,
    required this.ingredients,
    required this.steps,
    required this.imageUrl,
  });
}
