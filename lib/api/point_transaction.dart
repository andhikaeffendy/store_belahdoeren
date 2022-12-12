import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:store_belahdoeren/global/variable.dart';
import 'package:store_belahdoeren/model/global_response.dart';
import 'package:store_belahdoeren/model/point_transaction.dart';

Future<ApiPointTransaction> futureApiPointTransaction(String token) async{
  var dio = Dio();
  String url = api_url + "point_transactions_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.get(url);
    // print(response.data);
    return ApiPointTransaction.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return ApiPointTransaction(status: "fail", message: "error server");
    } else {
      return ApiPointTransaction(status: "fail", message: "error system");
    }
  }
}

Future<GlobalResponse> futureApiClosePointsTransaction(String token,
    int id) async{
  var dio = Dio();
  String url = api_url + "close_point_transaction/$id";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  try {
    Response response = await dio.post(url);
    // print(response.data);
    return GlobalResponse.fromStringJson(response.toString());
  } on DioError catch (e) {
    if (e.response != null ) {
      return GlobalResponse(status: "fail", message: "error server");
    } else {
      return GlobalResponse(status: "fail", message: "error system");
    }
  }
}
class ApiPointTransaction{
  String status;
  String message;
  List<PointTransaction> data;

  ApiPointTransaction({this.status, this.message, this.data});

  ApiPointTransaction.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = json.containsKey("data") ? List<PointTransaction>.from(json["data"].map((x) => PointTransaction.fromJson(x))) : null;

  ApiPointTransaction.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS";
}