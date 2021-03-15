class User{
  int id;
  String name;
  String email;
  String token;

  User(
      this.id,
      this.email,
      this.name,
      this.token
      );

  User.fromJson(Map<String, dynamic> json) :
        id = json["id"],
        email = json["email"],
        name = json["name"],
        token = json["id_token"];

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "id_token": token,
  };
}