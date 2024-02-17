class UserModel {
  String? username;
  String? name;
  String? bio;
  String? profile;
  String? cover;
  int? followers;
  int? following;
  List<String>? menu;

  UserModel({
    this.username,
    this.name,
    this.bio,
    this.profile,
    this.cover,
    this.followers,
    this.following,
    this.menu,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        name: json["name"],
        bio: json["bio"],
        profile: json["profile"],
        cover: json["cover"],
        followers: json["followers"],
        following: json["following"],
        menu: json["menu"] == null
            ? []
            : List<String>.from(json["menu"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "name": name,
        "bio": bio,
        "profile": profile,
        "cover": cover,
        "followers": followers,
        "following": following,
        "menu": menu == null ? [] : List<dynamic>.from(menu!.map((x) => x)),
      };
}
