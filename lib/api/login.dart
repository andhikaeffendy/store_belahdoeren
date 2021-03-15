import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:store_belahdoeren/global/variable.dart';
import 'package:store_belahdoeren/model/profile.dart';
import 'package:store_belahdoeren/model/user_session.dart';

Future<ApiLogin> futureApiLogin(String email, String password) async{
  var dio = Dio();
  String url = api_url + "login";
  FormData formData = new FormData.fromMap({
    "email": email,
    "password": password,
  });
  Response response = await dio.post(url, data: formData);
  print(response.data);

  return ApiLogin.fromStringJson(response.toString());
}

class ApiLogin {
  String status;
  String message;
  User user;

  ApiLogin({
    this.status,
    this.message,
    this.user,
  });

  ApiLogin.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        user = User.fromJson(json);

  ApiLogin.fromStringJson(String stringJson) :
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