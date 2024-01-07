class RecipeModel {
  int id;
  String name;
  String cuisine;
  String description;
  String time;
  String image;
  String? chef;
  bool veg;
  List categories;
  List ingredients;
  List steps;

  RecipeModel({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.description,
    required this.time,
    required this.image,
    required this.chef,
    required this.veg,
    required this.categories,
    required this.ingredients,
    required this.steps,
  });
}
