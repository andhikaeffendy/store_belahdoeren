import 'dart:io';
import 'package:dio/dio.dart';
import 'package:store_belahdoeren/global/variable.dart';
import 'package:store_belahdoeren/model/global_response.dart';

Future<GlobalResponse> futureApiLogout(String token) async{
  var dio = Dio();
  String url = api_url + "logout";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.post(url);
  print(response.data);

  return GlobalResponse.fromStringJson(response.toString());
}