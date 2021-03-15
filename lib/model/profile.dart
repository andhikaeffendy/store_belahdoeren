import 'dart:convert';

class Profile {
  Profile({
    this.id,
    this.token,
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
    this.districtId,
    this.districtName,
    this.branchId,
    this.branchName,
    this.photo,
    this.status,
    this.message,
  });

  int id;
  String name;
  String token;
  String email;
  dynamic phoneNumber;
  dynamic address;
  dynamic districtId;
  String districtName;
  int branchId;
  String branchName;
  String photo;
  String status;
  String message;

  factory Profile.fromJson(String str) => Profile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
    id: json["id"],
    token: json[''],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phone_number"],
    address: json["address"],
    districtId: json["district_id"],
    districtName: json["district_name"],
    branchId: json["branch_id"],
    branchName: json["branch_name"],
    photo: json["photo"],
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_number": phoneNumber,
    "address": address,
    "district_id": districtId,
    "district_name": districtName,
    "branch_id": branchId,
    "branch_name": branchName,
    "photo": photo,
    "status": status,
    "message": message,
  };
}
