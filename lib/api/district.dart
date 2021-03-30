import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:store_belahdoeren/global/variable.dart';
import 'package:store_belahdoeren/model/district_branch.dart';

Future<ApiListBranch> futureApiListBranches(String token) async{
  var dio = Dio();
  String url = "http://belahdoeren.wiradipa.com/api/v1/districts_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiListBranch.fromStringJson(response.toString());
}

class ApiListBranch {
  String status;
  String message;
  List<DistrictBranch> data;

  ApiListBranch({
    this.status,
    this.message,
    this.data});

  ApiListBranch.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = List<DistrictBranch>.from(json["data"].map((x) => DistrictBranch.fromJson(x)));

  ApiListBranch.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}