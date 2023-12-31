class RecipeModel {
  String name;
  String cuisine;
  String category;
  String description;
  String time;
  String? shef;
  bool veg;
  List ingredients;
  List steps;
  String imageUrl;

  RecipeModel({
    required this.name,
    required this.cuisine,
    required this.category,
    required this.description,
    required this.time,
    required this.shef,
    required this.veg,
    required this.ingredients,
    required this.steps,
    required this.imageUrl,
  });
}
