import 'dart:convert';

class Profile {

  int id;
  String name;
  String token;
  String email;
  String phoneNumber;
  String address;
  int districtId;
  String districtName;
  int branchId;
  String branchName;
  String photo;

  Profile({
      this.id,
      this.name,
      this.token,
      this.email,
      this.phoneNumber,
      this.address,
      this.districtId,
      this.districtName,
      this.branchId,
      this.branchName,
      this.photo});

  Profile.fromJson(Map <String, dynamic> json) :
        id = json["id"],
        token = json[''],
        name = json["name"],
        email = json["email"],
        phoneNumber = json["phone_number"],
        address = json["address"],
        districtId = json["district_id"],
        districtName = json["district_name"],
        branchId = json["branch_id"],
        branchName = json["branch_name"],
        photo = json["photo"];

  Map<String, dynamic> toJson() => {
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
  };
}
