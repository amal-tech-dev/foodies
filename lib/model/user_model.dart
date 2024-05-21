class UserModel {
  String? username;
  String? name;
  String? bio;
  String? profile;
  bool? verified;
  List<String>? favourites;
  List<String>? recipes;
  List<String>? followers;
  List<String>? following;

  UserModel({
    this.username,
    this.name,
    this.bio,
    this.profile,
    this.verified,
    this.favourites,
    this.recipes,
    this.followers,
    this.following,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        name: json["name"],
        bio: json["bio"],
        profile: json["profile"],
        verified: json["verified"],
        favourites: json["favourites"] == null
            ? []
            : List<String>.from(json["favourites"]!.map((x) => x)),
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
        "verified": verified,
        "favourites": favourites == null
            ? []
            : List<dynamic>.from(favourites!.map((x) => x)),
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
