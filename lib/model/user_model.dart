class UserModel {
  String? username;
  String? name;
  String? bio;
  String? profile;
  String? cover;
  bool? verified;
  List<String>? menu;
  List<String>? recipes;
  List<String>? followers;
  List<String>? following;

  UserModel({
    this.username,
    this.name,
    this.bio,
    this.profile,
    this.cover,
    this.verified,
    this.menu,
    this.recipes,
    this.followers,
    this.following,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        name: json["name"],
        bio: json["bio"],
        profile: json["profile"],
        cover: json["cover"],
        verified: json["verified"],
        menu: json["menu"] == null
            ? []
            : List<String>.from(json["menu"]!.map((x) => x)),
        recipes: json["recipes"] == null
            ? []
            : List<String>.from(json["recipes"]!.map((x) => x)),
        followers: json["followers"] == null
            ? []
            : List<String>.from(json["followers"]!.map((x) => x)),
        following: json["following"] == null
            ? []
            : List<String>.from(json["following"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "bio": bio,
        "profile": profile,
        "cover": cover,
        "verified": verified,
        "menu": menu == null ? [] : List<dynamic>.from(menu!.map((x) => x)),
        "recipes":
            recipes == null ? [] : List<dynamic>.from(recipes!.map((x) => x)),
        "followers": followers == null
            ? []
            : List<dynamic>.from(followers!.map((x) => x)),
        "following": following == null
            ? []
            : List<dynamic>.from(following!.map((x) => x)),
      };
}
