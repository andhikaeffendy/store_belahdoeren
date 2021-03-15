import 'dart:convert';

class GlobalResponse {
  String status;
  String message;

  GlobalResponse({
    this.status,
    this.message,
  });

  GlobalResponse.fromJson(Map<String, dynamic> json) :
        status = json["status"],
        message = json["message"];

  GlobalResponse.fromStringJson(String stringJson) :
        this.fromJson(json.decode(stringJson));

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };

  String toStringJson() => json.encode(this.toJson());

  bool isSuccess() => status.toUpperCase() == "SUCCESS" ;
}