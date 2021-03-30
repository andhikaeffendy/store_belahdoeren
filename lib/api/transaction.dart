import 'dart:io';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:store_belahdoeren/global/variable.dart';
import 'package:store_belahdoeren/model/ItemsTransaction.dart';
import 'package:store_belahdoeren/model/global_response.dart';
import 'package:store_belahdoeren/model/past_transaction.dart';
import 'package:store_belahdoeren/model/transaction_detail.dart';

Future<ApiListPastTransaction> futureApiListPastTransaction(String token) async{
  var dio = Dio();
  String url = api_url + "past_transactions_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiListPastTransaction.fromStringJson(response.toString());
}

Future<ApiListPickup> futureApiListPickup(String token) async{
  var dio = Dio();
  String url = api_url + "pickup_transactions_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiListPickup.fromStringJson(response.toString());
}

Future<ApiListDelivery> futureApiListDelivery(String token) async{
  var dio = Dio();
  String url = api_url + "delivery_transactions_list";
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiListDelivery.fromStringJson(response.toString());
}

Future<ApiDetailOrder> futureDetailOrder(String token, int id) async{
  var dio = Dio();
  String url = api_url + "transaction_detail/" + id.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  Response response = await dio.get(url);
  print(response.data);

  return ApiDetailOrder.fromStringJson(response.toString());
}

Future<GlobalResponse> futureApiCloseTransaction(String token, int id) async{
  var dio = Dio();
  String url = api_url + "close_transaction/" + id.toString();
  dio.options.headers[HttpHeaders.authorizationHeader] =
      'Bearer ' + token;
  FormData formData = new FormData.fromMap({
    "id" : id
  });
  Response response = await dio.post(url, data: formData);
  print(response.data);

  return GlobalResponse.fromStringJson(response.toString());
}

class ApiListPastTransaction{
  String status;
  String message;
  List<PastTransaction> data;

  ApiListPastTransaction({
    this.status,
    this.message,
    this.data,
  });

  ApiListPastTransaction.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = List<PastTransaction>.from(json["data"].map((x) => PastTransaction.fromJson(x)));

  ApiListPastTransaction.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}

class ApiListDelivery{
  String status;
  String message;
  List<PastTransaction> data;

  ApiListDelivery({
    this.status,
    this.message,
    this.data,
  });

  ApiListDelivery.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = List<PastTransaction>.from(json["data"].map((x) => PastTransaction.fromJson(x)));

  ApiListDelivery.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}

class ApiListPickup{
  String status;
  String message;
  List<PastTransaction> data;

  ApiListPickup({
    this.status,
    this.message,
    this.data,
  });

  ApiListPickup.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = List<PastTransaction>.from(json["data"].map((x) => PastTransaction.fromJson(x)));

  ApiListPickup.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}

class ApiDetailOrder{
  String status;
  String message;
  TransactionDetail data;
  List<ItemsTransaction> items;

  ApiDetailOrder({
    this.status,
    this.message,
    this.data,
    this.items
  });

  ApiDetailOrder.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"],
        data = TransactionDetail.fromJson(json),
        items = List<ItemsTransaction>.from(json["items"].map((x) => ItemsTransaction.fromJson(x)));

  ApiDetailOrder.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data" : data.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status == "success";
}