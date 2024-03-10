class RecipeModel {
  String? name;
  String? cuisine;
  String? description;
  String? time;
  String? chef;
  String? image;
  bool? veg;
  int? shared;
  int? views;
  List<String>? likes;
  List<String>? categories;
  List<String>? ingredients;
  List<String>? steps;
  List<Rating>? rating;
  List<Review>? reviews;

  RecipeModel({
    this.name,
    this.cuisine,
    this.description,
    this.time,
    this.chef,
    this.image,
    this.veg,
    this.shared,
    this.views,
    this.likes,
    this.categories,
    this.ingredients,
    this.steps,
    this.rating,
    this.reviews,
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
        views: json["views"],
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
        rating: json["rating"] == null
            ? []
            : List<Rating>.from(json["rating"]!.map((x) => Rating.fromJson(x))),
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
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
        "views": views,
        "likes": likes == null ? [] : List<dynamic>.from(likes!.map((x) => x)),
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x)),
        "ingredients": ingredients == null
            ? []
            : List<dynamic>.from(ingredients!.map((x) => x)),
        "steps": steps == null ? [] : List<dynamic>.from(steps!.map((x) => x)),
        "rating": rating == null
            ? []
            : List<dynamic>.from(rating!.map((x) => x.toJson())),
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
      };
}

class Rating {
  String? uid;
  int? rating;

  Rating({
    this.uid,
    this.rating,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        uid: json["uid"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "rating": rating,
      };
}

class Review {
  String? uid;
  String? review;

  Review({
    this.uid,
    this.review,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        uid: json["uid"],
        review: json["review"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "review": review,
      };
}
