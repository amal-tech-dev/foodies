class RecipeModel {
  String? name;
  String? cuisine;
  String? description;
  String? time;
  String? chef;
  String? image;
  bool? veg;
  int? shared;
  List<String>? likes;
  List<String>? categories;
  List<String>? ingredients;
  List<String>? steps;

  RecipeModel({
    this.name,
    this.cuisine,
    this.description,
    this.time,
    this.chef,
    this.image,
    this.veg,
    this.shared,
    this.likes,
    this.categories,
    this.ingredients,
    this.steps,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
        name: json["name"],
        cuisine: json["cuisine"],
        description: json["description"],
        time: json["time"],
        chef: json["chef"],
        image: json["image"],
        veg: json["veg"],
        shared: json["shared"],
        likes: json["likes"] == null
            ? []
            : List<String>.from(json["likes"]!.map((x) => x)),
        categories: json["categories"] == null
            ? []
            : List<String>.from(json["categories"]!.map((x) => x)),
        ingredients: json["ingredients"] == null
            ? []
            : List<String>.from(json["ingredients"]!.map((x) => x)),
        steps: json["steps"] == null
            ? []
            : List<String>.from(json["steps"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "cuisine": cuisine,
        "description": description,
        "time": time,
        "chef": chef,
        "image": image,
        "veg": veg,
        "shared": shared,
        "likes": likes == null ? [] : List<dynamic>.from(likes!.map((x) => x)),
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x)),
        "ingredients": ingredients == null
            ? []
            : List<dynamic>.from(ingredients!.map((x) => x)),
        "steps": steps == null ? [] : List<dynamic>.from(steps!.map((x) => x)),
      };
}
