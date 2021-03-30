import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:store_belahdoeren/global/variable.dart';
import 'package:store_belahdoeren/model/profile.dart';
import 'package:store_belahdoeren/model/user_session.dart';

Future<ApiProfile> futureApiProfile(String token) async{
  var dio = Dio();
  String url = api_url + "profile";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiProfile.fromStringJson(response.toString());
}

Future<ApiProfile> futureApiUpdateProfile(String token, String phone_number, int gender, String address, int district_id, String district_name, String photo) async{
  var dio = Dio();
  String url = api_url + "update_profile";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  FormData formData = new FormData.fromMap({
    "phone_number": phone_number,
    "gender": gender,
    "address" : address,
    "district_id" : district_id,
    "district_name" : district_name,
    "photo" : await MultipartFile.fromFile(currentImage.path)
  });
  Response response = await dio.post(url, data: formData);
  print(response.data);

  return ApiProfile.fromStringJson(response.toString());
}

Future<ApiEditProfile> futureApiEditProfile(String token) async{
  var dio = Dio();
  String url = api_url + "profile";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiEditProfile .fromStringJson(response.toString());
}

class ApiProfile {
  String status;
  String message;
  User user;

  ApiProfile({
    this.status,
    this.message,
    this.user,
  });

  ApiProfile.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        user = User.fromJson(json);

  ApiProfile.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "id": user.id,
    "name": user.name,
    "email": user.email,
    "id_token": user.token,
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}

class ApiEditProfile{
  String status;
  String message;
  Profile data;

  ApiEditProfile({this.status, this.message, this.data});

  ApiEditProfile.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = Profile.fromJson(json);

  ApiEditProfile.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status" : status,
    "message" : message,
    "data" : data.toJson()
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}