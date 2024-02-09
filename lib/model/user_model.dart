class UserModel {
  String? username;
  String? name;
  String? bio;
  String? profile;
  String? cover;
  List<String>? menu;
  List<String>? recipes;

  UserModel({
    this.username,
    this.name,
    this.bio,
    this.profile,
    this.cover,
    this.menu,
    this.recipes,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        name: json["name"],
        bio: json["bio"],
        profile: json["profile"],
        cover: json["cover"],
        menu: json["menu"] == null
            ? []
            : List<String>.from(json["menu"]!.map((x) => x)),
        recipes: json["recipes"] == null
            ? []
            : List<String>.from(json["recipes"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "bio": bio,
        "profile": profile,
        "cover": cover,
        "menu": menu == null ? [] : List<dynamic>.from(menu!.map((x) => x)),
        "recipes":
            recipes == null ? [] : List<dynamic>.from(recipes!.map((x) => x)),
      };
}
