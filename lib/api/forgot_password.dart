import 'dart:io';
import 'package:dio/dio.dart';
import 'package:store_belahdoeren/global/variable.dart';
import 'package:store_belahdoeren/model/global_response.dart';

Future<GlobalResponse> futureApiForgotPassword(String email) async{
  var dio = Dio();
  String url = api_url + "reset_password/" + email;
  FormData formData = new FormData.fromMap({
    "email" : email
  });
  Response response = await dio.post(url, data: formData);
  print(response.data);

  return GlobalResponse.fromStringJson(response.toString());
}