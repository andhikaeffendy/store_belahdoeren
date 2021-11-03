import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:store_belahdoeren/global/variable.dart';
import 'package:store_belahdoeren/model/category.dart';
import 'package:store_belahdoeren/model/global_response.dart';
import 'package:store_belahdoeren/model/produk.dart';

Future<ApiProdukList> futureApiProdukList(String token, int id) async{
  var dio = Dio();
  String url = api_url + "menus_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url, queryParameters: {"menu_category_id" : id});
  print(response.data);

  return ApiProdukList.fromStringJson(response.toString());
}

Future<ApiMenuCategory> futureApiMenuCategory(String token) async{
  var dio = Dio();
  String url = api_url + "menu_categories_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiMenuCategory.fromStringJson(response.toString());
}

Future<GlobalResponse> futureApiSetMenuReady(String token, int id) async{
  var dio = Dio();
  String url = api_url + "set_menu_ready/" + id.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.post(url);
  print(response.data);

  return GlobalResponse.fromStringJson(response.toString());
}

Future<GlobalResponse> futureApiSetMenuNotReady(String token, int id) async{
  var dio = Dio();
  String url = api_url + "set_menu_not_ready/" + id.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.post(url);
  print(response.data);

  return GlobalResponse.fromStringJson(response.toString());
}

class ApiProdukList{
  String status;
  String message;
  List<Produk> data;

  ApiProdukList({
    this.status,
    this.message,
    this.data,
  });

  ApiProdukList.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = List<Produk>.from(json["data"].map((x) => Produk.fromJson(x)));

  ApiProdukList.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}

class ApiMenuCategory{
  String status;
  String message;
  List<Category> data;

  ApiMenuCategory({
    this.status,
    this.message,
    this.data,
  });

  ApiMenuCategory.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = List<Category>.from(json["data"].map((x) => Category.fromJson(x)));

  ApiMenuCategory.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}